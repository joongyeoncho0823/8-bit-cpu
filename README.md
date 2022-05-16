# Design:

8-bit CPU
16-bit instructions
8 Registers
4-bit for opcode
8-bit address bus

# Registers:

R0-R8: General Purpose Registers

# Operations:

opcode:

0000- ADD
0001- ADDI
0010- AND
0011- OR
0101- DISPLAY
0110- STUR
0111- LDUR
1000- MUL

# Operation Types

I Type: ADDI
R Type: ADD AND OR MULT
D Type: LDUR STUR

# Instruction Format:

assign opcode = instruction[15:12];
assign Rd = instruction[11:8];
assign Rn = instruction[7:4];
assign Rm = instruction[3:0];

# For I Type:

opcode = opcode
Rd = Destination Register
Rn = Input Register
Rm = Immediate

# For D Type:

opcode = opcode
Rd = addr
Rn = Register
Rm = null

# For R Type:

opcode = opcode
Rd = Destination Register
Rn = Input Register 1
Rm = Input Register 2

This single cycle processor takes 32 instructions, and there are exactly 32 lines in test1.txt, test2.txt for instructions.
These test runs have associated assembly code and GTKWave output included in the folder.

# To Run

Enter "iverilog -o cpu alu.v datapath.v dmem.v imem.v cpu.v adder8bit.v fullAdder.v" in command line.
Then, run "./cpu"

# Files

test1.png test2.png: GTKwaves \
d-type architecture.png r&i-type-architecture.png: Architecture Diagrams \
cpu.v datapath.v dmem.v imem.v alu.v fullAdder.v adder8bit.v: Modules \
\*.asm: Assembly Code \
