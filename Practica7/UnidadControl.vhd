----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:18:47 12/13/2012 
-- Design Name: 
-- Module Name:    UnidadControl - Behavioral 
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

entity UnidadControl is
    Port ( E : in  STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out  STD_LOGIC;
           AluSrc : out  STD_LOGIC;
           MemToReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           AluOP : out  STD_LOGIC_VECTOR (1 downto 0));
end UnidadControl;

architecture Behavioral of UnidadControl is

signal tipoR:STD_LOGIC;
signal lw:STD_LOGIC;
signal sw:STD_LOGIC;
signal beq:STD_LOGIC;

begin

tipoR <= not(E(5)) and not(E(4)) and not(E(3)) and not(E(2)) and not(E(1)) and not(E(0));
lw <= E(5) and not(E(4)) and not(E(3)) and not(E(2)) and E(1) and E(0);
sw <= E(5) and not(E(4)) and E(3) and not(E(2)) and E(1) and E(0);
beq <= not(E(5)) and not(E(4)) and not(E(3)) and E(2) and not(E(1)) and not(E(0));

RegDst <= tipoR;
AluSrc <= lw or sw;
MemToReg <= lw;
RegWrite<= tipoR or lw;
MemRead <= lw;
MemWrite <= sw;
Branch <= beq;
AluOP(1) <= tipoR;
AluOP(0) <= beq;	

end Behavioral;

