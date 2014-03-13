----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:28:02 10/15/2012 
-- Design Name: 
-- Module Name:    BancoReg - Behavioral 
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

entity BancoReg is
    Port ( CLK : in  STD_LOGIC;
           W : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Aread : in  STD_LOGIC_VECTOR (2 downto 0);
           Awrite : in  STD_LOGIC_VECTOR (2 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0));
end BancoReg;

architecture Behavioral of BancoReg is

component  Reg8 is
    Port ( LOAD : in  STD_LOGIC;
           CLKR : in  STD_LOGIC;
           B_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component Deco3a8 is
    Port ( Ent : in  STD_LOGIC_VECTOR (2 downto 0);
           Salida : out  STD_LOGIC_VECTOR (7 downto 0);
           Enabled : in  STD_LOGIC);
end component;

component MUX8 is
    Port ( Sel : in  STD_LOGIC_VECTOR (2 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0);
           D0,D1,D2,D3,D4,D5,D6,D7 : in  STD_LOGIC_VECTOR (7 downto 0));
end component;

signal SalDec,Aux : STD_LOGIC_VECTOR (7 downto 0);
type SalReg is array (7 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal SalR : SalReg;

begin

mod_Dec: Deco3a8 port map (Awrite,SalDec,W);

gen: for i in 0 to 7 generate
	u: Reg8 port map (SalDec(i),CLK,Din,SalR(i));
end generate gen;


mod_Mux : MUX8 port map (Aread,Aux,SalR(0),SalR(1),SalR(2),SalR(3),SalR(4),SalR(5),SalR(6),SalR(7));
Dout <= Aux;



end Behavioral;

