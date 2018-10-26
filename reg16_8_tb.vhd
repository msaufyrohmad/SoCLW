library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY reg16_8_tb IS
END reg16_8_tb;
 
ARCHITECTURE behavior OF reg16_8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
COMPONENT reg16_8 
PORT ( I_clk : in  STD_LOGIC;
       I_reg_en : in  STD_LOGIC;
       I_reg_we : in  STD_LOGIC;
		 I_dataWrite : in  STD_LOGIC_VECTOR (15 downto 0);
       O_dataRead : out  STD_LOGIC_VECTOR (15 downto 0);
       I_selRead : in  STD_LOGIC_VECTOR (2 downto 0);
		 I_selWrite: in STD_LOGIC_VECTOR(2 downto 0)
       );
END COMPONENT; 
 
  --Inputs
   signal I_clk : std_logic := '0';
   signal I_reg_en : std_logic := '0';
   signal I_dataWrite : std_logic_vector(15 downto 0) := (others => '0');
   signal I_selRead : std_logic_vector(2 downto 0) := (others => '0');
   signal I_selWrite : std_logic_vector(2 downto 0) := (others => '0');
   signal I_reg_we : std_logic := '0';
 
  --Outputs
   signal O_dataRead : std_logic_vector(15 downto 0);
   
   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
 
BEGIN
 
  -- Instantiate the Unit Under Test (UUT)
   uut: reg16_8 PORT MAP 
		(
          I_clk => I_clk,
          I_reg_en => I_reg_en,
          I_dataWrite => I_dataWrite,
          O_dataRead => O_dataRead,
          I_selWrite => I_selWrite,
          I_selRead => I_selRead,
          I_reg_we => I_reg_we
      );
 
   -- Clock process definitions
   I_clk_process :process
   begin
    I_clk <= '0';
    wait for I_clk_period/2;
    I_clk <= '1';
    wait for I_clk_period/2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin
      -- hold reset state for 100 ns.
      wait for 100 ns;  
 
      wait for I_clk_period*10;
 
      -- insert stimulus here 
 
    I_reg_en <= '1';
 
    -- test for writing.
    -- r0 = 0x1111
    --I_selRead <= "000";
    I_selWrite <= "000";
    I_dataWrite <= X"1111";
    I_reg_we <= '1';
      wait for I_clk_period;
 
    -- r2 = 0x2222
    I_selWrite <= "001";
    I_dataWrite <= X"2222";
    I_reg_we <= '1';
      wait for I_clk_period;
 
    -- r3 = 0x3333
    I_selWrite <= "010";
    I_dataWrite <= X"3333";
    I_reg_we <= '1';
      wait for I_clk_period;
 
    --test just reading, with no write
    I_selRead <= "000";
    I_reg_we <= '0';
      wait for I_clk_period;
 
    --at this point I_dataRead should not be 'feed'
    I_selRead <= "000";
    I_reg_we <= '0';
      wait for I_clk_period;
 
    I_selRead <= "001";
    I_reg_we <= '0';
      wait for I_clk_period;
 
    I_selRead <= "010";
    I_reg_we <= '0';
      wait for I_clk_period;
 
      wait;
   end process;
 
END;
