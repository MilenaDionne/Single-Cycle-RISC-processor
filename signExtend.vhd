library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signExtend is
	port (
	seIn : in std_logic_vector(15 downto 0);
	seOut : out std_logic_vector(31 downto 0)
	);
end entity;

architecture behave of signExtend is
begin

seOut(31 downto 16) <=(others=>seIn(15));
seOut(15 downto 0) <= seIn;

end architecture;