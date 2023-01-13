`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/10 19:49:09
// Design Name: 
// Module Name: alu
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


//alu.v

//����16������ı���
`define A_ADD_B     5'b00001    //A+B---1��
`define A_ADD_B_Cin 5'b00010    //A+B+Cin
`define A_SUB_B     5'b00011    //A-B
`define A_SUB_B_Cin 5'b00100    //A-B-Cin
`define B_SUB_A     5'b00101    //B-A
`define B_SUB_A_Cin 5'b00110    //B-A-Cin
`define Value_A     5'b00111    //A
`define Value_B     5'b01000    //B
`define NOT_A       5'b01001    //A��----9��
`define NOT_B       5'b01010    //B��
`define A_OR_B      5'b01011    //��
`define A_AND_B     5'b01100    //��
`define A_XNOR_B    5'b01101    //ͬ��
`define A_XOR_B     5'b01110    //���
`define A_NAND_B    5'b01111    //���
`define ZERO        5'b01000    //��

module alu(
    input   [31:0]  A,      //AΪ32λ������
    input   [31:0]  B,      //BΪ32λ������
    input           Cin,     //CinΪ��λ��0����1
    input   [4:0]   Card,    //CardΪ5λ���������
    
    output  [31:0]  F,       //FΪ������
    output          Cout,    //CoutΪ��λ���
    output          Zero    //ZeroΪ���־
    );
    
    wire [31:0] a_add_b_result; //1
    wire [31:0] a_add_b_cin_result;
    wire [31:0] a_sub_b_result;
    wire [31:0] a_sub_b_cin_result;
    wire [31:0] b_sub_a_result;
    wire [31:0] b_sub_a_cin_result;
    wire [31:0] value_a_result;
    wire [31:0] value_b_result;
    wire [31:0] not_a_result;   //9
    wire [31:0] not_b_result;
    wire [31:0] a_or_b_result;
    wire [31:0] a_and_b_result;
    wire [31:0] a_xnor_b_result;//ͬ��
    wire [31:0] a_xor_b_result; //���
    wire [31:0] a_nand_b_result;
    wire [31:0] zero_result;
    
    //ǰ���������н�λ����Ҫ��Cout1-6��¼����
    wire cout_1;
    wire cout_2;
    wire cout_3;
    wire cout_4;
    wire cout_5;
    wire cout_6;

    //����ʮ��������
    assign  {cout_1,a_add_b_result}= A + B; //00001
    assign  {cout_2,a_add_b_cin_result} = A + B + Cin;
    assign  {cout_3,a_sub_b_result} = A - B;
    assign  {cout_4,a_sub_b_cin_result} = A - B - Cin;
    assign  {cout_5,b_sub_a_result} = B - A;
    assign  {cout_6,b_sub_a_cin_result} = B - A - Cin;
    assign  value_a_result = A;
    assign  value_b_result = B;
    assign  not_a_result = ~A;   //01001
    assign  not_b_result = ~B;
    assign  a_or_b_result = A | B;
    assign  a_and_b_result = A & B;
    assign  a_xnor_b_result = ~(A ^ B);//ͬ��
    assign  a_xor_b_result = A ^ B; //���
    assign  a_nand_b_result = ~(A & B);
    assign  zero_result = 0;
    
    //���������������������ѡ��
    //����F
    assign F =  ({32{Card == `A_ADD_B}} & a_add_b_result) |
                ({32{Card == `A_ADD_B_Cin}} & a_add_b_cin_result) |
                ({32{Card == `A_SUB_B}} & a_sub_b_result) |
                ({32{Card == `A_SUB_B_Cin}} & a_sub_b_cin_result) |
                ({32{Card == `B_SUB_A}} & b_sub_a_result) |
                ({32{Card == `B_SUB_A_Cin}} & b_sub_a_cin_result) |
                ({32{Card == `Value_A}} & value_a_result) |
                ({32{Card == `Value_B}} & value_b_result) |
                ({32{Card == `NOT_A}} & not_a_result) |
                ({32{Card == `NOT_B}} & not_b_result) |
                ({32{Card == `A_OR_B}} & a_or_b_result) |
                ({32{Card == `A_AND_B}} & a_and_b_result) |
                ({32{Card == `A_XNOR_B}} & a_xnor_b_result) |
                ({32{Card == `A_XOR_B}} & a_xor_b_result) |
                ({32{Card == `A_NAND_B}} & a_nand_b_result) |
                ({32{Card == `ZERO}} & zero_result)|0;
    //�����λCout
    assign Cout =   ((Card == `A_ADD_B) & cout_1) |
                    ((Card == `A_ADD_B_Cin) & cout_2) |
                    ((Card == `A_SUB_B) & cout_3) |
                    ((Card == `A_SUB_B_Cin) & cout_4) |
                    ((Card == `B_SUB_A) & cout_5) |
                    ((Card == `B_SUB_A_Cin) & cout_6)|0;
    //����Zero�����FΪ0�������־��Ϊ1
    assign Zero =  (F == 0)|0;
endmodule

