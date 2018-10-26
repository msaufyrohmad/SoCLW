--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:33:15 10/27/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/rng_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rng
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
 
ENTITY rng_tb IS
END rng_tb;
 
ARCHITECTURE behavior OF rng_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rng
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         reseed : IN  std_logic;
         newkey : IN  std_logic_vector(79 downto 0);
         newiv : IN  std_logic_vector(79 downto 0);
         out_ready : IN  std_logic;
         out_valid : OUT  std_logic;
         out_data : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal reseed : std_logic := '0';
   signal newkey : std_logic_vector(79 downto 0) := (others => '0');
   signal newiv : std_logic_vector(79 downto 0) := (others => '0');
   signal out_ready : std_logic := '0';

 	--Outputs
   signal out_valid : std_logic;
   signal out_data : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rng PORT MAP (
          clk => clk,
          rst => rst,
          reseed => reseed,
          newkey => newkey,
          newiv => newiv,
          out_ready => out_ready,
          out_valid => out_valid,
          out_data => out_data
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

		-- first stimulis set
		rst <= '0';--: IN  std_logic;
      reseed <= '0';--: IN  std_logic;
      newkey <= X"FFFFFFFFFFFFFFFFFFFF";--: IN  std_logic_vector(79 downto 0);
      newiv  <= X"11223344556677889900";--: IN  std_logic_vector(79 downto 0);
      out_ready <= '1';--: IN  std_logic;
      wait for clk_period;
	
		-- second stimulus set
		rst <= '0';--: IN  std_logic;
      reseed <= '0';--: IN  std_logic;
      newkey <= X"11223344556677889900";--: IN  std_logic_vector(79 downto 0);
      newiv  <= X"FFFFFFFFFFFFFFFFFFFF";--: IN  std_logic_vector(79 downto 0);
      out_ready <= '1';--: IN  std_logic;
      wait for clk_period;
		

      wait;
   end process;

END;
