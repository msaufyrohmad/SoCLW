--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- soc supertop module
--********************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity soc is
port
	(
	soc_clk	:in std_logic; -- centralized clock for whole soc
	I_din	:in std_logic -- serial data input from adc mcp3202 in spartan 6 board
	
	);
end soc;

architecture Behave of soc is

component mips32 
	port(
		ck: in std_logic
	);
end component;

-- cpu s16 component
--component s16
--port( 
--	I_clk: in STD_LOGIC;
--	I_dataInst : in  STD_LOGIC_VECTOR (15 downto 0); -- to instruction decoder from ram
--	O_we : out  STD_LOGIC;-- to ram write enable
--   O_addr : out  STD_LOGIC_VECTOR (15 downto 0); -- address to read from ram
--   O_data : out  STD_LOGIC_VECTOR (15 downto 0);-- data write to ram
--	I_dataWriteReg:in STD_LOGIC_VECTOR(15 downto 0)
--	);
--end component;

--signal	local_I_dataInst 		: std_logic_vector(15 downto 0); --: in  STD_LOGIC_VECTOR (15 downto 0); -- to instruction decoder from ram
--signal	local_O_we 				: STD_LOGIC;-- to ram write enable
--signal   local_O_addr 			: STD_LOGIC_VECTOR (15 downto 0); -- address to read from ram
--signal   local_O_data_mem 			: STD_LOGIC_VECTOR (15 downto 0);-- data write to ram
--signal	local_I_dataWriteReg	: STD_LOGIC_VECTOR(15 downto 0);

-- // s16 end // --------------

-- present component
component PresentEnc 
	generic (
			w_2: integer := 2;
			w_4: integer := 4;
			w_5: integer := 5;
			w_32: integer := 32;
			w_64: integer := 64;
			w_80: integer := 80
	);
	port(
		plaintext  : in std_logic_vector(w_64 - 1 downto 0);
		key		  : in std_logic_vector(w_80 - 1 downto 0);
		ciphertext : out std_logic_vector(w_64 - 1 downto 0);		
		start, clk, reset : in std_logic;
		ready : out std_logic		
	);
end component;

	signal 	local_plaintext_present			:std_logic_vector(63 downto 0);
	signal	local_key				:std_logic_vector(79 downto 0);
	signal	local_ciphertext		:std_logic_vector(63 downto 0);
	signal	local_start_present	:std_logic;
	signal	local_present_reset				:std_logic;
	signal	local_ready				:std_logic;

-- // present enc // ----------

-- // uart communicator
component uart
port (
        CLK         : in std_logic;                             -- Clock
        RST         : in std_logic;                             -- Reset
        BAUDCE      : in std_logic;                             -- Baudrate generator clock enable
        CS          : in std_logic;                             -- Chip select
        WR          : in std_logic;                             -- Write to UART
        RD          : in std_logic;                             -- Read from UART
        A           : in std_logic_vector(2 downto 0);          -- Register select
        DIN         : in std_logic_vector(7 downto 0);          -- Data bus input
        DOUT        : out std_logic_vector(7 downto 0);         -- Data bus output
        DDIS        : out std_logic;                            -- Driver disable
        INT         : out std_logic;                            -- Interrupt output
        OUT1N       : out std_logic;                            -- Output 1
        OUT2N       : out std_logic;                            -- Output 2
        RCLK        : in std_logic;                             -- Receiver clock (16x baudrate)
        BAUDOUTN    : out std_logic;                            -- Baudrate generator output (16x baudrate)
        RTSN        : out std_logic;                            -- RTS output
        DTRN        : out std_logic;                            -- DTR output
        CTSN        : in std_logic;                             -- CTS input
        DSRN        : in std_logic;                             -- DSR input
        DCDN        : in std_logic;                             -- DCD input
        RIN         : in std_logic;                             -- RI input
        SIN         : in std_logic;                             -- Receiver input
        SOUT        : out std_logic                             -- Transmitter output
    );
