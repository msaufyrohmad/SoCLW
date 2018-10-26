--***************************************
--fifo code from https://electronics.stackexchange.com/questions/13386/
--fifo-implementation-in-vhdl-is-read-function-deleting-the-element-of-the-fifo
--***************************************

library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.STD_LOGIC_ARITH.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

entity fifo_256_feedback is  
port (  	
			clk 	: in std_logic; 
			rst	:in std_logic;
			--enr 	: in std_logic;   --enable read,should be '0' when not in use.  
			wr_en 	: in std_logic;   --enable read,should be '0' when not in use.  
			--enw 	: in std_logic;    --enable write,should be '0' when not in use.  
         rd_en 	: in std_logic;    --enable write,should be '0' when not in use.  
         --dataout : out std_logic_vector(7 downto 0);    --output data  
			dout : out std_logic_vector(48 downto 0);    --output data
			--datain : in std_logic_vector (7 downto 0);     --input data  
			din : in std_logic_vector (48 downto 0);     --input data  
			empty : out std_logic;     --set as '1' when the queue is empty  
			full : out std_logic     --set as '1' when the queue is full  
     );  
end fifo_256_feedback;  

architecture Behavioral of fifo_256_feedback is  
type memory_type is array (0 to 65536) of std_logic_vector(48 downto 0);  --32 bit cukup
signal memory : memory_type :=(others => (others => '0')); --memory for queue.  
signal readptr,writeptr : std_logic_vector(15 downto 0) :="0000000000000000"; --read/write pointers.
signal error : std_logic;  
begin  
  process(clk,rst)  
  begin   
    if(clk'event and clk='1' and rd_en = '1') then  
      --dataout <= memory(conv_integer(readptr));  
      dout <= memory(conv_integer(readptr));  
      error <= '0';  
      readptr <= readptr + '1';      --points to next address.  
    end if;  
    if(clk'event and clk='1' and wr_en ='1') then  
      --memory(conv_integer(writeptr)) <= datain;  
      memory(conv_integer(writeptr)) <= din;  
      writeptr <= writeptr + '1';   --points to next address.  
    end if;  
    if(readptr = "1111111111111111") then      --resetting read pointer.  
      readptr <= "0000000000000000";  
    end if;  
    if(writeptr = "1111111111111111") then        --checking whether queue is full or not
      full <='1';  
      writeptr <= "0000000000000000";  
    else  
      full <='0';  
    end if;  
    if(writeptr = "0000000000000000") then   --checking whether queue is empty or not  
      empty <='1';  
    else  
      empty <='0';  
    end if;  
  end process;  
end Behavioral; 