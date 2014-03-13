----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:44:36 01/15/2013 
-- Design Name: 
-- Module Name:    ITFCPU - Behavioral 
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

entity ITFCPU is
    Port ( CS : in  STD_LOGIC;
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIN : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           DataREG_OUT : out  STD_LOGIC_VECTOR (7 downto 0);--salida a los registros de Datos y Configuracion
			  DataREG_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  TBusy : in STD_LOGIC;
			  DAVLB : in STD_LOGIC;
			  DOVRW : in STD_LOGIC;
			  LeidoDOUT : out STD_LOGIC;
			  LoadDOUT : out  STD_LOGIC;
           LoadCFG : out  STD_LOGIC);
end ITFCPU;

architecture rtl of ITFCPU is

signal estado: STD_LOGIC_VECTOR(7 downto 0);
--signal sel: STD_LOGIC;

begin
--estado <= (others =>'0');
estado(0) <= TBusy;
estado(1) <= '0';
estado(2) <= '0';
estado(3) <= DAVLB;
estado(4) <= '0';
estado(5) <= '0';
estado(6) <= '0';
estado(7) <= DOVRW;
DataREG_OUT <= DataIN;

process(CS,OP,estado) begin

if CS = '1' then
	if OP = "00" then--lee de DINREG
		DataOUT <= DataREG_IN;
		LeidoDOUT <= '1';
		LoadDOUT <= '0';
		LoadCFG <= '0';
	elsif OP = "10" then--consulta estado UART
		DataOUT <= estado;
		LeidoDOUT <= '0';
		LoadDOUT <= '0';
		LoadCFG <= '0';
	elsif OP = "01" then--escribe dato a enviar
		LeidoDOUT <= '0';
		LoadDOUT <= '1';
		LoadCFG <= '0';
		--DataOUT <= estado;
	elsif OP = "11" then--escribe valor de configuracion
		LoadCFG <= '1';
		LoadDOUT <= '0';
		LeidoDOUT <= '0';
		--DataOUT <= estado;
	end if;
else
	LoadDOUT <= '0';
	LoadCFG <= '0';
	LeidoDOUT <= '0';
	DataOUT <= "00000000";
end if;



end process;

end rtl;

