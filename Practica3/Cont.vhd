----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:37:18 10/22/2012 
-- Design Name: 
-- Module Name:    Cont - Behavioral 
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

entity Cont is
    Port ( reset : in  STD_LOGIC;
           cuenta : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Sal : out  STD_LOGIC_vector(4 downto 0));
end Cont;

architecture Behavioral of Cont is

begin

c: process (Clk,reset)
	variable cnt: STD_LOGIC_VECTOR (4 downto 0);
   begin 
	
	if (reset='1') then
			cnt := "00000"; 
	elsif (clk'event and clk='1' and cuenta='1') then
			if (cnt="11111") then
				cnt:="00000";
			else 
				cnt:= cnt + 1;
			end if;
	end if;

	Sal<=cnt;
   end process c;



end Behavioral;

