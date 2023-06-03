# RISC-V simple counter program
#
# Stanislav Zhelnio, 2020
#

            .text

start:      lui a0, , 0x0             # t0 = 0
counter:    addi a0, a0, 1           # t0 = t0 + 1
            beq zero, zero, finish  # if t0 == t1 then counter
finish:     lui a0, , 0x0            
