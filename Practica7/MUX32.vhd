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

entity MUX32 is
    Port ( Sel : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,
				D24,D25,D26,D27,D28,D29,D30,D31  : in  STD_LOGIC_VECTOR (31 downto 0));
end MUX32;

 architecture Behavioral of MUX32 is

begin
	Dout <= D0  when Sel = "00000" else
			  D1  when Sel = "00001" else
			  D2  when Sel = "00010" else
			  D3  when Sel = "00011" else
			  D4  when Sel = "00100" else
			  D5  when Sel = "00101" else
			  D6  when Sel = "00110" else
			  D7  when Sel = "00111" else
			  D8  when Sel = "01000" else
			  D9  when Sel = "01001" else
			  D10 when Sel = "01010" else
			  D11 when Sel = "01011" else
			  D12 when Sel = "01100" else
			  D13 when Sel = "01101" else
			  D14 when Sel = "01110" else
			  D15 when Sel = "01111" else
			  D16 when Sel = "10000" else
			  D17 when Sel = "10001" else
			  D18 when Sel = "10010" else
			  D19 when Sel = "10011" else
			  D20 when Sel = "10100" else
			  D21 when Sel = "10101" else
			  D22 when Sel = "10110" else
			  D23 when Sel = "10111" else
			  D24 when Sel = "11000" else
			  D25 when Sel = "11001" else
			  D26 when Sel = "11010" else
			  D27 when Sel = "11011" else
			  D28 when Sel = "11100" else
			  D29 when Sel = "11101" else
			  D30 when Sel = "11110" else
			  D31;

end Behavioral;

