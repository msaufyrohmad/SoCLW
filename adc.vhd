--**********************************************************************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- adc module
-- https://www.pantechsolutions.net/fpga-tutorials/adc-interface-with-spartan6-fpga-project-kit
--**********************************************************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adc is
port ( I_clk   : in std_logic;
       O_cs    : out std_logic;
		 O_sc  	: out std_logic;
		 O_do    : out std_logic;
		 I_din   : in std_logic;
		 O_data   : out std_logic_vector(11 downto 0));
end adc;

architecture Behavioral of adc is
	type state is (spi,conversion,transmission);-- enum in vhdl kan?
	signal presentstate : state := spi;
	signal f : std_logic;
	type arr is array (0 to 12) of std_logic_vector(9 downto 0); 
	signal store : arr;
begin
process(I_clk)
	--variable i : std_logic_vector(12 downto 0) := "0000000000000";   
	variable i,j,k : integer := 0;
	variable tot : std_logic_vector(11 downto 0) := "000000000000";
	begin
			if I_clk'event and I_clk = '1' then
			if presentstate = spi then
			if i <= 50 then   ---"0000000110010" then
			i := i + 1;
			O_sc <= '1';
	elsif i > 50 and i < 100 then      ---"0000000110010" and i < "0000001100100" then
			i := i + 1;
			O_sc <= '0';
	elsif i = 100 then    ---"0000001100100" then
			i := 0;    ----"0000000000000";
	if j < 18 then
		j := j + 1;
	elsif j = 18 then
			presentstate <= conversion;
			j := 0; 
	end if;
	end if;
	if j = 0 or j >= 18 then
		O_cs <= '1';
	else
		O_cs <= '0';
	end if;
		if i > 40 and i < 60 then ---   "0000000101000" and i < "0000000111100" then
	case j is
		when 0 =>
			O_do <= '0';
		when 1 =>
			O_do <= '1';
		when 2 =>
			O_do <= '1';
		when 3 =>
			O_do <= '0';          -----channel bit
		when 4 =>
			O_do <= '1';
		when others =>
		null;
	end case;
	end if;

	if i >= 0 and i < 10 then --"0000000000000" and i < "0000000001010" then
		case j is
			when 6 =>
				tot(11) := I_din;
			when 7 =>
				tot(10) := I_din;
			when 8 =>
				tot(9) := I_din;
			when 9 =>
				tot(8) := I_din;
			when 10 =>
				tot(7) := I_din;
			when 11 =>
				tot(6) := I_din;
			when 12 =>
				tot(5) := I_din;
			when 13 =>
				tot(4) := I_din;
			when 14 =>
				tot(3) := I_din;
			when 15 =>
				tot(2) := I_din;
			when 16 =>
				tot(1) := I_din;
			when 17 =>
				tot(0) := I_din;
			when others =>
				null;
		end case;
	end if; 
end if;
--------------------------------------------------------------
	if presentstate = conversion then
		O_cs <= '1';
		O_data <= tot;
	if i < 5000 then --"1001110001000" then
		i := i + 1;
		elsif i = 5000 then   --"1001110001000" then
		i := 0;    ---"0000000000000";
		presentstate <= spi;
		end if;
	end if;
	end if;

end process;
end Behavioral;