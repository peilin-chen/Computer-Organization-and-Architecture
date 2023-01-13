`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 21:43:08
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    // ‰»Î
    reg [31:0] data0;
    reg [31:0] data1;
    reg [5:0] operation;
    // ‰≥ˆ
    wire [31:0] result;
    initial begin
        data0 = 31'hfffffff0;
        data1 = 32'h00000002;
    #10 operation = 6'b100000;//add
    #10 operation = 6'b111000;//sw lw
    #10 operation = 6'b100010;//sub
    #10 operation = 6'b100100;//and
    #10 operation = 6'b100101;//or
    #10 operation = 6'b100110;//xor
    #10 operation = 6'b101010;//slt
    #10 operation = 6'b001010;//movz
    #10 operation = 6'b101000;//beq
    #10 operation = 6'b110000;//jmp
    end
    alu alu_0(
        .operation(operation),
        .data0(data0),
        .data1(data1),
        .result(result)
    );
endmodule
