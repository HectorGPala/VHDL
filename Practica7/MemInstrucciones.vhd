----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:02:10 12/13/2012 
-- Design Name: 
-- Module Name:    MemInstrucciones - Behavioral 
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

entity MemInstrucciones is
    Port ( ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           DR : out  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC);
end MemInstrucciones;

architecture Behavioral of MemInstrucciones is


type memoriaI is array (0 to 65534) of STD_LOGIC_VECTOR(31 downto 0);
signal mem : memoriaI;

begin

mem <= (
"10001100000000010000000000000000", ---Load en R1 M(0) "a" primera
"10001100000000100000000000000001", ---Load en R2 M(1) "b" segunda
"10001100000000110000000000000010", --- Load en R3 M(2) "1" tercera
"10001100000001000000000000000010", ---Load en R4 M(0) "a" primera
"00010000000000100000000000000011", ---beq R2 R0 a linea 9 quinta
"00000000010000110001000000100010", ---sub R2 R3 -> R2 sexta
"00000000001001000010000000111111", --- mult R1 R4 -> R4 septima
"00010000001000011111111111111100", --- salto a la instruccion 4 octava
"10101100000001000000000000000100", --- store en M(4) R4 novena
others=> "00000000000000000000000000000000");


s: process(ADDR)
begin

	DR <= mem(conv_integer(ADDR));

end process s;

end Behavioral;

