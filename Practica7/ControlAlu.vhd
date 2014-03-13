----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:52:15 12/13/2012 
-- Design Name: 
-- Module Name:    ControlAlu - Behavioral 
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

entity ControlAlu is
    Port ( AluOP : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (5 downto 0);
           AluCrtl : out  STD_LOGIC_VECTOR (2 downto 0));
end ControlAlu;

architecture Behavioral of ControlAlu is

begin

AluCrtl <= "000" when AluOP = "10" and Funct = "100100" else
				"001" when AluOP = "10" and Funct = "100101" else
				"010" when AluOP = "10" and Funct = "100000" else
				"010" when AluOP = "00" else
				"011" when AluOP = "10" and Funct = "111111" else
				"110" when AluOP = "10" and Funct = "100010" else				
				"110" when AluOP = "01" else				
				"111" when AluOP = "10" and Funct = "101010";
				

end Behavioral;

