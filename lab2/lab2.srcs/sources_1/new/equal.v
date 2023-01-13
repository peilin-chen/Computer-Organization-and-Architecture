`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
// Design Name: 
// Module Name: equal
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


module equal(
    input[31:0] data0,
    input[31:0] data1,
    output result
    );
    assign result = (data0 == data1)? 1 : 0;
endmodule
