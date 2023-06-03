`timescale 1ns / 1ps

module writeback(
    input clk,

    input               aluZero_i,
    input               condZero_i,                 
    input               branch_i,

    input [31:0]        pcBranch_i,
    input [31:0]        pcPlus4_i,

    output [31:0]   newPC_o 
);


    reg         aluZeroR;
    reg         condZeroR;
    reg         branchR;
    reg [31:0]  pcBranchR;
    reg [31:0]  pcPlus4R;

    always @ (posedge clk) begin
        aluZeroR    <= aluZero_i;
        condZeroR   <= condZero_i;
        branchR     <= branch_i;
        pcBranchR   <= pcBranch_i;
        pcPlus4R    <= pcPlus4_i;
    end  

    wire [31:0] newPCW = ( ~(aluZeroR ^ condZeroR) & branchR ) ? pcBranchR : pcPlus4R;

    // always @ (negedge clk) begin
    //     regWrite_o  <= regWriteR;
    //     rd_o        <= rdR;
    //     result_o    <= resultW;
    //     newPC_o     <= newPCW;
    // end 

    assign newPC_o     = newPCW; 

endmodule
