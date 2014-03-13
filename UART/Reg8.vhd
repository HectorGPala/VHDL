----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:51 01/15/2013 
-- Design Name: 
-- Module Name:    Reg8 - rtl 
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
    Port ( DataIN : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Load : in  STD_LOGIC);
end Reg8;

architecture rtl of Reg8 is

begin

process(CLK,Load,Reset) begin

if(Reset = '1') then
	DataOUT <= "00000000";
elsif (rising_edge(CLK) and Load = '1') then
	DataOUT <= DataIn;
end if;

end process;

end rtl;

