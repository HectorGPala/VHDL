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
signal estado : STD_LOGIC_VECTOR(1 downto 0);
signal contador : STD_LOGIC_VECTOR(3 downto 0);

begin

process(CLK,Reset,Enable) begin

if Reset = '1' then
	configuracion <= (others =>'0');
	TBusy <= '0';
	estado <= "00";
	contador <= "0000";
	TRX <= '1';
elsif rising_edge(CLK) then
	if Enable = '1' then
		TBusy <= '1';
		if estado = "00" then--carga configuracion
			configuracion <= CfgIN;
			TRX <= '1';
			estado <= estado+1;
		elsif estado = "01" then--bit de start
			TRX <= '0';
			contador <= contador+1;
			if(contador = "1111") then
				estado <= estado+1;
				contador <= contador+1;
			end if;
		elsif estado = "10" then--transmision de los datos
			if contador = "0000" then
				Lee <= '1';
			else
				Lee <= '0';
			end if;
			TRX <= DataIN;
			contador <= contador+1;
			if(contador = "1111") then
				estado <= estado+1;
				contador <= contador+1;
			end if;
		elsif estado = "11" then
			TRX <= '1';--bit de fin
			contador <= contador+1;
			if(contador = "1111") then
				estado <= estado+1;
				contador <= contador+1;
			end if;
		end if;
	elsif Enable = '0' then
		estado <= "00";
		TBusy <= '0';
		TRX <= '1';
	end if;
end if;

end process;

end rtl;