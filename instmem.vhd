--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- instruction memory 16bit x 36bit module
-- 9/10/2017
--********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instmem  is
    Port ( I_clk : in  STD_LOGIC;
           I_we_i : in  STD_LOGIC;
           I_addr_i : in  STD_LOGIC_VECTOR (15 downto 0);
           I_data_i : in  STD_LOGIC_VECTOR (35 downto 0);
           O_data_i : out  STD_LOGIC_VECTOR (35 downto 0)
			  );
end instmem;

architecture Behavioral of instmem is
    type store_t is array (0 to 15) of std_logic_vector(35 downto 0);
    signal imem_16: store_t ;
begin
 
    process (I_clk)
    begin
        if rising_edge(I_clk) then
            if (I_we_i = '1') then
                imem_16(to_integer(unsigned(I_addr_i(15 downto 0)))) <= I_data_i;
            else
                O_data_i <= imem_16(to_integer(unsigned(I_addr_i(15 downto 0))));
            end if;
        end if;
    end process;
 
end Behavioral;
