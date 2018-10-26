----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:12:17 11/15/2017 
-- Design Name: 
-- Module Name:    mult18x18 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult18x18 is
port 
	(
	A	:in std_logic_vector(17 downto 0);
	B	:in std_logic_vector(17 downto 0);
	P	:out std_logic_vector(35 downto 0)
	);
end mult18x18;

architecture Behavioral of mult18x18 is
begin
		P <= A*B;
end Behavioral;

