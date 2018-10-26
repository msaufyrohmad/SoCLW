--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:00:28 10/27/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/cpu_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: s16
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
 
ENTITY cpu_tb IS
END cpu_tb;
 
ARCHITECTURE behavior OF cpu_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT s16
    PORT(
         I_clk : IN  std_logic;
         I_dataInst : IN  std_logic_vector(15 downto 0);
         O_we : OUT  std_logic;
         O_addr : OUT  std_logic_vector(15 downto 0);
         O_data : OUT  std_logic_vector(15 downto 0);
         I_dataWriteReg : IN  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal I_clk : std_logic := '0';
   signal I_dataInst : std_logic_vector(15 downto 0) := (others => '0');
   signal I_dataWriteReg : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal O_we : std_logic;
   signal O_addr : std_logic_vector(15 downto 0);
   signal O_data : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant I_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: s16 PORT MAP (
          I_clk => I_clk,
          I_dataInst => I_dataInst,
          O_we => O_we,
          O_addr => O_addr,
          O_data => O_data,
          I_dataWriteReg => I_dataWriteReg
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

      -- stimulus, first
		I_dataInst <=X"FFFF";--: IN  std_logic_vector(15 downto 0);
		I_dataWriteReg <=X"1111";--: IN  std_logic_vector(15 downto 0);
		wait for I_clk_period;
			
		-- stimulis, second
		I_dataInst <=X"1111";--: IN  std_logic_vector(15 downto 0);
		I_dataWriteReg <=X"FFFF";--: IN  std_logic_vector(15 downto 0);
		wait for I_clk_period;
			
      wait;
   end process;

END;
