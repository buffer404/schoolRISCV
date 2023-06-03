RARS = java -jar /home/leonid/Downloads/rars1_6.jar

build: program.hex

program.hex: main.asm
	$(RARS) nc a dump .text HexText program.hex main.asm

clear:
	rm program.hex