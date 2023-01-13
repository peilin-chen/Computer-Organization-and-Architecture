`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:22:06
// Design Name: 
// Module Name: imem
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


module imem(
    input[31:0] pc,
    output[31:0] instruction
    );
    reg [31:0] instmemory[255:0];
    initial begin
          $readmemh("D:/Users/Administrator/VivadoProjects/lab2/lab2.data/inst_data.txt",instmemory);//读取指令文件到inst_data
    end
    assign instruction = instmemory[pc>>2];
    
endmodule
