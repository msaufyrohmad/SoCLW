--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- cpu register module testbench
--********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg16_8 is
Port ( I_clk : in  STD_LOGIC;
       I_reg_en : in  STD_LOGIC;
       I_reg_we : in  STD_LOGIC;
		 I_dataWrite : in  STD_LOGIC_VECTOR (15 downto 0);
       O_dataRead : out  STD_LOGIC_VECTOR (15 downto 0);
       I_selRead : in  STD_LOGIC_VECTOR (2 downto 0);
		 I_selWrite: in STD_LOGIC_VECTOR(2 downto 0)
       );
end reg16_8;
 
architecture Behavioral of reg16_8 is
  type store_t is array (0 to 7) of std_logic_vector(15 downto 0);
  signal regs: store_t := (others => X"0000");
begin
	process(I_clk)
	begin
  if rising_edge(I_clk) and I_reg_en='1' then
    O_dataRead <= regs(to_integer(unsigned(I_selRead)));
     if (I_reg_we = '1') then
      regs(to_integer(unsigned(I_selWrite))) <= I_dataWrite;
    end if;
  end if;
end process;

end Behavioral;
