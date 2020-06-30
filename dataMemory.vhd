library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity dataMemory is  
    port(
        signal CLK, MEMREAD, MEMWRITE : in std_logic;
        signal ADDRESS, WRDATA : in std_logic_vector(31 downto 0);
        signal DATAOUT : out std_logic_vector(31 downto 0)
    );
end entity dataMemory;


architecture behavior of dataMemory is
    type memory is array(31 downto 0) of std_logic_vector(7 downto 0);
    signal dataMem: memory;
    
    begin

        writeMem : process(CLK, ADDRESS, MEMWRITE, WRDATA)
            begin
                if rising_edge(CLK) and MEMWRITE = '1' then
                    case ADDRESS(31 downto 0) is
                        when X"00000000" =>
                            dataMem(0) <= WRDATA(31 downto 24);
                            dataMem(1) <= WRDATA(23 downto 16);
                            dataMem(2) <= WRDATA(15 downto 8);
                            dataMem(3) <= WRDATA(7 downto 0);

                        when X"00000004" =>
                            dataMem(4) <= WRDATA(31 downto 24);
                            dataMem(5) <= WRDATA(23 downto 16);
                            dataMem(6) <= WRDATA(15 downto 8);
                            dataMem(7) <= WRDATA(7 downto 0);

                        when X"00000008" =>
                            dataMem(8) <= WRDATA(31 downto 24);
                            dataMem(9) <= WRDATA(23 downto 16);
                            dataMem(10) <= WRDATA(15 downto 8);
                            dataMem(11) <= WRDATA(7 downto 0);

                        when X"0000000C" =>
                            dataMem(12) <= WRDATA(31 downto 24);
                            dataMem(13) <= WRDATA(23 downto 16);
                            dataMem(14) <= WRDATA(15 downto 8);
                            dataMem(15) <= WRDATA(7 downto 0);

                        when X"00000010" =>
                            dataMem(16) <= WRDATA(31 downto 24);
                            dataMem(17) <= WRDATA(23 downto 16);
                            dataMem(18) <= WRDATA(15 downto 8);
                            dataMem(19) <= WRDATA(7 downto 0);

                        when X"00000014" =>
                            dataMem(20) <= WRDATA(31 downto 24);
                            dataMem(21) <= WRDATA(23 downto 16);
                            dataMem(22) <= WRDATA(15 downto 8);
                            dataMem(23) <= WRDATA(7 downto 0);


                        when X"00000018" =>
                            dataMem(24) <= WRDATA(31 downto 24);
                            dataMem(25) <= WRDATA(23 downto 16);
                            dataMem(26) <= WRDATA(15 downto 8);
                            dataMem(27) <= WRDATA(7 downto 0);

                        when X"0000001C" =>
                            dataMem(28) <= WRDATA(31 downto 24);
                            dataMem(29) <= WRDATA(23 downto 16);
                            dataMem(30) <= WRDATA(15 downto 8);
                            dataMem(31) <= WRDATA(7 downto 0);
   
                        when others => null;
                    end case;
                end if;
        end process;

        readMem : process(CLK, ADDRESS, MEMREAD)
            begin
                if MEMREAD = '1' then
                    case ADDRESS(31 downto 0) is
                        when X"00000000" =>
                            DATAOUT <= dataMem(0) & dataMem(1) & dataMem(2) & dataMem(3);

                        when X"00000004" =>
                            DATAOUT <= dataMem(4) & dataMem(5) & dataMem(6) & dataMem(7);

                        when X"00000008" =>
                            DATAOUT <= dataMem(8) & dataMem(9) & dataMem(10) & dataMem(11);

                        when X"0000000C" =>
                            DATAOUT <= dataMem(12) & dataMem(13) & dataMem(14) & dataMem(15);

                        when X"00000010" =>
                            DATAOUT <= dataMem(16) & dataMem(17) & dataMem(18) & dataMem(19);

                        when X"00000014" =>
                            DATAOUT <= dataMem(20) & dataMem(21) & dataMem(22) & dataMem(23);

                        when X"00000018" =>
                            DATAOUT <= dataMem(24) & dataMem(25) & dataMem(26) & dataMem(27);

                        when X"0000001C" =>
                            DATAOUT <= dataMem(28) & dataMem(29) & dataMem(30) & dataMem(31);
         when others => null;
                    end case;
                end if;
        end process;
        
end architecture behavior;