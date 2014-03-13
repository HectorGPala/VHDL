----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:45 12/13/2012 
-- Design Name: 
-- Module Name:    MemDatos - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MemDatos is
    Port ( ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           DW : in  STD_LOGIC_VECTOR (31 downto 0);
           DR : out  STD_LOGIC_VECTOR (31 downto 0);
           MemWrite : in  STD_LOGIC;
			  MemRead : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end MemDatos;

architecture Behavioral of MemDatos is

type memoriaD is array (0 to 65534) of STD_LOGIC_VECTOR(31 downto 0);
signal mem : memoriaD := ((x"00000003"),(x"00000004"),(x"00000001"),others=>x"00000000");

begin

process(CLK,ADDR)
begin
if MemRead = '1' and MemWrite = '0' then--lectura
		DR <= mem(conv_integer(ADDR));
		end if;

if rising_edge(CLK) then
	if MemWrite = '1' and MemRead = '0' then--escritura
		mem(conv_integer(ADDR)) <= DW;
	end if;
end if;

end process;

end Behavioral;

