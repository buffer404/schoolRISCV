`include "sr_cpu.vh"

module execute(
    input               clk,

    input               wdSrc_i,
    input               regWrite_i,
    input               branch_i,
    input               condZero_i,
    input [ 2:0]        aluControl_i,
    input               aluSrc_i,

    input [31:0]        srcA_i,
    input [31:0]        srcB_i,
    input [ 4:0]        rd_i,
    input [31:0]        immI_i,
    input [31:0]        immU_i,

    input [31:0]        pcBranch_i,
    input [31:0]        pcPlus4_i,

    output          wdSrc_o,
    output          regWrite_o,
    output          branch_o,
    output          condZero_o,
    output          aluZero_o,
    output [31:0]   aluResult_o,

    output [ 4:0]   rd_o,
    output [31:0]   immU_o,    

    output [31:0]   pcBranch_o,
    output [31:0]   pcPlus4_o
);

    reg         wdSrcR;
    reg         regWriteR;
    reg         branchR;
    reg         condZeroR;
    reg [ 2:0]  aluControlR;
    reg         aluSrcR;

    reg [31:0]  srcAR;
    reg [31:0]  srcBR;
    reg [ 4:0]  rdR;
    reg [31:0]  immIR;
    reg [31:0]  immUR;

    reg [31:0]  pcBranchR;
    reg [31:0]  pcPlus4R;

    wire [31:0] srcAW = srcAR;
    wire [31:0] aluSecondW = aluSrcR ? immIR : srcBR;
    wire [ 2:0] aluControlW = aluControlR;
    wire        aluZeroW;
    wire [31:0] aluResultW;
    
    sr_alu sr_alu(
        .srcA(srcAW),
        .srcB(aluSecondW),
        .oper(aluControlW),
        .zero(aluZeroW),
        .result(aluResultW)
    );

    always @ (posedge clk) begin
        wdSrcR      <= wdSrc_i;
        regWriteR   <= regWrite_i;
        branchR     <= branch_i;
        condZeroR   <= condZero_i;
        aluControlR <= aluControl_i;
        aluSrcR     <= aluSrc_i;
        srcAR       <= srcA_i;
        srcBR       <= srcB_i;
        rdR         <= rd_i;
        immIR       <= immI_i;
        immUR       <= immU_i;
        pcBranchR   <= pcBranch_i;
        pcPlus4R    <= pcPlus4_i;
    end    

    // always @ (negedge clk) begin
    //     wdSrc_o     <= wdSrcR;
    //     regWrite_o  <= regWriteR;
    //     branch_o    <= branchR;
    //     condZero_o  <= condZeroR;
    //     aluZero_o   <= aluZeroW;
    //     aluResult_o <= aluResultW;
    //     rd_o        <= rdR;
    //     immU_o      <= immUR;
    //     pcBranch_o  <= pcBranchR;
    //     pcPlus4_o   <= pcPlus4R;
    // end 

    assign   wdSrc_o     = wdSrcR;
    assign   regWrite_o  = regWriteR;
    assign   branch_o    = branchR;
    assign   condZero_o  = condZeroR;
    assign   aluZero_o   = aluZeroW;
    assign   aluResult_o = aluResultW;
    assign   rd_o        = rdR;
    assign   immU_o      = immUR;
    assign   pcBranch_o  = pcBranchR;
    assign   pcPlus4_o   = pcPlus4R;


endmodule

module sr_alu
(
    input  [31:0]     srcA,
    input  [31:0]     srcB,
    input  [ 2:0]     oper,
    output          zero,
    output  [31:0]  result
);

    reg [31:0] resultReg;

    always @ (*) begin
        case (oper)
            default   : resultReg = srcA + srcB;
            `ALU_ADD  : resultReg = srcA + srcB;
            `ALU_OR   : resultReg = srcA | srcB;
            `ALU_SRL  : resultReg = srcA >> srcB [4:0];
            `ALU_SLTU : resultReg = (srcA < srcB) ? 1 : 0;
            `ALU_SUB : resultReg = srcA - srcB;
        endcase
    end

    assign zero = (result == 0);
    assign result = resultReg;
endmodule