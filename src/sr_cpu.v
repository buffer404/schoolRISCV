/*
 * schoolRISCV - small RISC-V CPU 
 *
 * originally based on Sarah L. Harris MIPS CPU 
 *                   & schoolMIPS project
 * 
 * Copyright(c) 2017-2020 Stanislav Zhelnio 
 *                        Aleksandr Romanov 
 */ 

`include "sr_cpu.vh"

module sr_cpu
(
    input           clk,        // clock
    input           rst_n,      // reset
    input   [ 4:0]  regAddr,    // debug access reg address
    output  [31:0]  regData,    // debug access reg data
    output  [31:0]  imAddr,     // instruction memory address
    input   [31:0]  imData      // instruction memory data
);
    //fetch wires
    wire [31:0] pc_f;
    wire [31:0] pc_w;

    wire [31:0] instr_fd;
    wire [31:0] pc_fd;
    wire [31:0] pcPlus4_fd;

    //decode wires
    wire        wdSrc_de;
    wire        regWrite_de;
    wire        branch_de;
    wire [2:0]  aluControl_de;
    wire        aluSrc_de;
    wire        condZero_de;

    wire [ 4:0] rs1_de;
    wire [ 4:0] rs2_de;
    wire [ 4:0] rd_de;
    wire [31:0] immI_de;
    wire [31:0] immU_de;

    wire [31:0] pcBranch_de;
    wire [31:0] pcPlus4_de;


    wire [31:0] srcA;
    wire [31:0] srcB;
    wire [31:0] rd1;
    wire [31:0] rd2;

    //execute wires
    wire        wdSrc_ew;
    wire        regWrite_ew;
    wire        branch_ew;
    wire        condZero_ew;
    wire        aluZero_ew;

    wire [31:0] aluResult_ew;

    wire [ 4:0] rd_ew;
    wire [31:0] immU_ew;    

    wire [31:0] pcBranch_ew;
    wire [31:0] pcPlus4_ew;

    //writeback wires
    wire        regWrite_wf;
    wire [ 4:0] rd_wf;
    wire [31:0] result_wf;

    wire freeze;

    fetch fetch(
        .clk(clk),
        .freeze(freeze),
        .pc_i(pc_f),
        .instr_o(instr_fd),
        .pc_o(pc_fd),
        .pcPlus4_o(pcPlus4_fd)
    );

    decode decode(
        .clk(clk),
        .instr_i(instr_fd),
        .pc_i(pc_fd),
        .pcPlus4_i(pcPlus4_fd),

        .wdSrc_o(wdSrc_de),
        .regWrite_o(regWrite_de),
        .branch_o(branch_de),
        .aluControl_o(aluControl_de),
        .aluSrc_o(aluSrc_de),
        .condZero_o(condZero_de),

        .rs1_o(rs1_de),
        .rs2_o(rs2_de),
        .rd_o(rd_de),
        .immI_o(immI_de),
        .immU_o(immU_de),

        .pcBranch_o(pcBranch_de),
        .pcPlus4_o(pcPlus4_de)
    );

    execute execute(
        .clk(clk),

        .wdSrc_i(wdSrc_de),
        .regWrite_i(regWrite_de),
        .branch_i(branch_de),
        .condZero_i(condZero_de),
        .aluControl_i(aluControl_de),
        .aluSrc_i(aluSrc_de),

        .srcA_i(srcA),
        .srcB_i(srcB),
        .rd_i(rd_de),
        .immI_i(immI_de),
        .immU_i(immU_de),

        .pcBranch_i(pcBranch_de),
        .pcPlus4_i(pcPlus4_de),

        .wdSrc_o(wdSrc_ew),
        .regWrite_o(regWrite_ew),
        .branch_o(branch_ew),
        .condZero_o(condZero_ew),
        .aluZero_o(aluZero_ew),

        .aluResult_o(aluResult_ew),

        .rd_o(rd_ew),
        .immU_o(immU_ew),    

        .pcBranch_o(pcBranch_ew),
        .pcPlus4_o(pcPlus4_ew)
    );

    writeback writeback(

        .clk(clk),
        .regWrite_i(regWrite_ew),
        .wdSrc_i(wdSrc_ew),
        .rd_i(rd_ew),
        .immU_i(immU_ew),  
        .aluResult_i(aluResult_ew),

        .aluZero_i(aluZero_ew),
        .condZero_i(condZero_ew),                 
        .branch_i(branch_ew),

        .pcBranch_i(pcBranch_ew),
        .pcPlus4_i(pcPlus4_ew),

        .regWrite_o(regWrite_wf),
        .rd_o(rd_wf),     
        .result_o(result_wf),
        .newPC_o(pc_w)

    );

    sm_register_file sm_register_file(
        .clk(clk),
        .a1(rs1_de),
        .a2(rs2_de),
        .a3(rd_wf),
        .rd1(rd1),
        .rd2(rd2),
        .wd3(result_wf),
        .we3(regWrite_wf)
    );  


    conflict_prevention conflict_prevention(
        .clk(clk),
        .start_pc(imAddr),

        .rd1(rd1),
        .rd2(rd2),

        .rs1(rs1_de),
        .rs2(rs2_de),

        .regWrite(regWrite_ew),
        .aluResult(aluResult_ew),
        .immU(immU_ew),
        .wdSrc(wdSrc_ew),
        .rd(rd_ew),

        .freeze(freeze),
        .branch(branch_de),
        .pcPlus4(pcPlus4_fd),
        .pcBranch(pc_w),


        .pcTarget(pc_f),
        .srcA(srcA),
        .srcB(srcB)
    );


endmodule

module sm_register_file
(
    input         clk,
    input  [ 4:0] a1,
    input  [ 4:0] a2,
    input  [ 4:0] a3,
    output [31:0] rd1,
    output [31:0] rd2,
    input  [31:0] wd3,
    input         we3
);
    reg [31:0] rf [31:0];

    assign rd1 = (a1 != 0) ? rf [a1] : 32'b0;
    assign rd2 = (a2 != 0) ? rf [a2] : 32'b0;

    always @ (posedge clk)
        if(we3) rf [a3] <= wd3;
endmodule

module conflict_prevention
(
    input           clk,

    input [31:0]    start_pc,

    input [31:0]    rd1,
    input [31:0]    rd2,

    input [ 4:0]    rs1,
    input [ 4:0]    rs2,

    input           regWrite,
    input [31:0]    aluResult,
    input [31:0]    immU,
    input           wdSrc,
    input [ 4:0]    rd,

    input           branch,
    input [31:0]    pcBranch,
    input [31:0]    pcPlus4,

    output reg          freeze,
    output reg [31:0]   pcTarget,

    output [31:0]   srcA,
    output [31:0]   srcB
);

    reg [1:0] state = 2'b0;
    reg       start = 1;

    initial begin
            freeze <= 0;
            pcTarget <= 32'b0;
    end

    always @ (negedge clk) begin
        if (start == 1 ) begin
            freeze <= 0;
            pcTarget <= 32'b0;
            start <= 0;
        end    
        else 
            case (state)
                2'b00 : begin
                            if (branch) begin
                                state <= 1;
                                freeze <= 1;
                            end
                            else pcTarget <= pcPlus4;
                        end
                2'b01 : state <= 2;
                2'b10 : state <= 3;
                2'b11 : begin 
                            state <= 0;
                            freeze <= 1;
                        end
            endcase    
    end    

    //assign pcTarget = !init ? (branch ? state === 2'b11 ? pcBranch : 32'bx : pcPlus4) : init == 2'b01 ? pcPlus4 : 32'b0;
    // assign pcBranch = init == 2'b00 ? 32'b1 : 32'b0;

    //data conflict
    assign srcA = (rs1 == rd1 && regWrite) ? (wdSrc ? aluResult : immU) : rd1;
    assign srcB = (rs2 == rd2 && regWrite) ? (wdSrc ? aluResult : immU) : rd2;

endmodule