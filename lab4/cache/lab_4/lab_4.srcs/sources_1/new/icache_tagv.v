`timescale 1ns / 1ps

/* ��Ŀ¼���������һ·�� tag��������·�������Ҫ����������Ŀ¼�� */
/* ��Ŀ¼����Ҫһ��ʱ��Էô��Ƿ����н����ж� */
/* ��Ŀ¼����Ҫһ��ʱ����� tag ��д�� */
module icache_tagv(
    input clk, // ʱ���ź�
    input wen, // дʹ��
    input valid_wdata, // д����Чλ��ֵ��������ˢ�� cache ʱΪ 0���������Ϊ 1
    input [6 :0] index, // ���� tag ��д��ʱ���õ�����
    input [19:0] tag, // CPU �ô��ַ�� tag
    output hit, // ���н��
    output tmp_hit
);

    /* --------TagV Ram------- */
    // | tag | valid |
    // |20 1|0 0|
    reg [20:0] tagv_ram[127:0];
    
    /* --------Write-------- */
    always @(posedge clk) begin
        if (wen) begin
            tagv_ram[index] <= {tag, valid_wdata};
        end
    end
    
    /* --------Read-------- */
    reg [20:0] reg_tagv;
    reg [19:0] reg_tag;
    always @(posedge clk) begin
        reg_tagv = tagv_ram[index];
        reg_tag = tag;
    end
    assign hit = (reg_tag == reg_tagv[20:1]) && reg_tagv[0];
    assign tmp_hit=(tag==tagv_ram[index][20:1]) & tagv_ram[index][0];
endmodule