end component;

	signal 	local_uart_RST         : std_logic;                             -- Reset
	signal 	local_BAUDCE      : std_logic;                             -- Baudrate generator clock enable
	signal	local_CS          : std_logic;                             -- Chip select
	signal	local_WR          : std_logic;                             -- Write to UART
	signal   local_RD          : std_logic;                             -- Read from UART
	signal   local_A           : std_logic_vector(2 downto 0);          -- Register select
	signal   local_DIN         : std_logic_vector(7 downto 0);          -- Data bus input
   signal   local_DOUT        : std_logic_vector(7 downto 0);         -- Data bus output
   signal   local_DDIS        : std_logic;                            -- Driver disable
   signal   local_INT         : std_logic;                            -- Interrupt output
   signal   local_OUT1N       : std_logic;                            -- Output 1
   signal   local_OUT2N       : std_logic;                            -- Output 2
   signal   local_RCLK        : std_logic;                             -- Receiver clock (16x baudrate)
   signal   local_BAUDOUTN    : std_logic;                            -- Baudrate generator output (16x baudrate)
   signal   local_RTSN        : std_logic;                            -- RTS output
   signal   local_DTRN        : std_logic;                            -- DTR output
   signal   local_CTSN        : std_logic;                             -- CTS input
   signal   local_DSRN        : std_logic;                             -- DSR input
   signal   local_DCDN        : std_logic;                             -- DCD input
   signal   local_RIN         : std_logic;                             -- RI input
   signal   local_SIN         : std_logic;                             -- Receiver input
   signal   local_SOUT        : std_logic;                             -- Transmitter output
    
-- // uart signal ends //--------------------------

-- // end uart // -------------------------
-- randon number generator 
component rng 
port (
       clk:        in  std_logic;
       rst:        in  std_logic;
       reseed:     in  std_logic;
       newkey:     in  std_logic_vector(79 downto 0);
       newiv:      in  std_logic_vector(79 downto 0);
       out_ready:  in  std_logic;
       out_valid:  out std_logic;
       out_data:   out std_logic_vector(64 downto 1)
		 );
end component;

signal local_rng_rst			:std_logic;
signal local_reseed			:std_logic;
signal local_newkey			:std_logic_vector(79 downto 0);
signal local_newiv			:std_logic_vector(79 downto 0);
signal local_out_ready		:std_logic;
signal local_out_valid		:std_logic;
signal local_out_rng		:std_logic_vector(64 downto 1);

---// end signal rng // ------------------


-- // rsa begin ------
component rsa_top 
  port(
    clk       : in  std_logic;
    reset     : in  std_logic;
    valid_in  : in  std_logic;
    start_in  : in  std_logic;
    x         : in  std_logic_vector(15 downto 0);  -- estos 3 son x^y mod m
    y         : in  std_logic_vector(15 downto 0);
    m         : in  std_logic_vector(15 downto 0);
    r_c       : in  std_logic_vector(15 downto 0);  --constante de montgomery r^2 mod m
    s         : out std_logic_vector( 15 downto 0);
    valid_out : out std_logic;
    bit_size  : in  std_logic_vector(15 downto 0)  --tamano bit del exponente y (log2(y))
    );
end component;

-- rsa signal 
    signal local_reset_rsa     : std_logic;
    signal local_valid_in  : std_logic;
    signal local_start_in  : std_logic;
    signal local_x         : std_logic_vector(15 downto 0);  -- estos 3 son x^y mod m
    signal local_y         : std_logic_vector(15 downto 0);
    signal local_m         : std_logic_vector(15 downto 0);
    signal local_r_c       : std_logic_vector(15 downto 0);  --constante de montgomery r^2 mod m
    signal local_s         : std_logic_vector( 15 downto 0);
    signal local_valid_out : std_logic;
    signal local_bit_size  : std_logic_vector(15 downto 0);--tamano bit del exponente y (log2(y))
    
-- // rsa end --------------

