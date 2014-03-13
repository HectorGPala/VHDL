----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:44:10 01/17/2013 
-- Design Name: 
-- Module Name:    RECVR - rtl 
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

entity RECVR is
    Port ( RCX : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  CfgIN : in STD_LOGIC_VECTOR(7 downto 0);
			  DataOUT : out  STD_LOGIC;
			  W : out STD_LOGIC);
end RECVR;

architecture rtl of RECVR is

signal configuracion : STD_LOGIC_VECTOR(7 downto 0);
signal estado : STD_LOGIC_VECTOR(2 downto 0);
signal contador, contadorBits : STD_LOGIC_VECTOR(3 downto 0);

begin

process(Reset,CLK,RCX) begin

if Reset = '1' then
	configuracion <= (others =>'0');
	estado <= "000";
	contador <= "0000";
	contadorBits <= "0000";
elsif rising_edge(CLK) then
	if estado = "000" then --espera bit de start
		contador <= "0001";
		contadorBits <= "0000";
		if RCX = '1' then
			estado <= "000";
		else
			estado <= "001";
		end if;
	elsif estado = "001" then--recepciono bit de start
	   if contador >= "1000" then--medio tiempo de bit
			contador <= "0001";
			estado <= "010";
		else
			contador <= contador + 1;
			estado <= "001";
		end if;
	elsif estado = "010" then
		if contador >= "1111" then
			contador <= "0001";
			if contadorBits < "1000" then
				estado <= "011";
				DataOUT <= RCX;
				W <= '1';
			else
				estado <= "100";
			end if;
		else
			contador <= contador + 1;
			estado <= "010";
		end if;
	elsif estado = "011" then--lee nuevo bit
		contadorBits <= contadorBits + 1;
		W <= '0';
		estado <= "010";
	elsif estado = "100" then
		estado <= "000";
	end if;
end if;
end process;

end rtl;

