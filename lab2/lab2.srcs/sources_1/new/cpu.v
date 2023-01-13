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
    (*mark_debug = "true"*)output [31:0] debug_wb_pc , // ��ǰ����ִ��ָ��� PC
    (*mark_debug = "true"*)output debug_wb_rf_wen , // ��ǰͨ�üĴ������дʹ���ź�
    (*mark_debug = "true"*)output [4 :0] debug_wb_rf_addr, // ��ǰͨ�üĴ�����д�صļĴ������
    (*mark_debug = "true"*)output [31:0] debug_wb_rf_wdata // ��ǰָ����Ҫд�ص�����
    );
    
    //�洢ָ��ĸ�������
    wire [5:0] opcode;//cu
    wire [4:0] raddr1;
    wire [4:0] raddr2;
    wire [4:0] raddr3;
    wire [10:0] func;//cu
    wire [25:0] instr_index;
    
    wire [31:0] current_instruction;//��ǰָ���irȡ��
    assign opcode = current_instruction[31:26];
    assign raddr1  =  current_instruction[25:21];
    assign raddr2  =  current_instruction[20:16];
    assign raddr3  =  current_instruction[15:11];
    assign  func =  current_instruction[10:0];
    assign  instr_index = current_instruction[25:0];
    
    //���������
    //cu�����
    wire pc_select;
    wire lw_select;
    wire reg_wen;
    wire a_mux_select;
    wire b_mux_select;
    wire dmem_write_en;
    wire [5:0] operation;
    wire is_J;//����signextension
    
    wire equal;
    wire [31:0] nextpc;//pc����,pc_mux���
    wire [31:0] currentpc;//pc�����imem\npc����
    wire [31:0] pcadd4;//pc+4
    wire [31:0] output_instruction;//imem������ָ��
    wire [31:0] immin;//imm����
    wire [31:0] immout;//imm���
    wire [31:0] aout;//A���
    wire [31:0] bout;//B���
    wire [31:0] rdata1;//register�����ĵ�һ������A����
    wire [31:0] rdata2;//register�����ĵڶ�������B����
    wire [4:0] waddr;//registerҪд�صļĴ�����ţ�writebackaddr_mux���
    wire [31:0] wdata;//registerҪд�صļĴ�������,data_mux���
    wire [31:0] alua;//alu��һ����������a_mux���
    wire [31:0] alub;//alu�ڶ�����������b_mux���
    wire [31:0] result;//alu�ļ�����
    wire [31:0] aluresultdata;//aluoutput���
    wire [31:0] lmdin;//dmem���������ݣ�lmd����
    wire [31:0] lmdout;//lmd�����data_mux����
    
    //cpu���
    assign debug_wb_pc = currentpc;
    assign debug_wb_rf_wen = reg_wen;
    assign debug_wb_rf_addr = waddr;
    assign debug_wb_rf_wdata = wdata;
    
    //����ģ�������    
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
