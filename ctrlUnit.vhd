library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit is
	port (
	Opcode : in std_logic_vector(5 downto 0);
	RegDst, Jump, BEQ,BNE, MemRead, MemToReg : out std_logic;
	MemWrite, ALUSrc, RegWrite: out std_logic;
	ALUOp: out std_logic_vector(1 downto 0)
);
end entity;

architecture ctrLogic of ctrlUnit is
signal R_format,lw,sw,b_eq,jp,b_ne:std_logic;
begin
        R_format<= (not Opcode(5)) and (not Opcode(4)) and (not Opcode(3)) and (not Opcode(2)) and (not Opcode(1)) and (not Opcode(0));
	lw      <= Opcode(5) and (not Opcode(4)) and (not Opcode(3)) and (not Opcode(2)) and Opcode(1) and Opcode(0);
	sw      <= Opcode(5) and (not Opcode(4)) and Opcode(3) and (not Opcode(2)) and Opcode(1) and Opcode(0);
	b_eq    <= (not Opcode(5)) and (not Opcode(4)) and (not Opcode(3)) and Opcode(2) and (not Opcode(1)) and (not Opcode(0));
	b_ne    <= (not Opcode(5)) and (not Opcode(4)) and (not Opcode(3)) and Opcode(2) and (not Opcode(1)) and Opcode(0);
	jp      <= (not Opcode(5)) and (not Opcode(4)) and (not Opcode(3))and (not Opcode(2)) and Opcode(1) and not(Opcode(0));
	----Need to discuss about jump instruction
	RegDst  <= R_format;
	ALUSrc  <= lw or sw;
	MemToReg<=lw;
	RegWrite<=R_format or lw;
	MemRead <=lw;
	MemWrite<=sw;
	BEQ     <=b_eq;
	BNE     <=b_ne;
	ALUOp(1)<=R_format;
	ALUOp(0)<=b_eq or b_ne;
	Jump    <=jp;
end architecture ctrLogic;