            .text

start:      lui a0, , 0x0            # t0 = 0
            lui a1, , 0x0
            addi a1, a1, 2
counter:    addi a0, a0, 1           # t0 = t0 + 1
            bge a1, a0, counter  # if t0 == t1 then counter      
