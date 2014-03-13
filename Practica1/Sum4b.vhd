----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:50:32 10/08/2012 
-- Design Name: 
-- Module Name:    Sum4b - Behavioral 
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

entity Sum4b is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  STD_LOGIC);
end Sum4b;

architecture Behavioral of Sum4b is

begin
	p1: process(a, b, cin)
	variable vsum : std_logic_vector(3 downto 0);
	variable carry : std_logic;
	begin
	carry := cin;
	for i in 0 to 3 loop
	vsum(i) := (a(i) xor b(i)) xor carry;
	carry := (a(i) and b(i)) or (carry and (a(i) or b(i)));
	end loop;
	sum <= vsum;
	cout <= carry;
	end process p1;

end Behavioral;

