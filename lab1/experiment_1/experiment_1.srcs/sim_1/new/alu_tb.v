`timescale 1ns / 1ps //仿真时间单位/仿真时间精度
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/10 19:49:27
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

//alu_tb.v
module alu_tb(
    );
    reg [31:0] a, b;
    reg cin;
    reg [4:0] card;//操作码
    wire [31:0] f;
    wire cout, zero;
    
    initial begin
        card =  5'b00001;
        cin = 1'b0;
        a = 32'h00000011;
        b = 32'hffffffff;//进位1,00000010
        
    #10 card =  5'b00010;
        cin = 1'b0;
        a = 32'h00000001;
        b = 32'hffffffff;//进位1，00000001
        
    #10 card =  5'b00011;
        cin = 1'b1;
        a = 32'hfffffffe;
        b = 32'hfffffffe;//进位0，00000000，零标志置为1
        
    #10 card =  5'b00100;
        cin = 1'b1;
        a = 32'hfffffff1;
        b = 32'hfffffff1;//进位1，等于ffffffff
        
    #10 card =  5'b00101;
        cin = 1'b1;
        a = 32'h00000000;
        b = 32'hffffffff;//ffffffff
        
    #10 card =  5'b00110;
        cin = 1'b1;
        a = 32'h00000000;
        b = 32'hffffffff;//fffffffe
        
    #10 card =  5'b00111;
        cin = 1'b1;
        a = 32'h00000001;
        b = 32'h00000002;//1
        
    #10 card =  5'b01000;
        cin = 1'b1;
        a = 32'h00000001;
        b = 32'h00000002;//2
        
    #10 card =  5'b01001;
        cin = 1'b1;
        a = 32'h00000003;
        b = 32'hffffffff;//fffffffc
        
    #10 card =  5'b01010;
        cin = 1'b0;
        a = 32'h00000000;
        b = 32'hfffffffe;//1
     
    #10 card =  5'b01011;
        cin = 1'b0;
        a = 32'h00000000;
        b = 32'h0f0f0f0f;//0f0f0f0f
        
    #10 card =  5'b01100;
        cin = 1'b1;
        a = 32'hf0f0f050;
        b = 32'hffffff1f;//f0f0f010
            
    #10 card =  5'b01101;
        cin = 1'b0;
        a = 32'h00000f60;
        b = 32'hf89fffff;//07600f60
     
    #10 card =  5'b01110;
        cin = 1'b1;
        a = 32'h0000f000;
        b = 32'hffff67ff;//ffff97ff
     
    #10 card =  5'b01111;
        cin = 1'b0;
        a = 32'h06009070;
        b = 32'hff9ffaff;//f9ff6f8f
        
    #10 card =  5'b10000;
        cin = 1'b1;
        a = 32'h00000000;
        b = 32'hffffffff;//0
    #10 card = 5'b10001;
        cin = 1'b1;
        a = 32'h00000001;
        b = 32'hfffffff1;
    #10 card = 5'b10010;
    #10 card = 5'b10011;
    #10 card = 5'b10100;
    #10 card = 5'b10101;
    #10 card = 5'b10110;
    #10 card = 5'b10111;
    #10 card = 5'b11000;
    #10 card = 5'b11001;
    #10 card = 5'b11010;
    #10 card = 5'b11011;
    #10 card = 5'b11100;
    #10 card = 5'b11101;
    #10 card = 5'b11110;
    #10 card = 5'b11111;
    #10
    $stop;
    end    
 
    //例化被测试模块
    alu alu_0(
        .A  (a),
        .B  (b),
        .Cin    (cin),
        .Card   (card),
        .F  (f),
        .Cout   (cout),
        .Zero   (zero)
     );
endmodule
