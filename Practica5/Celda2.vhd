----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:58:28 11/05/2012 
-- Design Name: 
-- Module Name:    Celda2 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Celda2 is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           c : out  STD_LOGIC;
           s : out  STD_LOGIC);
end Celda2;

architecture Behavioral of Celda2 is

begin

s<= ((not x)and(not y)and (z)) or ((not x)and(y)and(not z)) or (x and (not y) and (not z)) or (x and y and z);
c<= (z and y) or (z and (not x)) or (y and (not x));

end Behavioral;

