--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:23:10 11/06/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/n_c_core_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: n_c_core
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
 
ENTITY n_c_core_tb IS
END n_c_core_tb;
 
ARCHITECTURE behavior OF n_c_core_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT n_c_core
    PORT(
         clk : IN  std_logic;
         m_lsw : IN  std_logic_vector(15 downto 0);
         ce : IN  std_logic;
         n_c : OUT  std_logic_vector(15 downto 0);
         done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal m_lsw : std_logic_vector(15 downto 0) := (others => '0');
   signal ce : std_logic := '0';

 	--Outputs
   signal n_c : std_logic_vector(15 downto 0);
   signal done : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: n_c_core PORT MAP (
          clk => clk,
          m_lsw => m_lsw,
          ce => ce,
          n_c => n_c,
          done => done
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
		m_lsw <= X"FFFF";
      ce <='1';
		
		wait for clk_period*10;
		m_lsw <= X"0000";
      ce <='1';
		
		wait for clk_period*10;
		m_lsw <= X"0F0F";
      ce <='1';
		
		wait;
   end process;

END;
