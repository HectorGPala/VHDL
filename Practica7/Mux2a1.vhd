----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:07:03 12/10/2012 
-- Design Name: 
-- Module Name:    Mux2a1 - Behavioral 
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

entity Mux2a1 is
	generic (n: integer := 32);
    Port ( D_In0 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           D_In1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Sel : in  STD_LOGIC;
           D_Out : out  STD_LOGIC_VECTOR (n-1 downto 0));
end Mux2a1;

architecture Behavioral of Mux2a1 is
begin

D_Out <= D_In0 when Sel = '0' else
			D_In1 when Sel = '1';


end Behavioral;

