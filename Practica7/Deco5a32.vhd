----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:09 10/15/2012 
-- Design Name: 
-- Module Name:    Deco3a8 - Behavioral 
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

entity Deco5a32 is
    Port ( Ent : in  STD_LOGIC_VECTOR (4 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Deco5a32;

architecture Behavioral of Deco5a32 is

begin

		Salida <= "00000000000000000000000000000001" when Ent = "00000"  else
					 "00000000000000000000000000000010" when Ent = "00001"  else
					 "00000000000000000000000000000100" when Ent = "00010"  else
					 "00000000000000000000000000001000" when Ent = "00011"  else
					 "00000000000000000000000000010000" when Ent = "00100"  else
					 "00000000000000000000000000100000" when Ent = "00101"  else
					 "00000000000000000000000001000000" when Ent = "00110"  else
					 "00000000000000000000000010000000" when Ent = "00111"  else
					 "00000000000000000000000100000000" when Ent = "01000"  else
					 "00000000000000000000001000000000" when Ent = "01001"  else
					 "00000000000000000000010000000000" when Ent = "01010"  else
					 "00000000000000000000100000000000" when Ent = "01011"  else
					 "00000000000000000001000000000000" when Ent = "01100"  else
					 "00000000000000000010000000000000" when Ent = "01101"  else
					 "00000000000000000100000000000000" when Ent = "01110"  else
					 "00000000000000001000000000000000" when Ent = "01111"  else
					 "00000000000000010000000000000000" when Ent = "10000"  else
					 "00000000000000100000000000000000" when Ent = "10001"  else
					 "00000000000001000000000000000000" when Ent = "10010"  else
					 "00000000000010000000000000000000" when Ent = "10011"  else
					 "00000000000100000000000000000000" when Ent = "10100"  else
					 "00000000001000000000000000000000" when Ent = "10101"  else
					 "00000000010000000000000000000000" when Ent = "10110"  else
					 "00000000100000000000000000000000" when Ent = "10111"  else
					 "00000001000000000000000000000000" when Ent = "11000"  else
					 "00000010000000000000000000000000" when Ent = "11001"  else
					 "00000100000000000000000000000000" when Ent = "11010"  else
					 "00001000000000000000000000000000" when Ent = "11011"  else
					 "00010000000000000000000000000000" when Ent = "11100"  else
					 "00100000000000000000000000000000" when Ent = "11101"  else
					 "01000000000000000000000000000000" when Ent = "11110"  else
					 "10000000000000000000000000000000" when Ent = "11111" ;


end Behavioral;

