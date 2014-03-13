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

entity Deco3a8 is
    Port ( Ent : in  STD_LOGIC_VECTOR (2 downto 0);
           Salida : out  STD_LOGIC_VECTOR (7 downto 0);
           Enabled : in  STD_LOGIC);
end Deco3a8;

architecture Behavioral of Deco3a8 is

begin

		Salida <= "00000001" when Ent = "000" and Enabled = '1' else
					 "00000010" when Ent = "001" and Enabled = '1' else
					 "00000100" when Ent = "010" and Enabled = '1' else
					 "00001000" when Ent = "011" and Enabled = '1' else
					 "00010000" when Ent = "100" and Enabled = '1' else
					 "00100000" when Ent = "101" and Enabled = '1' else
					 "01000000" when Ent = "110" and Enabled = '1' else
					 "10000000" when Ent = "111" and Enabled = '1';


end Behavioral;

