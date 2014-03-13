----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:12:49 01/17/2013 
-- Design Name: 
-- Module Name:    DosUART - rtl 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DosUART is
    Port ( CLK : in  STD_LOGIC;
			  CS_1 : in  STD_LOGIC;
           OP_1 : in  STD_LOGIC_VECTOR(1 downto 0);
           DataIN_1 : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT_1 : out  STD_LOGIC_VECTOR (7 downto 0);
           TRX_1 : out  STD_LOGIC;
			  CS_2 : in  STD_LOGIC;
           OP_2 : in  STD_LOGIC_VECTOR(1 downto 0);
           DataIN_2 : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT_2 : out  STD_LOGIC_VECTOR (7 downto 0);
           TRX_2 : out  STD_LOGIC;
           ResetSYS : in  STD_LOGIC);
end DosUART;

architecture rtl of DosUART is

component UART is
    Port ( CS_UART : in  STD_LOGIC;
           OP_UART : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIN_UART : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT_UART : out  STD_LOGIC_VECTOR (7 downto 0);
           CLKSYS : in  STD_LOGIC;
           ResetSYS : in  STD_LOGIC;
           TRX_UART : out  STD_LOGIC;
           RCX_UART : in  STD_LOGIC);
end component UART;

signal trx,trx2 : STD_LOGIC;

begin

UART1 : UART port map(CS_1,OP_1,DataIN_1,DataOUT_1,CLK,ResetSYS,trx,trx2);
UART2 : UART port map(CS_2,OP_2,DataIN_2,DataOUT_2,CLK,ResetSYS,trx2,trx);

TRX_1 <= trx;
TRX_2 <= trx2;

end rtl;

