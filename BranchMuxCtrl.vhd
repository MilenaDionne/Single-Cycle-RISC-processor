library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BranchMuxCtrl is
port (
	zero,BEQ,BNE : in std_logic;
	muxSel: out std_logic
	
);
end entity;

architecture logic of BranchMuxCtrl is
signal branchE,branchNE:std_logic; 
begin
        branchE   <= BEQ and zero;
	branchNE <= BNE and (not zero);
	muxSel    <= branchE or branchNE;
end architecture logic;