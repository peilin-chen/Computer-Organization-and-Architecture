`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
// Design Name: 
// Module Name: cu
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


module cu(
    input[5:0] opcode,
    input[10:0] func,
    input equal,
    input[31:0] rtdata,
    input resetn,
    
    output pc_select,
    output lw_select,
    output reg_wen,
    output a_mux_select,
    output b_mux_select,
    output dmem_write_en,
    output is_J,
    output[5:0] operation
    );
    
    //opcode
    parameter [5:0] ALU = 6'b000000;
    parameter [5:0] SW = 6'b101011;
    parameter [5:0] LW = 6'b100011;
    parameter [5:0] BEQ = 6'b000100;
    parameter [5:0] J = 6'b000010;
    
    //func
    parameter [5:0] MOVZFUNC = 6'b001010;
    
    //用来暂存不同指令应该输出的operation
    wire [5:0] operation1;
    wire [5:0] operation2;
    wire [5:0] operation3;
    wire [5:0] operation4;
    
    //列举所有operation情况
    assign operation1 = func[5:0];//alu指令后6位作为operation标志
    assign operation2 = 6'b101000;//beq
    assign operation3 = 6'b110000;//j
    assign operation4 = 6'b111000;//lw sw
    assign operation = ({6{opcode == ALU}}& operation1) |
                       ({6{opcode == BEQ}}& operation2) |
                       ({6{opcode == J}}& operation3) |
                       ({6{opcode == LW}}& operation4) |
                       ({6{opcode == SW}}& operation4);
                       
    //输出各种信号
    assign pc_select = (opcode == J || (opcode == BEQ && equal ==1 ))? 1'b1:1'b0;
    assign lw_select = (opcode == LW)? 1'b1:1'b0;
    assign reg_wen = (opcode == LW || (opcode == ALU &&!(func[5:0]==MOVZFUNC && rtdata !=0))) ? 1'b1 :1'b0;
    assign a_mux_select = (opcode ==J || opcode == BEQ) ? 1'b1:1'b0;//1表示需要跳转
    assign b_mux_select = (opcode == J || opcode == BEQ || opcode == LW || opcode == SW) ? 1'b1:1'b0;//表示需要用到偏移
    assign dmem_write_en = (opcode == SW)? 1'b1:1'b0;//只有sw往dmem写
    assign is_J = (opcode == J)? 1'b1:1'b0;
endmodule
