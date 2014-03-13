----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:28 10/29/2012 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
USE work.alu_pkg.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( CO : in  STD_LOGIC_VECTOR (2 downto 0);
           op1 : in  STD_LOGIC_VECTOR(31 downto 0);
           op2 : in  STD_LOGIC_VECTOR(31 downto 0);
           v_result : out  STD_LOGIC_VECTOR(31 downto 0);
           overflow : out  std_logic;
			  Zero : out std_logic);
end ALU;

architecture Behavioral of ALU is

begin

p1: process(CO,op1,op2)
variable resultado: std_logic_vector (op1'high downto 0);
variable desbordamiento: std_logic;
variable z : std_logic;

begin
	case CO is
		when "000" => vector_and(op1,op2,resultado);
		when "001" => vector_or(op1,op2,resultado);
		when "010" => vector_add(op1,op2,resultado,desbordamiento,z);
		when "011" => vector_mult(op1,op2,resultado,desbordamiento,z);
		when "110" => vector_sub(op1,op2,resultado,desbordamiento,z);
		when "111" => vector_sft(op1,resultado);
		when others => null;
	end case;
	v_result <= resultado;
	overflow <= desbordamiento;
	Zero <= z;

end process p1;

end Behavioral;

