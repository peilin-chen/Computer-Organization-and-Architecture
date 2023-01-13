`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 20:55:23
// Design Name: 
// Module Name: pc
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


module pc(
    input clk,
    input resetn,
    input[31:0] nextpc,
    output reg[31:0] currentpc
    );
    initial begin
        currentpc <= 0;
    end        
    always@(posedge clk)begin
        if(!resetn) currentpc <= 0; 
        else currentpc <= nextpc;
    end

    
endmodule
