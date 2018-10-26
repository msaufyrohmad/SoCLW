--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:42:47 10/27/2017
-- Design Name:   
-- Module Name:   C:/Users/mrohmad/Desktop/Kajian/uart_tb.vhd
-- Project Name:  SoCLW
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart
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
 
ENTITY uart_tb IS
END uart_tb;
 
ARCHITECTURE behavior OF uart_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         BAUDCE : IN  std_logic;
         CS : IN  std_logic;
         WR : IN  std_logic;
         RD : IN  std_logic;
         A : IN  std_logic_vector(2 downto 0);
         DIN : IN  std_logic_vector(7 downto 0);
         DOUT : OUT  std_logic_vector(7 downto 0);
         DDIS : OUT  std_logic;
         INT : OUT  std_logic;
         OUT1N : OUT  std_logic;
         OUT2N : OUT  std_logic;
         RCLK : IN  std_logic;
         BAUDOUTN : OUT  std_logic;
         RTSN : OUT  std_logic;
         DTRN : OUT  std_logic;
         CTSN : IN  std_logic;
         DSRN : IN  std_logic;
         DCDN : IN  std_logic;
         RIN : IN  std_logic;
         SIN : IN  std_logic;
         SOUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal BAUDCE : std_logic := '0';
   signal CS : std_logic := '0';
   signal WR : std_logic := '0';
   signal RD : std_logic := '0';
   signal A : std_logic_vector(2 downto 0) := (others => '0');
   signal DIN : std_logic_vector(7 downto 0) := (others => '0');
   signal RCLK : std_logic := '0';
   signal CTSN : std_logic := '0';
   signal DSRN : std_logic := '0';
   signal DCDN : std_logic := '0';
   signal RIN : std_logic := '0';
   signal SIN : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic_vector(7 downto 0);
   signal DDIS : std_logic;
   signal INT : std_logic;
   signal OUT1N : std_logic;
   signal OUT2N : std_logic;
   signal BAUDOUTN : std_logic;
   signal RTSN : std_logic;
   signal DTRN : std_logic;
   signal SOUT : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
   constant RCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart PORT MAP (
          CLK => CLK,
          RST => RST,
          BAUDCE => BAUDCE,
          CS => CS,
          WR => WR,
          RD => RD,
          A => A,
          DIN => DIN,
          DOUT => DOUT,
          DDIS => DDIS,
          INT => INT,
          OUT1N => OUT1N,
          OUT2N => OUT2N,
          RCLK => RCLK,
          BAUDOUTN => BAUDOUTN,
          RTSN => RTSN,
          DTRN => DTRN,
          CTSN => CTSN,
          DSRN => DSRN,
          DCDN => DCDN,
          RIN => RIN,
          SIN => SIN,
          SOUT => SOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   RCLK_process :process
   begin
		RCLK <= '0';
		wait for RCLK_period/2;
		RCLK <= '1';
		wait for RCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- first stimulus set
			RST <= '0';--: IN  std_logic;
         BAUDCE <='1';--: IN  std_logic;
         CS <= '1';--: IN  std_logic;
         WR <='1';--: IN  std_logic;
         RD <='1';--: IN  std_logic;
         A <="111";--: IN  std_logic_vector(2 downto 0);
         DIN <="11111111";--: IN  std_logic_vector(7 downto 0);
			RCLK <='1';--: IN  std_logic;
			CTSN <='1';--: IN  std_logic;
         DSRN <='1';--: IN  std_logic;
         DCDN <='1';--: IN  std_logic;
         RIN <='1';--: IN  std_logic;
         SIN <='1';--: IN  std_logic;
			wait for clk_period;
			
			 -- first stimulus set
			RST <= '1';--: IN  std_logic;
         BAUDCE <='1';--: IN  std_logic;
         CS <= '1';--: IN  std_logic;
         WR <='1';--: IN  std_logic;
         RD <='1';--: IN  std_logic;
         A <="111";--: IN  std_logic_vector(2 downto 0);
         DIN <="11111111";--: IN  std_logic_vector(7 downto 0);
			RCLK <='1';--: IN  std_logic;
			CTSN <='1';--: IN  std_logic;
         DSRN <='1';--: IN  std_logic;
         DCDN <='1';--: IN  std_logic;
         RIN <='1';--: IN  std_logic;
         SIN <='1';--: IN  std_logic;


      wait;
   end process;

END;
