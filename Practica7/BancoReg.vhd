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
			  RESET : in STD_LOGIC;
		     RegWr: in STD_LOGIC;
           busW : in  STD_LOGIC_VECTOR (31 downto 0);
           RA : in  STD_LOGIC_VECTOR (4 downto 0);
		     RB : in  STD_LOGIC_VECTOR (4 downto 0);
           RW : in  STD_LOGIC_VECTOR (4 downto 0);
           busA : out  STD_LOGIC_VECTOR (31 downto 0);
		     busB : out  STD_LOGIC_VECTOR (31 downto 0));
end BancoReg;

architecture Behavioral of BancoReg is

component  Reg32 is
    Port ( LOAD : in  STD_LOGIC;
           CLKR : in  STD_LOGIC;
		     ResetR: in STD_LOGIC;
           B_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Deco5a32 is
    Port ( Ent : in  STD_LOGIC_VECTOR (4 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0)
          );
end component;

component MUX32 is
    Port ( Sel : in  STD_LOGIC_VECTOR (4 downto 0);
           Dout : out  STD_LOGIC_VECTOR (31 downto 0);
           D0,D1,D2,D3,D4,D5,D6,D7,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,D18,D19,D20,D21,D22,D23,
				D24,D25,D26,D27,D28,D29,D30,D31  : in  STD_LOGIC_VECTOR (31 downto 0));   
end component;

signal SalDec, entradas : STD_LOGIC_VECTOR (31 downto 0);
type SalReg is array (31 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal SalR : SalReg;

begin

mod_Dec: Deco5a32 port map (RW,SalDec);

gen: for i in 0 to 31 generate
	entradas(i) <= (SalDec(i) and RegWr);
	u: Reg32 port map (entradas(i),CLK,RESET,busW,SalR(i));
end generate gen;

mod_MuxA : MUX32 port map (RA,busA,SalR(0),SalR(1),SalR(2),SalR(3),SalR(4),SalR(5),SalR(6),SalR(7),
SalR(8),SalR(9),SalR(10),SalR(11),SalR(12),SalR(13),SalR(14),SalR(15),SalR(16),SalR(17),SalR(18),
SalR(19),SalR(20),SalR(21),SalR(22),SalR(23),SalR(24),SalR(25),SalR(26),SalR(27),SalR(28),
SalR(29),SalR(30),SalR(31));

mod_MUXB : MUX32 port map (RB,busB,SalR(0),SalR(1),SalR(2),SalR(3),SalR(4),SalR(5),SalR(6),SalR(7),
SalR(8),SalR(9),SalR(10),SalR(11),SalR(12),SalR(13),SalR(14),SalR(15),SalR(16),SalR(17),SalR(18),
SalR(19),SalR(20),SalR(21),SalR(22),SalR(23),SalR(24),SalR(25),SalR(26),SalR(27),SalR(28),
SalR(29),SalR(30),SalR(31));

end Behavioral;

