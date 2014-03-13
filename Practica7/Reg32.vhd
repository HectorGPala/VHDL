----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:26 10/15/2012 
-- Design Name: 
-- Module Name:    Reg8 - Behavioral 
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

entity Reg32 is
    Port ( LOAD : in  STD_LOGIC;
           CLKR : in  STD_LOGIC;
			  ResetR: in STD_LOGIC;
           B_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end Reg32;

architecture Behavioral of Reg32 is

--signal a: STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
begin

reg: process(CLKR, LOAD,ResetR)
begin


if(ResetR = '1') then
	B_OUT <= "00000000000000000000000000000000";
elsif (rising_edge(CLKR) and LOAD = '1') then

	B_OUT <= B_IN;
end if;
--B_OUT <= a;

end process reg;

end Behavioral;

