--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- instruction decoder module
--********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instdecoder is
    Port ( I_clk : in  STD_LOGIC;
           I_dataInst : in  STD_LOGIC_VECTOR (15 downto 0);-- data from ram
			  O_addr	: out STD_LOGIC_VECTOR(15 downto 0);--address to read from ram
           I_decoder_en : in  STD_LOGIC
			  );
           
	end instdecoder;

architecture Behavioral of instdecoder is

begin
 
  process (I_clk)
  begin
    if rising_edge(I_clk) and I_decoder_en = '1' then
 
     case I_dataInst(15 downto 12) is
        when "0000" =>   -- LOAD from memory to R0
         O_addr<="1111" & I_dataInst(11 downto 0);
			
        when "0001" =>   -- store
         
			   
        when "0010" =>   -- move
          
		 
		  
		  when "0011" => -- add
		  				
        when others =>
         
      end case;
    end if;
  end process;
  
  end Behavioral;

