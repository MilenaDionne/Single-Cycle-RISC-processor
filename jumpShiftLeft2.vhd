-- This shift component is used for the Jump operation

library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jumpShiftLeft2 is
	-- im thinking this one adds the 00 to LSB
	-- and extends the size and the 
	-- branch one doesnt, but discards 2 MSB
port (
	slIn : in std_logic_vector(25 downto 0);
	slOut : out std_logic_vector(27 downto 0) 
);
end entity;
architecture jsl of jumpShiftLeft2 is
signal temp: std_logic_vector(25 downto 0);
begin
     temp<=slIn;
	   slOut(27 downto 2)<=temp;
	   slOut(1 downto 0)<= (others=>'0');
	 
end jsl;