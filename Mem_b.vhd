-- single port ram from the net
-- saufy

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem_b is
	port
	(
		dina		: in std_logic_vector(15 downto 0);
		addra		: in std_logic_vector(5 downto 0);
		wea		: in std_logic_vector(0 downto 0);
		clka		: in std_logic;
		douta		: out std_logic_vector(15 downto 0)
	);
	
end entity;

architecture rtl of Mem_b is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(15 downto 0);
	type memory_t is array(5 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : memory_t;
	
	-- Register to hold the address
	signal addr_reg : natural range 0 to 5;

begin

	process(clka)
	begin
		if(rising_edge(clka)) then
			if(wea <= "1") then
				ram(to_integer(unsigned(addra))) <= dina;
			end if;
			-- Register the address for reading
			addr_reg <= to_integer(unsigned(addra));
		end if;
	
	end process;
	
	douta <= ram(addr_reg);
	
end rtl;