--// gcm mode aes (will change to present, will? haha ;) //------------
component gcm_v0 is
port (
	  clk						: in std_logic;
	  rst						: in std_logic;
	  dii_data				:in std_logic_vector(127 downto 0); --     /* DATA Input Interface (dii) */
	  dii_data_vld 			: in std_logic;
	  dii_data_type 			:in std_logic;
	  dii_data_not_ready 	:out std_logic;
	  dii_last_word			: in std_logic;
     dii_data_size 		:in std_logic_vector(3 downto 0);
	  
	  cii_ctl_vld			:in std_logic;  			--  /* Control Input Interface */ --//acts as start signal
	  cii_IV_vld				: in std_logic;
     cii_K					:in std_logic_vector(127 downto 0);
	  
     Out_data 				:out std_logic_vector(127 downto 0); --  /* Data Output Interface */
	  Out_vld					:out std_logic;
     Out_data_size			:out std_logic_vector(3 downto 0);
     Out_last_word			:out std_logic;
     Tag_vld					:out std_logic --	          /* Tag output Interface */
);
end component;

	-- signal for gcm
	signal 	local_rst						:std_logic;
	signal  	local_dii_data					:std_logic_vector(127 downto 0); --     /* DATA Input Interface (dii) */
	signal  	local_dii_data_vld 			:std_logic;
	signal  	local_dii_data_type 			:std_logic;
	signal  	local_dii_data_not_ready 	:std_logic;
	signal  	local_dii_last_word			:std_logic;
   signal  	local_dii_data_size 			:std_logic_vector(3 downto 0);
	  
	signal  	local_cii_ctl_vld				:std_logic;  			--  /* Control Input Interface */ --//acts as start signal
	signal  	local_cii_IV_vld				:std_logic;
   signal  	local_cii_K						:std_logic_vector(127 downto 0);
	  
   signal  	local_Out_data 				:std_logic_vector(127 downto 0); --  /* Data Output Interface */
	signal  	local_Out_vld					:std_logic;
   signal  	local_Out_data_size			:std_logic_vector(3 downto 0);
   signal	local_Out_last_word			:std_logic;
   signal	local_Tag_vld					:std_logic; --	          /* Tag output Interface */-- adc interfacing with spartan 6 start --------------

---// end for gcm area //-----------------------------------------


-- // adc interfacing start // -----------------------------------
component adc 
port ( I_clk   : in std_logic; -- from soc input
       O_cs    : out std_logic; -- local output
		 O_sc  : out std_logic; -- local output
		 O_do    : out std_logic; -- local output
		 I_din   : in std_logic; -- from soc input
		 O_data    : out std_logic_vector(11 downto 0)); -- local output
end component;
	
	-- signal for adc
	signal local_O_cs :std_logic;
	signal local_O_sc :std_logic;
	signal local_O_do :std_logic;
	signal local_O_data :std_logic_vector(11 downto 0);
	
--// adc interfacing ends--//---------------------------------

begin

adc1: adc port map
	(
		I_clk   => soc_clk,
      O_cs=> local_O_cs,
		O_sc => local_O_sc,
		O_do => local_O_do,
		I_din => I_din,
		O_data =>local_O_data
	);
	
gcm1: gcm_v0 port map
	(
		clk	=> soc_clk,
		rst	=>local_rst,
		dii_data => local_dii_data,
		dii_data_vld => local_dii_data_vld,
		dii_data_type => local_dii_data_type,
		dii_data_not_ready => local_dii_data_not_ready,
		dii_last_word => local_dii_last_word,
		dii_data_size => local_dii_data_size,
	  	cii_ctl_vld	=> local_cii_ctl_vld,  			--  /* Control Input Interface */ --//acts as start signal
		cii_IV_vld => local_cii_IV_vld,
		cii_K => local_cii_K,
	   Out_data => local_Out_data, --  /* Data Output Interface */
		Out_vld => local_Out_vld,
		Out_data_size => local_Out_data_size,
		Out_last_word => local_Out_last_word,
		Tag_vld => local_Tag_vld --	          /* Tag output Interface */
	);

