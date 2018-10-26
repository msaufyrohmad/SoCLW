--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:22:11 10/27/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/PresentEnc_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PresentEnc
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
 
ENTITY PresentEnc_tb IS
END PresentEnc_tb;
 
ARCHITECTURE behavior OF PresentEnc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PresentEnc
    PORT(
         plaintext : IN  std_logic_vector(63 downto 0);
         key : IN  std_logic_vector(79 downto 0);
         ciphertext : OUT  std_logic_vector(63 downto 0);
         start : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         ready : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal plaintext : std_logic_vector(63 downto 0) := (others => '0');
   signal key : std_logic_vector(79 downto 0) := (others => '0');
   signal start : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal ciphertext : std_logic_vector(63 downto 0);
   signal ready : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PresentEnc PORT MAP (
          plaintext => plaintext,
          key => key,
          ciphertext => ciphertext,
          start => start,
          clk => clk,
          reset => reset,
          ready => ready
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
		plaintext 	<= X"FFFFFFFFFFFFFFFF";		--: IN  std_logic_vector(63 downto 0);
      key		 	<= X"11223344556677889900";--: IN  std_logic_vector(79 downto 0);
		start 		<='1';							--: IN  std_logic;
      reset			<='0';				 			--: IN  std_logic;
		
      wait;
   end process;

END;
