--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- data memory 16bit x 16bit module
-- 9/10/2017
--********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datamem  is
    Port ( I_clk : in  STD_LOGIC;
           I_we_d : in  STD_LOGIC;
           I_addr_d : in  STD_LOGIC_VECTOR (15 downto 0);
           I_data_d : in  STD_LOGIC_VECTOR (15 downto 0);
           O_data_d : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
end datamem;

architecture Behavioral of datamem is
    type store_t is array (15 downto 0) of std_logic_vector(15 downto 0);
    signal dmem_16: store_t;
begin
 
    process (I_clk)
    begin
        if rising_edge(I_clk) then
            if (I_we_d = '1') then
                dmem_16(to_integer(unsigned(I_addr_d(15 downto 0)))) <= I_data_d;
            else
                O_data_d <= dmem_16(to_integer(unsigned(I_addr_d(15 downto 0))));
            end if;
        end if;
    end process;
 
end Behavioral;

