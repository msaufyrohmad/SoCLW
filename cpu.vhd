--********************************************
-- Muhammad Saufy Rohmad
-- EE UiTM Shah Alam
-- System on Chip for Lightweight Cryptography
-- saufy@salam.uitm.edu.my
-- cpu top module
--********************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity s16 is
port( 
	I_clk: in STD_LOGIC;
	I_dataInst : in  STD_LOGIC_VECTOR (15 downto 0); -- to instruction decoder from ram
	O_we : out  STD_LOGIC;-- to ram write enable
   O_addr : out  STD_LOGIC_VECTOR (15 downto 0); -- address to read from ram
   O_data : out  STD_LOGIC_VECTOR (15 downto 0);-- data write to ram
	I_dataWriteReg:in STD_LOGIC_VECTOR(15 downto 0)
	);
end s16;

architecture Behavioral of s16 is
----  begin component instiation ----
component instmem 
port
	(
	 I_clk : in  STD_LOGIC;
    I_we_i : in  STD_LOGIC;
    I_addr_i : in  STD_LOGIC_VECTOR (15 downto 0);
    I_data_i : in  STD_LOGIC_VECTOR (35 downto 0);
    O_data_i : out  STD_LOGIC_VECTOR (35 downto 0)
	);
end component;

component datamem 
port
	(
	 I_clk : in  STD_LOGIC;
    I_we_d : in  STD_LOGIC;
    I_addr_d : in  STD_LOGIC_VECTOR (15 downto 0);
    I_data_d : in  STD_LOGIC_VECTOR (15 downto 0);
    O_data_d : out  STD_LOGIC_VECTOR (15 downto 0)
	);
end component;

component reg16_8 
port ( 
		I_clk : in  STD_LOGIC;
       I_reg_en : in  STD_LOGIC;
       I_reg_we : in  STD_LOGIC;
		 I_dataWrite : in  STD_LOGIC_VECTOR (15 downto 0);
       O_dataRead : out  STD_LOGIC_VECTOR (15 downto 0);
       I_selRead : in  STD_LOGIC_VECTOR (2 downto 0);
		 I_selWrite: in STD_LOGIC_VECTOR(2 downto 0)
		);
end component;

component alu 
port (
		I_clk: in STD_LOGIC;
		I_alu_en :  in  STD_LOGIC;
		I_aluop :   in STD_LOGIC_VECTOR (4 downto 0)		
		);
end component;

component instdecoder 
port ( 
		I_clk: in STD_LOGIC;
      I_decoder_en : in  STD_LOGIC;
		I_dataInst : in  STD_LOGIC_VECTOR (15 downto 0);
		O_addr	: out STD_LOGIC_VECTOR(15 downto 0)
      );
end component;

component pc
port
(
	I_clk	:in	std_logic;
	I_reset : in std_logic;
	I_jump:in	std_logic_vector(15 downto 0);
	O_pc_addr:out std_logic_vector(15 downto 0)
);
end component;

component controlunit 
port
(
	I_clk	:in	std_logic;
	I_reset: in std_logic
);
end component;


--- end component instition ---

		-- reg16_8 signal
		signal	I_reg_we: STD_LOGIC;
		signal 	I_reg_en :  STD_LOGIC:='1';
      signal 	I_dataWrite : STD_LOGIC_VECTOR (15 downto 0);
      signal 	O_dataRead : STD_LOGIC_VECTOR (15 downto 0);
      signal 	I_selRead : STD_LOGIC_VECTOR (2 downto 0);
		signal 	I_selWrite : STD_LOGIC_VECTOR (2 downto 0);
		
		-- alu signal		
		signal 	I_alu_en :  STD_LOGIC:='1';
		signal 	I_dataA :   STD_LOGIC_VECTOR (15 downto 0);
		signal 	I_dataB :   STD_LOGIC_VECTOR (15 downto 0);
		signal 	I_dataDwe : STD_LOGIC;
		signal 	I_aluop :   STD_LOGIC_VECTOR (4 downto 0);
		signal 	I_PC :      STD_LOGIC_VECTOR (15 downto 0);
		signal 	I_dataIMM : STD_LOGIC_VECTOR (15 downto 0);
		signal 	O_dataResult :   STD_LOGIC_VECTOR (15 downto 0);
		signal 	O_dataWriteReg : STD_LOGIC;
		signal 	O_shouldBranch : std_logic;
		
		--inst decoder signal
		signal 	I_decoder_en :  STD_LOGIC:='1';
      signal    O_selA : STD_LOGIC_VECTOR (2 downto 0);
      signal    O_selB : STD_LOGIC_VECTOR (2 downto 0);
      signal    O_selD : STD_LOGIC_VECTOR (2 downto 0);
      signal    O_regDwe : STD_LOGIC;
      signal    O_aluop : STD_LOGIC_VECTOR (4 downto 0);
		signal 	O_mem_read: STD_LOGIC;

		-- pc signal
		signal I_reset 	:  std_logic;
		signal I_jump	:	std_logic_vector(15 downto 0);
		signal O_pc_addr: std_logic_vector(15 downto 0);

		-- inst mem signal
		signal I_we_i		:std_logic;
		signal I_addr_i	: std_logic_vector(15 downto 0);
		signal I_data_i	:std_logic_vector(35 downto 0);
		signal O_data_i	:std_logic_vector(35 downto 0); 

		-- data mem signal
		signal I_we_d		:std_logic;
		signal I_addr_d	:std_logic_vector(15 downto 0); 
		signal I_data_d	:std_logic_vector(15 downto 0);
		signal O_data_d	:std_logic_vector(15 downto 0);

begin
-- component definition
reg1				:reg16_8 port map(
									I_clk=>I_clk,
									I_reg_en=>I_reg_en,
									I_reg_we=>I_reg_we,
									I_dataWrite=>I_dataWrite,
									O_dataRead=>O_dataRead,
									I_selRead=>I_selRead,
									I_selWrite=>I_selWrite
									);
									
instdecoder1	:instdecoder port map(
									I_clk=>I_clk,
									I_decoder_en=>I_decoder_en,
									I_dataInst=>I_dataInst,
									O_addr=>O_addr
									);
									
alu1				:alu port map(
									I_clk=>I_clk,
									I_alu_en=>I_alu_en,
									I_aluop=>I_aluop
									);
									
pc1				:pc port map(
									I_clk=>I_clk,
									I_reset=>I_reset,
									I_jump=>I_jump,
									O_pc_addr=>O_pc_addr
									);
									
controlunit1	:controlunit port map(
									I_clk=>I_clk,
									I_reset=>I_reset
									);
									
inst1mem			:instmem port map( 
									I_clk=>I_clk,
									I_we_i=>I_we_i,
									I_addr_i=>I_addr_i,
									I_data_i =>I_data_i,
									O_data_i => O_data_i
									);

datamem1			:datamem port map(
									I_clk=>I_clk,
									I_we_d=>I_we_d,
									I_addr_d => I_addr_d,
									I_data_d=>I_data_d,
									O_data_d=>O_data_d
									);



end Behavioral;

