`timescale 1ns / 1ps

module writeback(
    input clk,

    input               regWrite_i,
    input               wdSrc_i,
    input [ 4:0]        rd_i,
    input [31:0]        immU_i,  
    input [31:0]        aluResult_i,

    input               aluZero_i,
    input               condZero_i,                 
    input               branch_i,

    input [31:0]        pcBranch_i,
    input [31:0]        pcPlus4_i,

    output          regWrite_o,
    output [ 4:0]   rd_o,     
    output [31:0]   result_o,
    output [31:0]   newPC_o 
);

    reg         regWriteR;
    reg         wdSrcR;
    reg [ 4:0]  rdR;
    reg [31:0]  immUR;
    reg [31:0]  aluResultR;
    reg         aluZeroR;
    reg         condZeroR;
    reg         branchR;
    reg [31:0]  pcBranchR;
    reg [31:0]  pcPlus4R;

    always @ (posedge clk) begin
        regWriteR   <= regWrite_i;
        wdSrcR      <= wdSrc_i;
        rdR         <= rd_i;
        immUR       <= immU_i;
        aluResultR  <= aluResult_i;
        aluZeroR    <= aluZero_i;
        condZeroR   <= condZero_i;
        branchR     <= branch_i;
        pcBranchR   <= pcBranch_i;
        pcPlus4R    <= pcPlus4_i;
    end  

    wire [31:0] resultW = wdSrcR ? immUR : aluResultR;
    wire [31:0] newPCW = ( ~(aluZeroR ^ condZeroR) & branchR ) ? pcBranchR : pcPlus4R;

    // always @ (negedge clk) begin
    //     regWrite_o  <= regWriteR;
    //     rd_o        <= rdR;
    //     result_o    <= resultW;
    //     newPC_o     <= newPCW;
    // end 

    assign regWrite_o  = regWriteR;
    assign rd_o        = rdR;
    assign result_o    = resultW;
    assign newPC_o     = newPCW; 

endmodule
