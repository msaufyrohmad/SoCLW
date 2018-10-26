--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- program counter module
--********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
port
(
	I_clk	:in	std_logic;
	I_reset: in std_logic;
	I_jump:in	std_logic_vector(15 downto 0);
	O_pc_addr:out std_logic_vector(15 downto 0)
);
end pc;
	
architecture Behavioral of pc is
	signal c:std_logic_vector(15 downto 0):=X"0000";
begin
	process(I_clk,I_reset)
		begin 
		if I_reset='1' then 
			c<=X"0000";
		elsif(rising_edge(I_clk))then
			if c=X"0001" then
			c<=X"0001";
			else
				c <=c+1;
			end if;
		end if;
	end process;
	O_pc_addr <=c;
end Behavioral;

