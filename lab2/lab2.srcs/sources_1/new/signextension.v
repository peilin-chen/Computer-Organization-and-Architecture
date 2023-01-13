`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
// Design Name: 
// Module Name: signextension
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


module signextension(
    input is_J,//控制信号，如果为0，表示为sw/lw/beq(16->32)，如果为1,表示为J（26->32)
    input [25:0]data,//待扩展的数据
    output [31:0]extendresult//扩展结果
);
    assign extendresult = (is_J)?{{6{data[25]}},data}:{{16{data[15]}},data[15:0]};//如果是J指令，则将26位扩展为32位
endmodule