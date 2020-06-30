library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all; 

entity PC_adder32 is
	port(
				CLK : in STD_LOGIC;
           PC_in : in STD_LOGIC_VECTOR(31 downto 0);
           PC_out : out STD_LOGIC_VECTOR(31 downto 0)
);
end PC_adder32;

architecture archPCadd of pc_adder32 is 

signal pcout: std_logic_vector(31 downto 0); 

begin

process(clk) 
	begin 
		if rising_edge(clk) then  
			pcout<= std_logic_vector(unsigned(pcout) + 4);  
		
		end if; 
	end process; 
	pc_out <= pcout; 
	 
	
end archPCadd; 