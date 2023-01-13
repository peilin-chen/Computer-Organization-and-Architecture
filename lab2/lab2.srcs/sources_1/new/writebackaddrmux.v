`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 15:59:17
// Design Name: 
// Module Name: writebackaddrmux
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


module writebackaddrmux(
    input [4:0] addr0,
    input [4:0] addr1,
    input lw_select,
    output [4:0] result
    );
    assign result = (lw_select)? addr1:addr0;
endmodule
