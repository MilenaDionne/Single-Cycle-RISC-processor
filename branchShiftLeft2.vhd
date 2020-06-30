library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity branchShiftLeft2 is
	-- im thinking this one discards the msb ends 
	-- and the jump one doesnt, just adds 00
port (
	slIn : in std_logic_vector(31 downto 0);
	slOut : out std_logic_vector(31 downto 0) 
);
end entity;

architecture bsl of branchShiftLeft2 is
signal temp: std_logic_vector(29 downto 0);
begin
       temp<=slIn(29 downto 0);	 
	   slOut(31 downto 2)<=temp;
	   slOut(1 downto 0)<= (others=>'0');
	 
end bsl;

