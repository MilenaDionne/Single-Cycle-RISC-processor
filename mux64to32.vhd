library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 2 inputs mux (32 bits). Used 2 times for:
-- branch or jump selection
-- PC input
entity mux64to32 is
	port(
		sel : in std_logic;
		a, b : in std_logic_vector(31 downto 0);
		z : out std_logic_vector(31 downto 0)
	);
end entity mux64to32;

architecture muxBehave of mux64to32 is

component mux1x2 is	
port(
		sel : in std_logic;
		a, b : in std_logic;
		z : out std_logic
	);	
end component;	

begin
	
	generate8: for i in 0 to 31 generate
	
	mux_gen: mux1x2 port map(a => a(i), b => b(i), sel => sel, z => z(i));	
	end generate;
end architecture muxBehave;

