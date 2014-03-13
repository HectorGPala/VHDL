----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:58:59 01/14/2013 
-- Design Name: 
-- Module Name:    RegSIPO - rtl 
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

entity RegSIPO is
    Port ( DIN : in  STD_LOGIC;
           Load : in  STD_LOGIC;
			  Leido : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           LLeno : out  STD_LOGIC);
end RegSIPO;

architecture rtl of RegSIPO is

signal aux : STD_LOGIC_VECTOR(7 downto 0);
signal aux2: STD_LOGIC_VECTOR(7 downto 0);

begin

LLeno <= aux2(7);

process(CLK,Reset,DIN,aux) begin
if Reset = '1' then
	aux <= (others =>'0');
	aux2<= (others =>'0');
elsif rising_edge(CLK) then
	if Load = '1' then
		aux(0) <= DIN;
		aux(7 downto 1) <= aux(6 downto 0);
		aux2(0) <= '1';
		aux2(7 downto 1) <= aux2(6 downto 0);
	elsif Leido = '1' then
		DOUT <= aux;
		aux2<= (others =>'0');
	end if;
end if;
end process;



end rtl;

