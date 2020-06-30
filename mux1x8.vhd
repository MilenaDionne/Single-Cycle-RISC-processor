library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--8 inputs mux (1 bit)
-- To be generated 8 times to make it a 8 bits mux
-- Used to output CPU's registers content:

--000 PC The program counter value
--001 ALUResult The result of the current ALU operation
--010 ReadData1 The read data 1 port of the register File
--011 ReadData2 The read data 2 port of the register File
--100 WriteData The write data port of the register File
--Other ['0', RegDst, Jump, MemRead, The remaining
--MemtoReg, AluOp[1..0], AluSrc] control information

entity mux1x8 is
	
	port(in0, in1, in2, in3, in4, in5, in6, in7 : in std_logic;
		sel :in std_logic_vector(2 downto 0);
		muxOut: out std_logic);
		
end entity mux1x8;

architecture muxBehave of mux1x8 is
begin
	muxOut <= ( (in0 and (not sel(2)) and (not sel(1)) and (not sel(0))) or 
	(in1 and (not sel(2)) and (not sel(1)) and sel(0)) or
	(in2 and (not sel(2)) and sel(1) and (not sel(0))) or
	(in3 and (not sel(2)) and sel(1) and sel(0)) or
	(in4 and sel(2) and (not sel(1)) and (not sel(0))) or
	(in5 and sel(2) and (not sel(1)) and sel(0)) or
	(in6 and sel(2) and sel(1) and (not sel(0))) or
	(in7 and sel(2) and sel(1) and sel(0)) );
	
end muxBehave;
