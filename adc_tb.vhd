--**********************************************************************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- adc module testbench
-- https://www.pantechsolutions.net/fpga-tutorials/adc-interface-with-spartan6-fpga-project-kit
--**********************************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY adc_tb IS
END adc_tb;
 
ARCHITECTURE behavior OF adc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adc
    PORT(
         I_clk : IN  std_logic;
         O_cs : OUT  std_logic;
         O_sc : OUT  std_logic;
         O_do : OUT  std_logic;
         I_din : IN  std_logic;
         O_data : OUT  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I_clk : std_logic := '0';
   signal I_din : std_logic := '0';

 	--Outputs
   signal O_cs : std_logic;
   signal O_sc : std_logic;
   signal O_do : std_logic;
   signal O_data : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adc PORT MAP (
          I_clk => I_clk,
          O_cs => O_cs,
          O_sc => O_sc,
          O_do => O_do,
          I_din => I_din,
          O_data => O_data
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
		-- vector for "111100001111"
		I_din<='1'; -- first bit
		wait for I_clk_period;
		I_din<='0'; --second
		wait for I_clk_period;
		I_din<='1'; -- third
		wait for I_clk_period;
		I_din<='0'; --forth
		wait for I_clk_period;
		
		I_din<='0'; -- fifth
		wait for I_clk_period;
		I_din<='1'; -- six
		wait for I_clk_period;
		I_din<='1'; -- seventh
		wait for I_clk_period;
		I_din<='0'; --eithght
		wait for I_clk_period;
      
		I_din<='1'; -- ninth
		wait for I_clk_period;
		I_din<='1'; -- tenth
		wait for I_clk_period;
		I_din<='0'; -- eleventh
		wait for I_clk_period;
		I_din<='0'; -- twelveth
		wait for I_clk_period;
      
      wait;
   end process;

END;
