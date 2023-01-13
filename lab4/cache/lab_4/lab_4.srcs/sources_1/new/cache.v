module cache(
    input            clk             ,  // clock, 100MHz
    input            rst             ,  // active low

    //  Sram-Like�ӿ��źŶ���:
    //  1. cpu_req     ��ʶCPU��Cache����ô�������źţ���CPU��Ҫ��Cache��ȡ����ʱ�����ź���Ϊ1
    //  2. cpu_addr    CPU��Ҫ��ȡ�������ڴ洢���еĵ�ַ,���ô��ַ
    //  3. cache_rdata ��Cache�ж�ȡ�����ݣ���Cache��CPU����
    //  4. cache_addr_ok     ��ʶCache��CPU��ַ���ֳɹ����źţ�ֵΪ1����Cache�ɹ�����CPU���͵ĵ�ַ
    //  5. cache_data_ok     ��ʶCache��CPU������ݴ��͵��źţ�ֵΪ1����CPU�ڱ�ʱ��������������ݽ���
    input         cpu_req      ,    //��CPU������Cache
    input  [31:0] cpu_addr     ,    //��CPU������Cache
    output [31:0] cache_rdata  ,    //��Cache���ظ�CPU
    output        cache_addr_ok,    //��Cache���ظ�CPU
    output        cache_data_ok,    //��Cache���ظ�CPU

    //  AXI�ӿ��źŶ���:
    //  Cache��AXI�����ݽ�����Ϊ�����׶Σ���ַ���ֽ׶κ��������ֽ׶�
    output [3 :0] arid   ,              //Cache�����淢�������ʱʹ�õ�AXI�ŵ���id�ţ�����Ϊ0����
    output [31:0] araddr ,              //Cache�����淢�������ʱ��ʹ�õĵ�ַ
    output        arvalid,              //Cache�����淢�������������ź�
    input         arready,              //�������ܷ񱻽��յ������ź�

    input  [3 :0] rid    ,              //������Cache��������ʱʹ�õ�AXI�ŵ���id�ţ�����Ϊ0����
    input  [31:0] rdata  ,              //������Cache���ص�����
    input         rlast  ,              //�Ƿ���������Cache���ص����һ������
    input         rvalid ,              //������Cache��������ʱ��������Ч�ź�
    output        rready                //��ʶ��ǰ��Cache�Ѿ�׼���ÿ��Խ������淵�ص�����  
);

    //7��״̬��
    /*
        IDLE ��ת״̬�� Cache �ָ���������ǰ�Ļ���״̬��������һ��ʱ������ת�Ƶ�����״̬��
        RUN ����״̬�� Cache ����������ȱʧ�������ķ������ݵ�״̬����������ȱʧ����Ŀ¼�����
                        hit = 0 ʱ�򣬻����ѡ·״̬��ʼ���� Cache ���滻�͸��¡�
        SEL_WAY ѡ·״̬����� Cache ��������ȱʧ���ͻ������һ״̬�������� LRU �㷨����ѡ·��Ϊ��
                    ���� Cache ���滻�͸�����׼���� Cache ÿ��ֻ���ڸ�״̬ͣ��һ������ȷ��ѡ·��Ȼ����
                    ����ת��ȱʧ״̬��
        MISS ȱʧ״̬������ lru ���������洢��������������󣬼��� AXI ���߷��� arvalid = 1��
                    ͬʱ�������ݵ�ַ�������ȡ Cache ��δ���е��У�������洢�������˶����󣬼� AXI ��
                    �߷��� arready = 1���� Cache ���뵽��������״̬���շ��ص����ݡ�
        REFILL ��������״̬�� Cache �������洢�����ص����ݣ�������ѡ·״̬������ѡ·�������Ŀ¼
                    ������ݿ飬״̬���������ݴ�����ɣ��� AXI ���߷��� rvalid = 1 && rlast = 1��
        FINISH �������״̬����־ Cache ������ɣ� Cache ������һ��ʱ�����ڻص�����״̬�����½���
                �ϴ�δ���еķô档
        RESETN ��ʼ��״̬�������ڴ�������ʼ��ʱ��� cache������ 128 ��ʱ�����ڣ�ÿ���������һ�С�
    */
    parameter IDLE    = 0;
    parameter RUN     = 1;
    parameter SEL_WAY = 2;
    parameter MISS    = 3;
    parameter REFILL  = 4;
    parameter FINISH  = 5;
    parameter RESETN   = 6;

    reg [2:0] state; //���Զ�����״̬
    reg [6:0] counter;//������0-127��128����
   
    wire hit;//�����н��
    wire hit_way;//���е�·
    wire tmp_hit;

   
    //��ַ��ˮ�� request_buffer
    wire [31:0] current_addr;
    wire [19:0] current_tag;
    wire [6:0] current_index;
    wire [4:0] current_offset;
    assign current_addr = cpu_addr;
    assign current_tag = cpu_addr[31:12];
    assign current_index = cpu_addr[11:5];
    assign current_offset = cpu_addr[4:0];
    
    reg        last_req ;
    reg [31:0] last_addr;
    reg [19:0] last_tag    ;
    reg [6 :0] last_index  ;
    reg [4 :0] last_offset ;
    
    reg [31:0] ll_address;//���ϸ�ָ���ַ
    reg [19:0] ll_tag;
    reg [6:0] ll_index;
    reg [4:0] ll_offset;
   
    always @(posedge clk) begin
        if (!rst) begin
            last_req <= 0;
            last_addr <= 0;
            last_tag <= 0;
            last_index <= 0;
            last_offset <= 0;
            ll_address <= 0;
            ll_tag <= 0;
            ll_index <= 0;
            ll_offset <= 0;
        end
        else if (cpu_req & (state == RUN)) begin        //!!!!!
            last_req <= cpu_req;
            last_addr <= current_addr;
            last_tag <= current_tag;
            last_index <= current_index;
            last_offset <= current_offset;
            ll_address <= last_addr;
            ll_tag <= last_tag; 
            ll_index <= last_index;
            ll_offset <= last_offset;            
        end
        else begin
        end
    end
   
    //����ģ�飺LRUģ�� + ״̬�Զ���ģ��
    //����ģ��֮״̬�Զ���ģ��
    always @(posedge clk) begin
        if (!rst) begin//�����ź�Ϊ0��״̬����ΪRESETN ��˵����Ҫ��ʼ��
            state <= RESETN ;
        end
        else begin
            /*TODO��������Ƶ��Զ�����״̬ת�ƹ������ʵ��*/
            case(state)
                IDLE : state <= RUN;//һ�����ĺ��Զ���ת
                RUN : state <= (last_req && !tmp_hit)? SEL_WAY : RUN;
                SEL_WAY :state <= MISS;
                MISS : state <= (arready == 1)? REFILL: MISS;
                REFILL: state <= (rlast == 1)? FINISH :REFILL;
                FINISH : state <= RUN;
                RESETN : state <= (counter == 127 )? IDLE : RESETN ;//�����128�ģ�����ת����һ��״̬IDLE
                default : state <= IDLE;
            endcase
        end
    end
        
    assign cache_addr_ok = (cpu_req == 1 )&& (state == RUN);

    //����ģ��֮LRUģ��
    //��ģ���Ϊ�����֣�
    //��1��LRUѡ·��������SEL_WAYʱ����ѡ·��һ������������
    //��2��LRU���£�����ѡ·�������LRU����£�һ��������ɣ��ý��ı��Ұ�������SEL_WAY���Ľ����ŵ���һ�����ģ�Ҳ����MISS״̬
    //ע�⣺MISS״̬���ܳ����ü������ģ�AXI���߷�������aaready�Ƿ�Ϊ1��Ϊ1������һ�����ı��REFILL״̬   
    //lru��
    reg [127:0] lru;//������·��lru�����Ϊ128��*1�У���n��Ϊ0��ʾ��0���õ��٣�ѡ���0��
    reg [1:0] selway;//ѡ·�Ľ����01��ʾѡ���0·��10��ʾѡ���1·
    // �����Լ����������ɾ�Ĵ���
    //��1��LRUѡ·
    always@(posedge clk) begin
        if(!rst) begin
            selway <= 0;
            //lru <= 0;
        end
        else if(state == SEL_WAY)begin
            case(lru[ll_index])
                1'b0: selway <= 2'b01;
                1'b1: selway <= 2'b10;
                default:;
            endcase
        end
        else begin
        end
    end 
    //��2��lru�����(һ�ľ͹������ǳ�������MISS״̬����ҲûӰ�죩:���������RUN����/MISS������
    always@(posedge clk) begin
        if(!rst) begin//����ʱ����lru����գ�����ѡ���0·
            lru <= 0;
        end
        else if(state == MISS)begin//MISS������
            case(selway)
                2'b01: lru[ll_index] <= 1'b1;//���ѡ·���Ϊ01��˵��ѡ���0·����ʹ�ã���ô��1·�ͽ���Ϊ�������ʹ��
                2'b10: lru[ll_index] <= 1'b0;
                default:;
            endcase
        end
        else if(state == RUN && hit == 1)begin//RUN����
            lru[ll_index] = ~hit_way;//hit_way�����е�·
        end
        else begin
        end
    end

    // RESETN״̬����state = RESETN��ʼ��0������ÿһ�ļ�һ��������128�ĺ�˵����ʼ�����
    initial begin
        counter <= 7'b0;
    end
    always@(posedge clk) begin
        if(!rst) begin
            counter <= 7'b0;//����������
        end
        else if(state == RESETN) begin//���ΪRESETN ״̬�����������1
            counter <= counter + 7'b1;
        end
        else begin
        end
    end

    //refillģ��
    reg [2:0] refill_counter;//��¼��ǰrefill��ָ�����
    always@(posedge clk) begin
        if(!rst) begin
            refill_counter <= 0;
        end
        else if(state == REFILL && rvalid) begin
            refill_counter <= refill_counter + 1;
        end
        else begin
        end
    end

    //Ŀ¼������ݿ�
    //Ŀ¼��
    //tagv_wen��Ŀ¼��дʹ�ܣ���nλ�����n·дʹ�ܣ�����Ч��,һ����������ı�ʹ���źſ���Ϊ1�����඼Ϊ0��
    //          RESETN״̬ʱ����ֵΪ11�����г�ʼ����
    //          cache������ʱ������LRU�Ľ��selway���и�ֵ,
    //          selwayΪ01����ʾѡ���0·���£�дʹ�ܸ�ֵ01����ʾ��0·Ŀ¼����Ա����£�����Ϊ����selway��
    //tagv_index����ΪĿ¼�����������в��ң�ͬʱ��������Ŀ¼��
    //          RESETN״̬ʱ����128���У�index��0���127������Ϊ����counter)
    //          RUN״̬ʱ��Ϊcpu�������ַ��ˮ�����last_index
    //          ����״̬Ϊll_index
    //tagv_tag����ʶ
    //          RUN״̬ʱ��Ϊ��ַ��ˮ�����last_tag
    //          ����״̬Ϊll_tag
    //valid_wdata��д����Чλ��ֵ
    //          RESETN ʱΪ0���������Ϊ1
    //hit_array :���н������n·Ϊ1����ʾ��n·����(n����2��
    wire [1 :0] tagv_wen;
    wire [6 :0] tagv_index;
    wire [19:0] tagv_tag;
    wire [31:0] valid_wdata;
    wire [1:0] hit_array;
    wire [1:0] tmp_hit_array;

    assign tagv_wen[0] = (state == RESETN  || (state == MISS && selway[0] == 1))? 1:0;
    assign tagv_wen[1] = (state == RESETN  || (state == MISS && selway[1] == 1))? 1:0;
    assign tagv_index  = (state == RESETN ) ? counter : ((state == RUN)?last_index : ll_index);
    assign tagv_tag    =  (state == RUN) ? last_tag:ll_tag;
    assign valid_wdata =  (state == RESETN )? 0:1;
    
    //���ݿ�(д�����������ʱ����Ҫ�������ݿ飩
    wire [31 :0] data_wen [1:0];
    wire [6  :0] data_index;
    wire [4  :0] data_offset;
    wire [255:0] data_wdata;
    wire [31 :0] data_rdata [1:0];
    wire [4:0] refill_wen;
    assign refill_wen = refill_counter << 2;//��¼��Ҫ���Ƶ�λ��
    assign data_wen[0] = ((selway[0] == 1 && rvalid && state == REFILL)) ? (32'hf0000000 >> refill_wen):0 ;
    assign data_wen[1] = ((selway[1] == 1 && rvalid && state == REFILL)) ? (32'hf0000000 >> refill_wen):0 ;
    assign data_index  = (state == RUN)? last_index : ll_index;
    assign data_offset = (state == RUN)? last_offset : ll_offset;
    assign data_wdata  = {8{rdata}} ;
    generate
        genvar j;
        for (j = 0 ; j < 2 ; j = j + 1) begin
            icache_tagv Cache_TagV (
                .clk        (clk         ),
                .wen        (tagv_wen[j] ),
                .index      (tagv_index  ),
                .tag        (tagv_tag    ),
                .valid_wdata(valid_wdata ),
                .hit        (hit_array[j]),
                .tmp_hit(tmp_hit_array[j])
            );
            icache_data Cache_Data (
                .clk          (clk          ),
                .wen          (data_wen[j]  ),
                .index        (data_index   ),
                .offset       (data_offset  ),
                .wdata        (data_wdata   ),
                .rdata        (data_rdata[j])
            );
        end
    endgenerate
    
    assign hit = (hit_array[0] || hit_array[1]) && (state == RUN);
    assign tmp_hit=(tmp_hit_array[0] | tmp_hit_array[1]) & (state==RUN);
    assign hit_way = (hit_array[0] == 1)? 0 : 1;//���е�����һ·
    
    /*------------ CPU<->Cache -------------*/
    //cache_addr_ok
    assign cache_data_ok = last_req && hit;
    assign cache_rdata = data_rdata[hit_way];

    /*-----------------Cache->AXI------------------*/
    // Read
    assign arid    = 4'd0;
    assign arvalid = (state == MISS)?1:0;  
    assign araddr  = ll_address & 32'hffffffe0;                       
    assign rready  = (state == REFILL)?1:0;    
endmodule
