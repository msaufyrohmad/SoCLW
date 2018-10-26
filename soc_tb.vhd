--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:27:41 10/27/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/soc_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: soc
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
 
ENTITY soc_tb IS
END soc_tb;
 
ARCHITECTURE behavior OF soc_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT soc
    PORT(
         soc_clk : IN  std_logic;
         I_din : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal soc_clk : std_logic := '0';
   signal I_din : std_logic := '0';

   -- Clock period definitions
   constant soc_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: soc PORT MAP (
          soc_clk => soc_clk,
          I_din => I_din
        );

   -- Clock process definitions
   soc_clk_process :process
   begin
		soc_clk <= '0';
		wait for soc_clk_period/2;
		soc_clk <= '1';
		wait for soc_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for soc_clk_period*10;

      -- stimulus for 12 bit adc input to soc, 1111 0000 1111 vector 
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '0';
		wait for soc_clk_period;
		
		I_din <= '0';
		wait for soc_clk_period;
		
		I_din <= '0';
		wait for soc_clk_period;
		
		I_din <= '0';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
		I_din <= '1';
		wait for soc_clk_period;
		
      wait;
   end process;

END;
