/*
 * schoolRISCV - small RISC-V CPU 
 *
 * originally based on Sarah L. Harris MIPS CPU 
 *                   & schoolMIPS project
 * 
 * Copyright(c) 2017-2020 Stanislav Zhelnio 
 *                        Aleksandr Romanov 
 */ 

module sm_rom
#(
    parameter SIZE = 64
)
(
    input  [31:0] a,
    output [31:0] rd
);
    reg [31:0] rom [SIZE - 1:0];
    wire [31:0] shift = a >> 2;
    assign rd = rom [shift];

    initial begin
        $readmemh ("/home/leonid/Desktop/schoolRISCV-pipeline/program/simple/program.hex", rom);
    end

endmodule
