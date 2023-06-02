
module fetch(
    input clk,
    input freeze,
    input [31:0] pc_i,
    output reg [31:0] instr_o,
    output reg [31:0] pc_o,
    output reg [31:0] pcPlus4_o
);


    reg [31:0] pcR;
    wire [31:0] pcW;
    wire [31:0] dataW;

    assign pcW = pcR;

    sm_rom reset_rom(pcW, dataW);

    always @ (posedge clk) begin
        if (!freeze) pcR <= pc_i;
    end    

    always @ (negedge clk) begin
        if (!freeze) begin
            instr_o <= dataW;
            pc_o <= pcR;
            pcPlus4_o <= pcR + 4;    
        end    
    end  

endmodule
