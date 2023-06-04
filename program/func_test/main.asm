0000 | 11111111 | 11111111 | 01010 | 1111111

00000000000000000000010101111111 // 0 0 
00000000000000000001010101111111 // 0 1
00000000000100000001010101111111 // 1 1
00000000001000000010010101111111 // 2 2
00000000111111110000010101111111 // 15 240
00001111000000001111010101111111 // 240 15
00000101010110101010010101111111 // 85 170
00001010101001010101010101111111 // 170 85
00001111111111111111010101111111 // 255 255

000011111111.11111111.010101111111

0000057F
0000157F
0010157F
0020257F
00FF057F
0F00F57F
055AA57F
0AA5557F
0FFFF57F

    0  pc = xxxxxxxx instr = 00000013 a0 = 0xxxxxxxxx a1 = 0xxxxxxxxx   :   new/unknown
    1  pc = 00 instr = 0000057f a0 = 0xxxxxxxxx a1 = 0xxxxxxxxx   :   new/unknown
    2  pc = 04 instr = 0000157f a0 = 0xxxxxxxxx a1 = 0xxxxxxxxx   :   func   $10, $00000000, $00000000
    3  pc = 08 instr = 0010157f a0 = 0xxxxxxxxx a1 = 0xxxxxxxxx   :   nop
   ......................................................................
   38  pc = 08 instr = 0010157f a0 = 0xxxxxxxxx a1 = 0xxxxxxxxx   :   nop
   39  pc = 08 instr = 0010157f a0 = 0x00000000 a1 = 0xxxxxxxxx   :   func   $10, $00000001, $00000001
   40  pc = 0c instr = 0020257f a0 = 0x00000000 a1 = 0xxxxxxxxx   :   nop
   ......................................................................
   75  pc = 0c instr = 0020257f a0 = 0x00000000 a1 = 0xxxxxxxxx   :   nop
   76  pc = 0c instr = 0020257f a0 = 0x00000002 a1 = 0xxxxxxxxx   :   func   $10, $00000010, $00000010
   77  pc = 10 instr = 00ff057f a0 = 0x00000002 a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  112  pc = 10 instr = 00ff057f a0 = 0x00000002 a1 = 0xxxxxxxxx   :   nop
  113  pc = 10 instr = 00ff057f a0 = 0x0000000c a1 = 0xxxxxxxxx   :   func   $10, $11110000, $00001111
  114  pc = 14 instr = 0f00f57f a0 = 0x0000000c a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  149  pc = 14 instr = 0f00f57f a0 = 0x0000000c a1 = 0xxxxxxxxx   :   nop
  150  pc = 14 instr = 0f00f57f a0 = 0x00d2fe10 a1 = 0xxxxxxxxx   :   func   $10, $00001111, $11110000
  151  pc = 18 instr = 055aa57f a0 = 0x00d2fe10 a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  186  pc = 18 instr = 055aa57f a0 = 0x00d2fe10 a1 = 0xxxxxxxxx   :   nop
  187  pc = 18 instr = 055aa57f a0 = 0x00001b3f a1 = 0xxxxxxxxx   :   func   $10, $10101010, $01010101
  188  pc = 1c instr = 0aa5557f a0 = 0x00001b3f a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  223  pc = 1c instr = 0aa5557f a0 = 0x00001b3f a1 = 0xxxxxxxxx   :   nop
  224  pc = 1c instr = 0aa5557f a0 = 0x004b2fda a1 = 0xxxxxxxxx   :   func   $10, $01010101, $10101010
  225  pc = 20 instr = 0ffff57f a0 = 0x004b2fda a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  260  pc = 20 instr = 0ffff57f a0 = 0x004b2fda a1 = 0xxxxxxxxx   :   nop
  261  pc = 20 instr = 0ffff57f a0 = 0x0009975f a1 = 0xxxxxxxxx   :   func   $10, $11111111, $11111111
  262  pc = 24 instr = 00000013 a0 = 0x0009975f a1 = 0xxxxxxxxx   :   nop
   ......................................................................
  297  pc = 24 instr = 00000013 a0 = 0x0009975f a1 = 0xxxxxxxxx   :   nop
  298  pc = 24 instr = 00000013 a0 = 0x00fe0100 a1 = 0xxxxxxxxx   :   new/unknown
    The program has finished execution!