library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 1 bit Full adder

entity adder is
	PORT ( Cin, x, y : IN STD_LOGIC ;
			s, Cout : OUT STD_LOGIC );
end entity;

architecture addArch of adder is
	
begin	
s <= (x XOR y) XOR Cin;
Cout <= (x AND y) OR (Cin AND (x xor y));
end addArch;
