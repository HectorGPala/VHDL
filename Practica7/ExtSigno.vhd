----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:54:45 12/10/2012 
-- Design Name: 
-- Module Name:    ExtSigno - Behavioral 
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

entity ExtSigno is
    Port ( B_In : in  STD_LOGIC_VECTOR (15 downto 0);
           B_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end ExtSigno;

architecture Behavioral of ExtSigno is

begin


B_Out <= (31 downto 16 => B_In(15)) & B_In(15 downto 0);

end Behavioral;

