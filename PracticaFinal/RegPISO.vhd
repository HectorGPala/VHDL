----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:24:34 01/14/2013 
-- Design Name: 
-- Module Name:    RegPISO - rtl 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegPISO is
    Port ( DIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  Load: in STD_LOGIC;
			  Leido : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DOUT : out  STD_LOGIC;
			  LLeno: out STD_LOGIC);
end RegPISO;

architecture rtl of RegPISO is

signal aux : STD_LOGIC_VECTOR(7 downto 0);
signal aux2 : STD_LOGIC_VECTOR(7 downto 0);

begin

LLeno <= aux2(7);

process(CLK,Reset,DIN) begin

if Reset = '1' then
	aux <= (others =>'0');
	aux2 <= (others =>'0');
elsif rising_edge(CLK) then
	if Load = '1' then
		aux <= DIN;
		aux2 <= (others =>'1');
	elsif Leido = '1' then
		DOUT <= aux(7);
		aux(7 downto 1) <= aux(6 downto 0);
		aux2(0) <= '0';
		aux2(7 downto 1) <= aux2(6 downto 0);--revisar!!
	end if;	
end if;
--DOUT <= aux(7);

end process;

end rtl;

