----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:11:37 10/15/2012 
-- Design Name: 
-- Module Name:    MUX8 - Behavioral 
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

entity MUX8 is
    Port ( Sel : in  STD_LOGIC_VECTOR (2 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           D0,D1,D2,D3,D4,D5,D6,D7 : in  STD_LOGIC_VECTOR (7 downto 0));
end MUX8;

architecture Behavioral of MUX8 is

begin
	Dout <= D0 when Sel = "000" else
			  D1 when Sel = "001" else
			  D2 when Sel = "010" else
			  D3 when Sel = "011" else
			  D4 when Sel = "100" else
			  D5 when Sel = "101" else
			  D6 when Sel = "110" else
			  D7;

end Behavioral;

