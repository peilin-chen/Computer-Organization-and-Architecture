module cache(
    input            clk             ,  // clock, 100MHz
    input            rst             ,  // active low

    //  Sram-Like接口信号定义:
    //  1. cpu_req     标识CPU向Cache发起访存请求的信号，当CPU需要从Cache读取数据时，该信号置为1
    //  2. cpu_addr    CPU需要读取的数据在存储器中的地址,即访存地址
    //  3. cache_rdata 从Cache中读取的数据，由Cache向CPU返回
    //  4. cache_addr_ok     标识Cache和CPU地址握手成功的信号，值为1表明Cache成功接收CPU发送的地址
    //  5. cache_data_ok     标识Cache和CPU完成数据传送的信号，值为1表明CPU在本时钟周期内完成数据接收
    input         cpu_req      ,    //由CPU发送至Cache
    input  [31:0] cpu_addr     ,    //由CPU发送至Cache
    output [31:0] cache_rdata  ,    //由Cache返回给CPU
    output        cache_addr_ok,    //由Cache返回给CPU
    output        cache_data_ok,    //由Cache返回给CPU

    //  AXI接口信号定义:
    //  Cache与AXI的数据交换分为两个阶段：地址握手阶段和数据握手阶段
    output [3 :0] arid   ,              //Cache向主存发起读请求时使用的AXI信道的id号，设置为0即可
    output [31:0] araddr ,              //Cache向主存发起读请求时所使用的地址
    output        arvalid,              //Cache向主存发起读请求的请求信号
    input         arready,              //读请求能否被接收的握手信号

    input  [3 :0] rid    ,              //主存向Cache返回数据时使用的AXI信道的id号，设置为0即可
    input  [31:0] rdata  ,              //主存向Cache返回的数据
    input         rlast  ,              //是否是主存向Cache返回的最后一个数据
    input         rvalid ,              //主存向Cache返回数据时的数据有效信号
    output        rready                //标识当前的Cache已经准备好可以接收主存返回的数据  
);

    //7种状态：
    /*
        IDLE 空转状态， Cache 恢复正常工作前的缓冲状态，会在下一个时钟周期转移到运行状态。
        RUN 运行状态， Cache 不发生数据缺失正常两拍返回数据的状态。发生数据缺失，即目录表输出
                        hit = 0 时则，会进入选路状态开始进行 Cache 的替换和更新。
        SEL_WAY 选路状态，如果 Cache 发生数据缺失，就会进入这一状态，并根据 LRU 算法进行选路，为接
                    下来 Cache 的替换和更新做准备。 Cache 每次只会在该状态停留一拍用于确定选路，然后自
                    动跳转到缺失状态。
        MISS 缺失状态，更新 lru 表，并向主存储器发起读数据请求，即给 AXI 总线发送 arvalid = 1，
                    同时发送数据地址，请求读取 Cache 中未命中的行，如果主存储器接收了读请求，即 AXI 总
                    线返回 arready = 1，则 Cache 进入到数据重填状态接收返回的数据。
        REFILL 数据重填状态， Cache 接收主存储器传回的数据，并根据选路状态给出的选路结果更新目录
                    表和数据块，状态持续到数据传输完成，即 AXI 总线返回 rvalid = 1 && rlast = 1。
        FINISH 重填完成状态，标志 Cache 更新完成， Cache 将在下一个时钟周期回到运行状态，重新进行
                上次未命中的访存。
        RESETN 初始化状态，当用于处理器初始化时清空 cache，持续 128 个时钟周期，每个周期清空一行。
    */
    parameter IDLE    = 0;
    parameter RUN     = 1;
    parameter SEL_WAY = 2;
    parameter MISS    = 3;
    parameter REFILL  = 4;
    parameter FINISH  = 5;
    parameter RESETN   = 6;

    reg [2:0] state; //存自动机的状态
    reg [6:0] counter;//计数器0-127共128个数
   
    wire hit;//存命中结果
    wire hit_way;//命中的路
    wire tmp_hit;

   
    //地址流水段 request_buffer
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
    
    reg [31:0] ll_address;//上上个指令地址
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
   
    //控制模块：LRU模块 + 状态自动机模块
    //控制模块之状态自动机模块
    always @(posedge clk) begin
        if (!rst) begin//重置信号为0，状态设置为RESETN ，说明需要初始化
            state <= RESETN ;
        end
        else begin
            /*TODO：根据设计的自动机的状态转移规则进行实现*/
            case(state)
                IDLE : state <= RUN;//一个节拍后，自动跳转
                RUN : state <= (last_req && !tmp_hit)? SEL_WAY : RUN;
                SEL_WAY :state <= MISS;
                MISS : state <= (arready == 1)? REFILL: MISS;
                REFILL: state <= (rlast == 1)? FINISH :REFILL;
                FINISH : state <= RUN;
                RESETN : state <= (counter == 127 )? IDLE : RESETN ;//如果满128拍，则跳转到下一个状态IDLE
                default : state <= IDLE;
            endcase
        end
    end
        
    assign cache_addr_ok = (cpu_req == 1 )&& (state == RUN);

    //控制模块之LRU模块
    //该模块分为两部分：
    //（1）LRU选路，当处于SEL_WAY时进行选路，一个节拍输出结果
    //（2）LRU更新，根据选路结果进行LRU表更新，一个节拍完成，该节拍被我安排在了SEL_WAY节拍紧接着的下一个节拍，也就是MISS状态
    //注意：MISS状态可能持续好几个节拍，AXI总线返回来的aaready是否为1，为1则在下一个节拍变成REFILL状态   
    //lru表
    reg [127:0] lru;//由于两路，lru表设计为128行*1列，第n列为0表示第0列用的少，选择第0列
    reg [1:0] selway;//选路的结果，01表示选择第0路，10表示选择第1路
    // 根据自己设计自行增删寄存器
    //（1）LRU选路
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
    //（2）lru表更新(一拍就够，但是持续整个MISS状态好像也没影响）:两种情况：RUN命中/MISS不命中
    always@(posedge clk) begin
        if(!rst) begin//重置时，将lru表清空，即都选择第0路
            lru <= 0;
        end
        else if(state == MISS)begin//MISS不命中
            case(selway)
                2'b01: lru[ll_index] <= 1'b1;//如果选路结果为01，说明选择第0路进行使用，那么第1路就将变为最近最少使用
                2'b10: lru[ll_index] <= 1'b0;
                default:;
            endcase
        end
        else if(state == RUN && hit == 1)begin//RUN命中
            lru[ll_index] = ~hit_way;//hit_way是命中的路
        end
        else begin
        end
    end

    // RESETN状态：从state = RESETN开始从0计数，每一拍加一，当记满128拍后说明初始化完成
    initial begin
        counter <= 7'b0;
    end
    always@(posedge clk) begin
        if(!rst) begin
            counter <= 7'b0;//计算器清零
        end
        else if(state == RESETN) begin//如果为RESETN 状态，则计数器加1
            counter <= counter + 7'b1;
        end
        else begin
        end
    end

    //refill模块
    reg [2:0] refill_counter;//记录当前refill的指令个数
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

    //目录表和数据块
    //目录表
    //tagv_wen：目录表写使能，第n位代表第n路写使能（高有效）,一下两钟情况改变使能信号可能为1，其余都为0。
    //          RESETN状态时，赋值为11，进行初始化；
    //          cache不命中时，根据LRU的结果selway进行赋值,
    //          selway为01，表示选择第0路更新，写使能赋值01，表示第0路目录表可以被更新（可认为等于selway）
    //tagv_index：作为目录表索引，进行查找，同时用于两个目录表
    //          RESETN状态时，在128拍中，index从0变成127（可认为等于counter)
    //          RUN状态时，为cpu输出，地址流水段输出last_index
    //          其他状态为ll_index
    //tagv_tag：标识
    //          RUN状态时，为地址流水段输出last_tag
    //          其他状态为ll_tag
    //valid_wdata：写入有效位的值
    //          RESETN 时为0，其他情况为1
    //hit_array :命中结果，第n路为1，表示第n路命中(n等于2）
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
    
    //数据块(写情况：不命中时候需要更新数据块）
    wire [31 :0] data_wen [1:0];
    wire [6  :0] data_index;
    wire [4  :0] data_offset;
    wire [255:0] data_wdata;
    wire [31 :0] data_rdata [1:0];
    wire [4:0] refill_wen;
    assign refill_wen = refill_counter << 2;//记录需要右移的位数
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
    assign hit_way = (hit_array[0] == 1)? 0 : 1;//命中的是哪一路
    
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
