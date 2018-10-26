--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- arithmetic logic unit module
--********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is Port (
    I_clk : in  STD_LOGIC;
    I_alu_en :  in  STD_LOGIC;
	 I_aluop	:in STD_LOGIC_VECTOR(4 downto 0)
	 );  	 
  
end alu;


architecture Behavioral of alu is

    -- cmp output bits
	constant OPCODE_LOAD:std_logic_vector:="0000";
	constant OPCODE_STORE:std_logic_vector:="0001";
	
begin
  process (I_clk, I_alu_en)
  begin
    if rising_edge(I_clk) and I_alu_en = '1' then
      case I_aluop(4 downto 1) is
      	
		when OPCODE_LOAD =>
			
		when OPCODE_STORE =>
			
      -- ...Other OPCODEs go here...
      when others =>
        
      end case;
    end if;
  end process;
 
  
end Behavioral;