rsa1: rsa_top port map
	(
    clk 			=> soc_clk,       
    reset 		=>local_reset_rsa,
    valid_in 	=>local_valid_in,
    start_in 	=>local_start_in,
    x     		=>local_x,
    y     		=>local_y,
    m     		=>local_m,
    r_c      	=>local_r_c,
    s        	=>local_s,
    valid_out 	=>local_valid_out,
    bit_size  	=>local_bit_size
    );

rng1	:rng port map
		(
		clk			=> soc_clk,
      rst			=> local_rng_rst,
      reseed 		=> local_reseed,
      newkey 		=> local_newkey,
      newiv    	=> local_newiv,
      out_ready 	=>local_out_ready,
      out_valid	=> local_out_valid, 
      out_data  	=>local_out_rng
		);

uat1	:uart port map
	(
    CLK=>soc_clk,
    RST =>local_uart_RST,  -- Reset
    BAUDCE=>local_BAUDCE,                             -- Baudrate generator clock enable
    CS =>local_CS,                             -- Chip select
    WR =>local_WR,                             -- Write to UART
    RD  => local_RD,                             -- Read from UART
    A => local_A, --          : in std_logic_vector(2 downto 0);          -- Register select
    DIN =>local_DIN, --        : in std_logic_vector(7 downto 0);          -- Data bus input
    DOUT =>local_DOUT, --       : out std_logic_vector(7 downto 0);         -- Data bus output
    DDIS => local_DDIS, --      : out std_logic;                            -- Driver disable
    INT => local_INT, --        : out std_logic;                            -- Interrupt output
    OUT1N  => local_OUT1N, -- : out std_logic;                            -- Output 1
    OUT2N  => local_OUT2N, --     : out std_logic;                            -- Output 2
    RCLK => local_RCLK, --       : in std_logic;                             -- Receiver clock (16x baudrate)
    BAUDOUTN  => local_BAUDOUTN, --  : out std_logic;                            -- Baudrate generator output (16x baudrate)
    RTSN  => local_RTSN, --      : out std_logic;                            -- RTS output
    DTRN  => local_DTRN, --      : out std_logic;                            -- DTR output
    CTSN  => local_CTSN, --      : in std_logic;                             -- CTS input
    DSRN  => local_DSRN, --      : in std_logic;                             -- DSR input
    DCDN  => local_DCDN, --      : in std_logic;                             -- DCD input
    RIN   => local_RIN,  --    : in std_logic;                             -- RI input
    SIN   => local_SIN, --      : in std_logic;                             -- Receiver input
    SOUT  => local_SIN --      : out std_logic                             -- Transmitter output
    );


mips1 :mips32 port map
	(
		ck	=> soc_clk
	);


--s161	:s16 port map
--	( 
--	I_clk => soc_clk,
--	I_dataInst =>local_I_dataInst, --: in  STD_LOGIC_VECTOR (15 downto 0); -- to instruction decoder from ram
--	O_we =>local_O_we, --: out  STD_LOGIC;-- to ram write enable
--  O_addr =>local_O_addr, --: out  STD_LOGIC_VECTOR (15 downto 0); -- address to read from ram
--   O_data => local_O_data_mem, --: out  STD_LOGIC_VECTOR (15 downto 0);-- data write to ram
--	I_dataWriteReg => local_I_dataWriteReg --:in STD_LOGIC_VECTOR(15 downto 0)
--	);


present1	:presentenc port map
	(
		plaintext	=>local_plaintext_present, --  : in std_logic_vector(w_64 - 1 downto 0);
		key			=>local_key, --		  : in std_logic_vector(w_80 - 1 downto 0);
		ciphertext 	=>local_ciphertext, -- : out std_logic_vector(w_64 - 1 downto 0);		
		start => local_start_present, --
		clk => soc_clk, --
		reset => local_present_reset, -- : in std_logic;
		ready =>local_ready --: out std_logic		
	);




end Behave;




