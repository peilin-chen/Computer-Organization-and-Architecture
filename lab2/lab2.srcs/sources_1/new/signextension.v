`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
// Design Name: 
// Module Name: signextension
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module signextension(
    input is_J,//�����źţ����Ϊ0����ʾΪsw/lw/beq(16->32)�����Ϊ1,��ʾΪJ��26->32)
    input [25:0]data,//����չ������
    output [31:0]extendresult//��չ���
);
    assign extendresult = (is_J)?{{6{data[25]}},data}:{{16{data[15]}},data[15:0]};//�����Jָ���26λ��չΪ32λ
endmodule