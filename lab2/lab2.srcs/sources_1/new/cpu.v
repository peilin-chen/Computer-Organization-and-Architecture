`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/11/16 09:59:32
// Design Name: 
// Module Name: cpu
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

module cpu(
     input clk , // clock, 100MHz
    (*mark_debug = "true"*)input resetn , // active high
    // debug signals
    (*mark_debug = "true"*)output [31:0] debug_wb_pc , // 当前正在执行指令的 PC
    (*mark_debug = "true"*)output debug_wb_rf_wen , // 当前通用寄存器组的写使能信号
    (*mark_debug = "true"*)output [4 :0] debug_wb_rf_addr, // 当前通用寄存器组写回的寄存器编号
    (*mark_debug = "true"*)output [31:0] debug_wb_rf_wdata // 当前指令需要写回的数据
    );
    
    //存储指令的各个部分
    wire [5:0] opcode;//cu
    wire [4:0] raddr1;
    wire [4:0] raddr2;
    wire [4:0] raddr3;
    wire [10:0] func;//cu
    wire [25:0] instr_index;
    
    wire [31:0] current_instruction;//当前指令，从ir取出
    assign opcode = current_instruction[31:26];
    assign raddr1  =  current_instruction[25:21];
    assign raddr2  =  current_instruction[20:16];
    assign raddr3  =  current_instruction[15:11];
    assign  func =  current_instruction[10:0];
    assign  instr_index = current_instruction[25:0];
    
    //定义各种线
    //cu的输出
    wire pc_select;
    wire lw_select;
    wire reg_wen;
    wire a_mux_select;
    wire b_mux_select;
    wire dmem_write_en;
    wire [5:0] operation;
    wire is_J;//控制signextension
    
    wire equal;
    wire [31:0] nextpc;//pc输入,pc_mux输出
    wire [31:0] currentpc;//pc输出，imem\npc输入
    wire [31:0] pcadd4;//pc+4
    wire [31:0] output_instruction;//imem读出的指令
    wire [31:0] immin;//imm输入
    wire [31:0] immout;//imm输出
    wire [31:0] aout;//A输出
    wire [31:0] bout;//B输出
    wire [31:0] rdata1;//register读出的第一个数，A输入
    wire [31:0] rdata2;//register读出的第二个数，B输入
    wire [4:0] waddr;//register要写回的寄存器编号，writebackaddr_mux输出
    wire [31:0] wdata;//register要写回的寄存器内容,data_mux输出
    wire [31:0] alua;//alu第一个操作数，a_mux输出
    wire [31:0] alub;//alu第二个操作数，b_mux输出
    wire [31:0] result;//alu的计算结果
    wire [31:0] aluresultdata;//aluoutput输出
    wire [31:0] lmdin;//dmem读出的数据，lmd输入
    wire [31:0] lmdout;//lmd输出，data_mux输入
    
    //cpu输出
    assign debug_wb_pc = currentpc;
    assign debug_wb_rf_wen = reg_wen;
    assign debug_wb_rf_addr = waddr;
    assign debug_wb_rf_wdata = wdata;
    
    //各个模块的连线    
    pc U_pc(
        .clk(clk),
        .resetn(resetn),
        .nextpc(nextpc),
        .currentpc(currentpc)
    );
    npc U_npc(
        .pc (currentpc),
        .pcadd4 (pcadd4)
    );
    
    imem U_imem(
        .pc(currentpc),
        .instruction(output_instruction)
    );
    
    datatempstore U_ir(
        .inputdata (output_instruction),
        .outputdata (current_instruction)
    );
    
    regfile U_regfile(
        .clk(clk),
        .resetn(resetn),
        .raddr1(raddr1),
        .rdata1(rdata1),
        .raddr2(raddr2),
        .rdata2(rdata2),
        .wen(reg_wen),
        .waddr(waddr) ,
        .wdata(wdata)
    );
    
    datatempstore U_a(
        .inputdata (rdata1),
        .outputdata (aout)
    );
    
    datatempstore U_b(
        .inputdata (rdata2),
        .outputdata (bout)
    );    
    
    signextension U_signextension(
        .is_J(is_J),
        .data(instr_index),
        .extendresult(immin)
    );
    
    datatempstore U_imm(
        .inputdata (immin),
        .outputdata (immout)
    );    
    
    equal U_equal(
        .data0(aout),  
        .data1(bout),
        .result(equal)
    );  
   
    mux U_a_mux(
        .data0(aout),
        .data1(pcadd4),
        .selectsignal(a_mux_select),
        .result(alua)
    );
    
    mux U_b_mux(
        .data0(bout),
        .data1(immout),
        .selectsignal(b_mux_select),
        .result(alub)
    );
    
    alu U_alu(
        .data0(alua),
        .data1(alub),
        .operation(operation),
        .result(result)
    );
    
    datatempstore U_aluoutput(
        .inputdata (result),
        .outputdata (aluresultdata)
    ); 
    
    dmem U_dmem(
        .data(bout),
        .address(aluresultdata),
        .dmem_write_en(dmem_write_en),
        .clk(clk),
        .resetn(resetn),
        .outputdata(lmdin)
    );
    
    datatempstore U_lmd(
        .inputdata (lmdin),
        .outputdata (lmdout)
    ); 
    
    mux U_pc_mux(
        .data0(pcadd4),
        .data1(aluresultdata),
        .selectsignal(pc_select),
        .result(nextpc)
    );
    
    mux U_data_mux(
        .data0(aluresultdata),
        .data1(lmdout),
        .selectsignal(lw_select),
        .result(wdata)
    );
    
    writebackaddrmux U_writebackaddrmux(
        .addr0(raddr3),
        .addr1(raddr2),
        .lw_select(lw_select),
        .result(waddr)
    );      
    
    cu U_cu(
        .opcode(opcode),
        .resetn(resetn),
        .func(func),
        .equal(equal),
        .rtdata(rdata2),
        
        .pc_select(pc_select),
        .lw_select(lw_select),
        .reg_wen(reg_wen),
        .a_mux_select(a_mux_select),
        .b_mux_select(b_mux_select),
        .dmem_write_en(dmem_write_en),
        .operation(operation),
        .is_J(is_J)
    );
   
    
endmodule
