--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:36:51 11/06/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/montgomery_mult_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: montgomery_mult
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY montgomery_mult_tb IS
END montgomery_mult_tb;
 
ARCHITECTURE behavior OF montgomery_mult_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT montgomery_mult
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         valid_in : IN  std_logic;
         a : IN  std_logic_vector(15 downto 0);
         b : IN  std_logic_vector(15 downto 0);
         n : IN  std_logic_vector(15 downto 0);
         s_prev : IN  std_logic_vector(15 downto 0);
         n_c : IN  std_logic_vector(15 downto 0);
         s : OUT  std_logic_vector(15 downto 0);
         valid_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal valid_in : std_logic := '0';
   signal a : std_logic_vector(15 downto 0) := (others => '0');
   signal b : std_logic_vector(15 downto 0) := (others => '0');
   signal n : std_logic_vector(15 downto 0) := (others => '0');
   signal s_prev : std_logic_vector(15 downto 0) := (others => '0');
   signal n_c : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal s : std_logic_vector(15 downto 0);
   signal valid_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: montgomery_mult PORT MAP (
          clk => clk,
          reset => reset,
          valid_in => valid_in,
          a => a,
          b => b,
          n => n,
          s_prev => s_prev,
          n_c => n_c,
          s => s,
          valid_out => valid_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		reset <='1';
      --valid_in <= '1';
      a <= X"0000";
      b <= X"FFFF";
      n <=X"1111";
      s_prev <=X"0101";
      n_c <=X"0011";
		wait for clk_period;
		valid_in <= '1';
      wait;
   end process;

END;
