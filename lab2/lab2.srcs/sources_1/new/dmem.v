`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/15 22:23:53
// Design Name: 
// Module Name: dmem
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

module dmem(
    input[31:0] data,//待存入的数据
    input[31:0] address,//要读数据的地址
    input dmem_write_en,//0表示lw取数；1表示sw存数，即写使能有效
    input clk,
    input resetn,
    output[31:0] outputdata    
    );
    reg [31:0]datamemory[255:0];
    reg [31:0]static_memory[255:0];
    initial begin
        $readmemh("D:/Users/Administrator/VivadoProjects/lab2/lab2.data/data_data.txt",datamemory);
        $readmemh("D:/Users/Administrator/VivadoProjects/lab2/lab2.data/data_data.txt",static_memory);
    end
    reg[7:0] addr;
    initial addr = 0;
    always@(posedge clk)begin
        if(!resetn)
            datamemory[addr] <= static_memory[addr];
        else if(dmem_write_en)
            datamemory[address>>2]<=data;//sw
    end
    always@(posedge clk) begin
        if(!resetn) addr <=addr +1;
    end
    assign outputdata = datamemory[address>>2];//lw
endmodule
    
