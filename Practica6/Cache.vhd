----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:48:12 11/25/2012 
-- Design Name: 
-- Module Name:    Cache - Behavioral 
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

entity Cache is
    Port ( Dir : in  STD_LOGIC_VECTOR (15 downto 0);
           Entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Salida : out  STD_LOGIC_VECTOR (7 downto 0);
			  Acierto : out STD_LOGIC);
end Cache;

architecture Behavioral of Cache is

Type Bloque is array (31 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
Type MP is array (2047 downto 0) of Bloque;
Type MC is array (15 downto 0) of Bloque;
Type etiquetas is array (15 downto 0) of STD_LOGIC_VECTOR(6 downto 0);

signal sucio: STD_LOGIC_VECTOR(15 downto 0);
signal v: STD_LOGIC_VECTOR(15 downto 0);
signal memCache : MC;
signal memP : MP;
signal et : etiquetas;

--descomposicion de direccion
alias etiqueta : STD_LOGIC_VECTOR(6 downto 0) is Dir(15 downto 9);
alias marco : STD_LOGIC_VECTOR(3 downto 0) is Dir(8 downto 5);
alias palabra : STD_LOGIC_VECTOR(4 downto 0) is Dir(4 downto 0);
begin

process(CLK,reset)
begin
--reseteo de cache
	if(reset = '1') then
		v<= "0000000000000000";
		for i in 0 to 2047 loop
			for j in 0 to 31 loop
				memP(i)(j) <= conv_std_logic_vector(j,8);
			end loop;		
		end loop;
	elsif (rising_edge(CLK)) then
		if(RW = '0') then--lectura
			if etiqueta = et(conv_integer(marco)) and v(conv_integer(marco)) = '1' then
				Acierto <= '1';
				Salida <= memCache(conv_integer(marco))(conv_integer(palabra));
			else--fallo de lectura
				Acierto <= '0';
				if sucio(conv_integer(marco)) = '1' then--reemplazo
					memP(conv_integer(et(conv_integer(marco))&marco)) <= memCache(conv_integer(marco));
					sucio(conv_integer(marco)) <= '0';
				end if;
				memCache(conv_integer(marco)) <= memP(conv_integer(etiqueta&marco));
				v(conv_integer(marco)) <= '1';
				sucio(conv_integer(marco)) <= '0';
				et(conv_integer(marco)) <= etiqueta;
			end if;		
		end if;
		if(RW = '1') then--escritura
			if etiqueta = et(conv_integer(marco)) and v(conv_integer(marco)) = '1' then
				memCache(conv_integer(marco))(conv_integer(palabra)) <= entrada;
				sucio(conv_integer(marco)) <= '1';
				Acierto <= '1';
			else--fallo de escritura
				Acierto <= '0';
				if sucio(conv_integer(marco)) = '1' then--reemplazo
					memP(conv_integer(et(conv_integer(marco)))) <= memCache(conv_integer(marco));
					sucio(conv_integer(marco)) <= '0';
				end if;
				memCache(conv_integer(marco)) <= memP(conv_integer(etiqueta));
				memCache(conv_integer(marco))(conv_integer(palabra)) <= entrada;
				v(conv_integer(marco)) <= '1';
				sucio(conv_integer(marco)) <= '0';
				et(conv_integer(marco)) <= etiqueta;			
			end if;		
		end if;
	end if;

end process;


end Behavioral;

