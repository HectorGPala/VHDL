----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:45:28 01/17/2013 
-- Design Name: 
-- Module Name:    TRATR - rtl 
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

entity TRATR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           DataIN : in  STD_LOGIC;
           CfgIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  Lee : out STD_LOGIC;
           TRX : out  STD_LOGIC;
           TBusy : out  STD_LOGIC);
end TRATR;

architecture rtl of TRATR is

signal configuracion : STD_LOGIC_VECTOR(7 downto 0);
signal estado : STD_LOGIC_VECTOR(2 downto 0);
signal contador, contadorBits : STD_LOGIC_VECTOR(3 downto 0);--tiempo de bit

begin

process(CLK,Reset,estado) begin

if Reset = '1' then
	configuracion <= (others =>'0');
	TBusy <= '0';
	estado <= "000";
	contador <= "0000";
	contadorBits <= "0000";
	Lee <= '0';
	TRX <= '1';
elsif rising_edge(CLK) then
	if estado = "000" then--estado de espera
		contador <= "0000";
		contadorBits <= "0000";
		TBusy <= '0';
		TRX <= '1';
		if Enable = '0' then
			 estado <= "000";
		else
			TBusy <= '1';
			contador <= "0000";
			estado <= "001";--vamos a estado bit start
			configuracion <= CfgIN;
		end if;
	elsif estado = "001" then--estado bit de start
		TBusy <= '1';
		TRX <= '0';
		contador <= "0001";
		estado <= "010";--vamos a estado retardo
	elsif estado = "010" then--estado de retardo
		TBusy <= '1';
		if contador = "1110" and contadorBits < "1000" then
			Lee <= '1';--lee un ciclo antes el bit
		else
			Lee <= '0';
		end if;
		if contador >= "1111" then
			contador <= "0001";
			if contadorBits < "1000" then
				estado <= "011";--vamos a estado leer un bit
			else
				contador <= "0000";
				estado <= "100";--vamos a estado bit de stop
			end if;
		else
			contador <= contador +1;
			estado <= "010";--estado leer bit
		end if;
	elsif estado = "011" then--lee siguiente bit
		TBusy <= '1';
		Lee <= '0';
		TRX <= DataIN;
		contadorBits <= contadorBits + 1;
		estado <= "010";--estado de retardo
	elsif estado = "100" then--bit de parada
		TRX <= '1';
		TBusy <= '1';
		if contador >= "1111" then
			contador <= "0000";
			estado <= "000";
		else
			contador <= contador + 1;
			estado <= "100";
		end if;		
	end if;
end if;

end process;

end rtl;