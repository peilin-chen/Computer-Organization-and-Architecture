`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
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


module alu(
    input[31:0] data0,
    input[31:0] data1,
    input[5:0] operation,
    output[31:0] result
);
    
    //存储不同指令的计算结果
    wire [31:0] result1;//add lw sw
    wire [31:0] result2;//sub
    wire [31:0] result3;//and
    wire [31:0] result4;//or
    wire [31:0] result5;//xor
    wire [31:0] result6;//slt
    wire [31:0] result7;//movz
    wire [31:0] result8;//beq
    wire [31:0] result9;//j
    wire [31:0] temp;
    
    //计算不同指令的结果
    assign result1 = data0 + data1;//add sw lw
    assign result2 = data0 - data1;
    assign result3 = data0 & data1;
    assign result4 = data0 | data1;
    assign result5 = data0 ^ data1;
    assign result6 = (data0 < data1)?32'b1 : 32'b0;
    assign result7 = (data1 == 0)? data0 : 32'b0;
    assign result8 = data0 + (data1 << 2);//beq
    assign temp = data1 << 2;
    assign result9 ={data0[31:26], temp[25:0]};//j
    
    //根据operation选择result
    assign result = ({32{operation == 6'b100000}} & result1) |//add
                    ({32{operation == 6'b100010}} & result2) |//sub
                    ({32{operation == 6'b100100}} & result3) |//and
                    ({32{operation == 6'b100101}} & result4) |//or
                    ({32{operation == 6'b100110}} & result5) |//xor
                    ({32{operation == 6'b101010}} & result6) |//slt
                    ({32{operation == 6'b001010}} & result7) |//movz
                    ({32{operation == 6'b111000}} & result1) |//lw sw
                    ({32{operation == 6'b101000}} & result8) |//beq
                    ({32{operation == 6'b110000}} & result9) ;//j      
endmodule
