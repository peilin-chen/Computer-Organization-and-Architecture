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

//定义16种运算的编码
`define A_ADD_B     5'b00001    //A+B---1号
`define A_ADD_B_Cin 5'b00010    //A+B+Cin
`define A_SUB_B     5'b00011    //A-B
`define A_SUB_B_Cin 5'b00100    //A-B-Cin
`define B_SUB_A     5'b00101    //B-A
`define B_SUB_A_Cin 5'b00110    //B-A-Cin
`define Value_A     5'b00111    //A
`define Value_B     5'b01000    //B
`define NOT_A       5'b01001    //A非----9号
`define NOT_B       5'b01010    //B非
`define A_OR_B      5'b01011    //或
`define A_AND_B     5'b01100    //与
`define A_XNOR_B    5'b01101    //同或
`define A_XOR_B     5'b01110    //异或
`define A_NAND_B    5'b01111    //与非
`define ZERO        5'b01000    //零

module alu(
    input   [31:0]  A,      //A为32位运算数
    input   [31:0]  B,      //B为32位运算数
    input           Cin,     //Cin为进位，0或者1
    input   [4:0]   Card,    //Card为5位运算操作码
    
    output  [31:0]  F,       //F为运算结果
    output          Cout,    //Cout为进位结果
    output          Zero    //Zero为零标志
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
    wire [31:0] a_xnor_b_result;//同或
    wire [31:0] a_xor_b_result; //异或
    wire [31:0] a_nand_b_result;
    wire [31:0] zero_result;
    
    //前六种运算有进位，需要用Cout1-6记录下来
    wire cout_1;
    wire cout_2;
    wire cout_3;
    wire cout_4;
    wire cout_5;
    wire cout_6;

    //计算十六种运算
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
    assign  a_xnor_b_result = ~(A ^ B);//同或
    assign  a_xor_b_result = A ^ B; //异或
    assign  a_nand_b_result = ~(A & B);
    assign  zero_result = 0;
    
    //根据运算操作码进行运算的选择
    //计算F
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
    //计算进位Cout
    assign Cout =   ((Card == `A_ADD_B) & cout_1) |
                    ((Card == `A_ADD_B_Cin) & cout_2) |
                    ((Card == `A_SUB_B) & cout_3) |
                    ((Card == `A_SUB_B_Cin) & cout_4) |
                    ((Card == `B_SUB_A) & cout_5) |
                    ((Card == `B_SUB_A_Cin) & cout_6)|0;
    //计算Zero，如果F为0，则零标志置为1
    assign Zero =  (F == 0)|0;
endmodule

