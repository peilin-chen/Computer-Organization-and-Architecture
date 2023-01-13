`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 21:49:30
// Design Name: 
// Module Name: cu_tb
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


module cu_tb;
    //输入
    reg [5:0] opcode;
    reg [10:0] func;
    reg equal;
    reg [31:0] rtdata;
    //输出
    wire pc_select;
    wire lw_select;
    wire reg_wen;
    wire a_mux_select;
    wire b_mux_select;
    wire dmem_write_en;
    wire is_J;
    wire [5:0] operation;
    
    initial begin
        //初始化
        opcode = 6'b000000;
        func = 11'b00000100000;
        equal = 1'b0;
        rtdata = 32'b0;
    #10 //add
        opcode = 6'b000000;
        func = 11'b00000100000;
        equal = 1'b0;
    #10 //sub
        opcode = 6'b000000;
        func = 11'b00000100010;
        equal = 1'b0;
    #10 //and
        opcode = 6'b000000;
        func = 11'b00000100100;
        equal = 1'b0;
    #10 //or
        opcode = 6'b000000;
        func = 11'b00000100101;
        equal = 1'b0;
    #10 //xor
        opcode = 6'b000000;
        func = 11'b00000100110;
        equal = 1'b0;
    #10 //slt
        opcode = 6'b000000;
        func = 11'b00000101010;
        equal = 1'b0;
    #10 //movz rtdata==0
        opcode = 6'b000000;
        func = 11'b00000001010;
        equal = 1'b0;
        rtdata = 32'b0;
    #10 //movz rtdata!=0
        opcode = 6'b000000;
        func = 11'b00000001010;
        equal = 1'b0;
        rtdata = 32'b1;
    #10 //sw
        opcode = 6'b101011;
    #10 //lw
        opcode = 6'b100011;
    #10 //beq equal == 1
        opcode = 6'b000100;
        equal = 1'b1;
    #10 //beq equal == 0
        opcode = 6'b000100;
        equal = 1'b0;
    #10 //j
        opcode = 6'b000010;
    end
    
    cu cu_0(
        .opcode(opcode),
        .func(func),
        .equal(equal),
        .rtdata(rtdata),
        .resetn(resetn),
        
        .pc_select(pc_select),
        .lw_select(lw_select),
        .reg_wen(reg_wen),
        .a_mux_select(a_mux_select),
        .b_mux_select(b_mux_select),
        .dmem_write_en(dmem_write_en),
        .is_J(is_J),
        .operation(operation) 
    );
endmodule
