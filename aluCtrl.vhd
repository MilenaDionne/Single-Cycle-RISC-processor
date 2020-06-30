library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aluCtrl is
port (
	aluOpIn : in std_logic_vector(1 downto 0);
	functionBits : in std_logic_vector(5 downto 0);
	aluOpOut : out std_logic_vector(2 downto 0)
	
);
end entity;

architecture ALUCtrlArch of aluctrl is 
	
--signals and components
	signal sig0, sig1, op2, op1, op0 : std_logic;

begin
	
	-- internal logic
	-- does this work this way?
	sig0 <= functionbits(0) or functionBits(3);
	sig1 <= aluOpIn(1) and functionBits(1);
	op2 <= aluOpIn(0) or sig1;
	op1 <= not(aluOpIn(1)) or not(functionBits(2));
	op0 <= aluopIn(1) and sig0;
	
	-- output logic
	aluOpOut(2) <= op2;
	aluOpOut(1) <= op1;	
	aluOpOut(0) <= op0;
end architecture;
