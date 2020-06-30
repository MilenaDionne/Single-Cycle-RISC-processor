
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity regFile is -- once
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
end regFile; 

architecture Behavioral of regfile is -- 8 Registers, 16 bits each
    type reg_array is array(0 to 7) of STD_LOGIC_VECTOR (31 downto 0);
    signal reg_file: reg_array := (others => x"00000000"); -- assign all 0
    
begin
    process(clk)
    begin
        if rising_edge(clk) then -- Data written out or to registers
            RD1 <= "000000000000000000000000000" & RR1 ; 
            RD2 <= "000000000000000000000000000" & RR2 ; 
            
            if RegWrite ='1' then
                reg_file(to_integer(unsigned(WR))) <= WD;
					 
            end if;
        end if;
    end process;

end Behavioral;
