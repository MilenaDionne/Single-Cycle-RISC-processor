library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALUmain is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
    B : in  STD_LOGIC_VECTOR (31 downto 0);
	Y : buffer  STD_LOGIC_VECTOR (31 downto 0);
	Z : out  STD_LOGIC;
    S : in  STD_LOGIC_VECTOR (2 downto 0));
end ALUmain;

architecture Behavioral of ALUmain is

begin
	process(A, B, S)
	
		variable temp: STD_LOGIC_VECTOR(31 downto 0);
	
	begin	
	
	case S is
		when "000" =>
			y <= a and b;
		when "001" =>
			y <= a or b;
		when "010" =>
			y <= not a;
		when "011" =>
			y <= not b;
		when "100" =>
			y <= a nand b;
		when "101" =>
			y <= a nor b;
		when "110" =>
			y <= a xor b;
		when others =>
			y <= X"00000000";
		end case;
				
	end process;
	
	z <= '1' when CONV_INTEGER(UNSIGNED(y)) = 0 else
		  '0';

end Behavioral;