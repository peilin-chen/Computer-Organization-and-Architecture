/* �����ݿ��������һ·�����ݣ�������·�������Ҫ�������������ݿ� */
/* �����ݿ��д��Ͷ�ȡ���ݾ���Ҫһ�ĵ�ʱ�� */
module icache_data(
    input clk, // ʱ���ź�
    input [31 :0] wen, // ���ֽ�дʹ�ܣ��� wen = 32'hf000000����ֻд��Ŀ���е� [31:0]
    input [6 :0] index, // �ô��д�������
    input [4 :0] offset, // �ô��ƫ����
    input [255:0] wdata, // д������� 256λ����32���ֽ�
    output [31 :0] rdata // �ô����������
);
    // ���� Cache һ�ζ�һ�У�����Ҫ���� offset �ڶ���һ�к�������ȷ�����յ� 4 �ֽ�
    reg [4:0] last_offset;
    always @(posedge clk) begin
        last_offset <= offset;
    end
    //-----���� IP �˴ Cache �����ݴ洢��-----
    wire [31:0] bank_douta [7:0];
    /*
        Cache_Data_RAM: 128 �У�ÿ�� 32bit���� 8 �� ram
        �ӿ��źź��壺 clka��ʱ���ź�
        ena: ʹ���źţ��������� ip ���Ƿ���
        wea�����ֽ�дʹ���źţ�ÿ��д 4 �ֽڣ��� wea �� 4 λ
        addra����ַ�źţ�˵����/д�ĵ�ַ
        dina����Ҫд������ݣ����� wea == 1 ʱ��Ч
        douta����ȡ�����ݣ��� wea == 0 ʱ��Ч���ӵ�ַ addra ����ȡ������
    */
    generate
        genvar i;
        for (i = 0 ; i < 8 ; i = i + 1) begin
            inst_ram BANK(
            .clka(clk),
            .ena(1'b1),
            .wea(wen[i*4+3:i*4]),
            .addra(index),
            .dina(wdata[i*32+31:i*32]),
            .douta(bank_douta[7-i])
            );
        end
    endgenerate
    assign rdata = bank_douta[last_offset[4:2]];
endmodule