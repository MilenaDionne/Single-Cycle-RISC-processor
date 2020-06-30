library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.all;

--MIPS Single Cycle CPU
--This file is the top level entity
-- Bonus bne as -- in top level entity follow the instruction to test bonus 
entity top is
port (
	--inputs
	ValueSelect : in std_logic_vector(2 downto 0);
	GClock: in std_logic; 
	GReset: in std_logic; 
	
	--outputs
	MuxOut: out std_logic_vector(7 downto 0);
	instructionOut: out std_logic_vector(31 downto 0); 	
	--hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_LOGIC_VECTOR(6 downto 0); --for hex pin
	BranchOut, ZeroOut, MemWriteOut, RegWriteOut: out std_logic
);
end entity;

architecture topArch of top is 
component PCReg is  
port(
  clk    : in STD_LOGIC;
  rst    : in STD_LOGIC;
  PC_in  : in STD_LOGIC_VECTOR (31 downto 0);
  PC_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC_adder32 is
	port(
	CLK : in STD_LOGIC;
           PC_in : in STD_LOGIC_VECTOR(31 downto 0);
           PC_out : out STD_LOGIC_VECTOR(31 downto 0)
);

end component;

component top_mux8x8 is
	
	port(PC, ALUresult, readData1, readData2, writeData, other, i6, i7: in std_logic_vector(7 downto 0); -- i6 and i7 not used
		sel :in std_logic_vector(2 downto 0);
		muxOut: out std_logic_vector(7 downto 0));
		
end component;

component instructionMemory is
	port (
		address		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

component regFile -- once
port (
	RR1 : in STD_LOGIC_VECTOR (4 downto 0); --Read register 1
   RR2 : in STD_LOGIC_VECTOR (4 downto 0); -- Read Register 2
   WR : in STD_LOGIC_VECTOR (4 downto 0); --Write Register
	WD : in STD_LOGIC_VECTOR (31 downto 0); -- Write data
	clk : in STD_LOGIC;
   RegWrite : in STD_LOGIC;
   RD1 : out STD_LOGIC_VECTOR (31 downto 0);
   RD2 : out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component ctrlUnit is
	port (
	Opcode : in std_logic_vector(5 downto 0);
	RegDst, Jump, BEQ,BNE, MemRead, MemToReg : out std_logic;
	MemWrite, ALUSrc, RegWrite: out std_logic;
	ALUOp: out std_logic_vector(1 downto 0)
);
end component;

component mux10x5 is
port (
		sel : in std_logic;
		a, b : in std_logic_vector(4 downto 0);
		z : out std_logic_vector(4 downto 0)
	);
end component;

component jumpShiftLeft2 -- once
port (
	slIn : in std_logic_vector(25 downto 0);
	slOut : out std_logic_vector(27 downto 0) 
);
end component;

component signExtend -- once
	port (
		seIn : in std_logic_vector(15 downto 0);
		seOut : out std_logic_vector(31 downto 0)
	);
end component;

component aluCtrl is
port (
	aluOpIn : in std_logic_vector(1 downto 0);
	functionBits : in std_logic_vector(5 downto 0);
	aluOpOut : out std_logic_vector(2 downto 0)
	
);
end component; 

component mux64to32 is
	port(
		sel : in std_logic;
		a, b : in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0)
	);
end component;

component branchShiftLeft2 is
	-- im thinking this one discards the msb ends 
	-- and the jump one doesnt, just adds 00
port (
	slIn : in std_logic_vector(31 downto 0);
	slOut : out std_logic_vector(31 downto 0) 
);
end component;

component ALUadder is
	
generic(g_carry_in : std_logic := '0');	
port (
	CarryIn : in std_logic := g_carry_in;
	aluIn1, aluIn2 : in std_logic_vector(31 downto 0);
	aluOut : out std_logic_vector(31 downto 0);
	carryOut : out std_logic
);
end component;

component dataMemory is  
    port(
        signal CLK, MEMREAD, MEMWRITE : in std_logic;
        signal ADDRESS, WRDATA : in std_logic_vector(31 downto 0);
        signal DATAOUT : out std_logic_vector(31 downto 0)
    );
end component;

component to_7seg is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
          seg7 : out  STD_LOGIC_VECTOR (6 downto 0)
             );
end component;

component BranchMuxCtrl is
port (
	zero,BEQ,BNE : in std_logic;
	muxSel: out std_logic
	
);
end component;


signal address, addressOut, PCaddress : std_logic_vector(31 downto 0); 
signal overflow: std_logic; 
signal labmuxout: std_logic_vector(7 downto 0); 
signal insmemout: std_logic_vector(31 downto 0);
signal jumpOut: std_logic_vector(27 downto 0);
signal RegDst, Jump, BEQ,BNE, MemRead, MemToReg,MemWrite, ALUSrc, RegWrite, zero: std_logic;
signal ALUOp:std_logic_vector(1 downto 0); 
signal other: std_logic_vector(7 downto 0);  
signal signExtOut: std_logic_vector(31 downto 0); 
signal writeReg: std_logic_vector(4 downto 0); 
signal writeData: std_logic_vector(31 downto 0); 
signal data1, data2: std_logic_vector(31 downto 0); 
signal aluOpOut: std_logic_vector(2 downto 0);
signal ALUMuxOut, branchmuxout : std_logic_vector(31 downto 0); 
signal aluout: std_logic_vector(31 downto 0); 
signal shlALUresultin: std_logic_vector(31 downto 0); 
signal branchALUout: std_logic_vector(31 downto 0);
signal carryALUout: std_logic;  
signal readdata: std_logic_vector(31 downto 0); 
signal branchMuxSelout: std_logic; 

begin
PC : PCReg port map (GClock, GReset, address, addressOut); 
PCadder: PC_adder32 port map (GClock, addressOut, PCaddress); 
InsMem : instructionMemory port map(PCaddress, GClock, InsMemOut); 
shl2jump: jumpShiftLeft2 port map(INSMemOut(25 DOWNTO 0), jumpOut); 
ctrl: ctrlUnit port map(InsMemOut(31 downto 26),RegDst, Jump, BEQ,BNE, MemRead, MemToReg,MemWrite, ALUSrc, RegWrite,ALUOp);
instregmux: mux10x5 port map(RegDst,InsMemOut(20 downto 16),InsMemOut(15 downto 11),writeReg);
signext: signExtend port map(InsMemOut(15 downto 0),signExtOut);
registerfile: regFile port map(InsMemOut(25 downto 21),InsMemOut(20 downto 16),writeReg,writeData,GClock,RegWrite,data1,data2); 
aluControl: aluCtrl port map(ALUOp, Insmemout(5 downto 0), aluOpOut); 
alumux: mux64to32 port map(ALUSrc,data2,signExtOut,AluMuxOut); 
MainALU:aluMain port map(data1,AluMuxOut,Aluout,zero,aluOpout);
shl2branch: branchShiftLeft2 port map(signExtOut, shlALUresultin); 
ALUbranch: ALUadder port map('0',PCaddress, shlALUresultin, branchALUout, carryALUout); 
--branchmuxsel: branchMuxCtrl port map (zero,BEQ,BNE,BranchMuxSelout); -- bonus line
--muxbranch: mux64to32 port map( BranchMuxSelout, PCaddress,branchALUout, branchmuxout);  -- bonus line 
muxbranch: mux64to32 port map(Beq and zero, PCaddress, branchALUout,branchmuxout); --hide this line for bonus
--jumpmux: mux64to32 port map(jump,branchmuxout, address); -- bonus line
jumpmux: mux64to32 port map(jump,branchmuxout,PCaddress(31 downto 28) & jumpOut, address); --hide for bonus
datamem: datamemory port map(gclock, MemRead, MemWrite, aluout, data2, readdata); 
muxdatamem: mux64to32 port map(MemToReg, aluout, readdata, writeData); 


outMux: top_mux8x8 port map(PCaddress(7 downto 0), aluout(7 downto 0), data1(7 downto 0), data2(7 downto 0), writeData(7 downto 0), other, other, other, valueSelect, labmuxout); 
other(0)<= zero;
other(1)<=RegDst;
other(2)<=Jump;
other(3)<=MemRead;
other(4)<=MemToReg;
other(6 downto 5)<=ALUOp;
other(7)<=ALUSrc;

--seg1 : to_7seg port map(insMemOut(3 downto 0),HEX0);
--seg2 : to_7seg port map(insMemOut(7 downto 4),HEX1);
--seg3: to_7seg port map (insMemOut(11 downto 8),HEX2); 
--seg4: to_7seg port map (insmemout(15 downto 12), hex3); 
--seg5: to_7seg port map (insmemout(19 downto 16), hex4); 
--seg6: to_7seg port map (insmemOut(23 downto 20), hex5); 
--seg7: to_7seg port map (insmemOut(27 downto 24), hex6); 
--seg8: to_7seg port map (insmemOut(31 downto 28), hex7); 
  
RegWriteOut<=RegWrite;
MemWriteOut<=MemWrite;
ZeroOut<=zero;
InstructionOut <= InsMemOut; 
MuxOut <= labmuxout; 
end topArch; 