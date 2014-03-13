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

entity Reg8 is
    Port ( LOAD : in  STD_LOGIC;
           CLKR : in  STD_LOGIC;
           B_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end Reg8;

architecture Behavioral of Reg8 is

begin

reg: process(CLKR, LOAD)
begin

if (rising_edge(CLKR) and LOAD = '1') then

B_OUT <= B_IN;

end if;

end process reg;

end Behavioral;

