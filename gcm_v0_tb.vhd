--**************************
-- gcm top module testbench
-- mohd saufy rohmad
-- SoC LW
-- *************************


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY gcm_v0_tb IS
END gcm_v0_tb;
 
ARCHITECTURE behavior OF gcm_v0_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT gcm_v0
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         dii_data : IN  std_logic_vector(127 downto 0);
         dii_data_vld : IN  std_logic;
         dii_data_type : IN  std_logic;
         dii_data_not_ready : OUT  std_logic;
         dii_last_word : IN  std_logic;
         dii_data_size : IN  std_logic_vector(3 downto 0);
         cii_ctl_vld : IN  std_logic;
         cii_IV_vld : IN  std_logic;
         cii_K : IN  std_logic_vector(127 downto 0);
         Out_data : OUT  std_logic_vector(127 downto 0);
         Out_vld : OUT  std_logic;
         Out_data_size : OUT  std_logic_vector(3 downto 0);
         Out_last_word : OUT  std_logic;
         Tag_vld : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal dii_data : std_logic_vector(127 downto 0) := (others => '0');
   signal dii_data_vld : std_logic := '0';
   signal dii_data_type : std_logic := '0';
   signal dii_last_word : std_logic := '0';
   signal dii_data_size : std_logic_vector(3 downto 0) := (others => '0');
   signal cii_ctl_vld : std_logic := '0';
   signal cii_IV_vld : std_logic := '0';
   signal cii_K : std_logic_vector(127 downto 0) := (others => '0');

 	--Outputs
   signal dii_data_not_ready : std_logic;
   signal Out_data : std_logic_vector(127 downto 0);
   signal Out_vld : std_logic;
   signal Out_data_size : std_logic_vector(3 downto 0);
   signal Out_last_word : std_logic;
   signal Tag_vld : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: gcm_v0 PORT MAP (
          clk => clk,
          rst => rst,
          dii_data => dii_data,
          dii_data_vld => dii_data_vld,
          dii_data_type => dii_data_type,
          dii_data_not_ready => dii_data_not_ready,
          dii_last_word => dii_last_word,
          dii_data_size => dii_data_size,
          cii_ctl_vld => cii_ctl_vld,
          cii_IV_vld => cii_IV_vld,
          cii_K => cii_K,
          Out_data => Out_data,
          Out_vld => Out_vld,
          Out_data_size => Out_data_size,
          Out_last_word => Out_last_word,
          Tag_vld => Tag_vld
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

			rst <= '0';
         dii_data <= X"FFFF0000FFFF0000FFFF0000FFFF0000";
         dii_data_vld <='1';
         dii_data_type <='1';
         dii_last_word <='1';
         dii_data_size <="1111";
         cii_ctl_vld <='1';
         cii_IV_vld <='1';
         cii_K <= X"FFFF0000FFFF0000FFFF0000FFFF0000";

      wait;
   end process;

END;
