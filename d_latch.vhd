library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity d_latch is
   port(d, clk, rst: in std_logic; q: out std_logic);
end d_latch;

architecture basic of d_latch is

begin
     process(clk)

     begin
	  
        if rst = '1' then
        	q <= '0';
        elsif clk = '1' then	
    		q <= d ;
    	end if;
        
     end process;
end basic;


