----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:16 11/05/2012 
-- Design Name: 
-- Module Name:    Pezaris - Behavioral 
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

entity Pezaris is
	 Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           p : out  STD_LOGIC_VECTOR (15 downto 0));
end Pezaris;

architecture Behavioral of Pezaris is

component Celda0 is
          Port ( x : in  STD_LOGIC;
					  y : in  STD_LOGIC;
					  z : in  STD_LOGIC;
                 c : out  STD_LOGIC;
                 s : out  STD_LOGIC);
end component;

component Celda2 is
          Port ( x : in  STD_LOGIC;
					  y : in  STD_LOGIC;
					  z : in  STD_LOGIC;
                 c : out  STD_LOGIC;
                 s : out  STD_LOGIC);
end component;

type Matriz is array (6 downto 0, 17 downto 0) of bit;
signal VectorE1 : STD_LOGIC_VECTOR (20 downto 0);
signal VectorE2 : STD_LOGIC_VECTOR (20 downto 0);
signal MatrizG : Matriz :=(others =>'0');

begin
--celdas 0
genc0to6: for j in 0 to 6 generate			
			genc0to5: for i in 0 to 5 generate
					
					caso1: if (j /= 6) generate
					caso11: if (i = 0) generate
						c0: Celda0 port map (MatrizG(j,i*3),MatrizG(j,i*3+1),MatrizG(j,i*3+2),MatrizG(j+1,i+1),MatrizG(j+1,3));
					elsif (i = 5) generate
						c0: Celda0 port map (MatrizG(j,i*3),MatrizG(j,i*3+1),MatrizG(j,i*3+2),MatrizG(j+1,i*3+1),p(j+1));
					else generate--caso normal
						c0: Celda0 port map (MatrizG(j,i*3),MatrizG(j,i*3+1),MatrizG(j,i*3+2),MatrizG(j+1,i*3+1),MatrizG(j+1,i*3+2));
					end generate caso11;
					end generate caso1;
					
					caso2: if (j = 6) generate--salidas al vector
					caso22: if(i = 0) generate
						c0: Celda0 port map (MatrizG(j,i*3),MatrizG(j,i*3+1),MatrizG(j,i*3+2),VectorE1(i),VectorE1(i+3));
					else generate--caso normal
						c0: Celda0 port map (MatrizG(j,i*3),MatrizG(j,i*3+1),MatrizG(j,i*3+2),MatrizG(j,(i-1)*3+2),VectorE1((i+1)*3));
					end generate caso22;
					end generate caso2;
					
			end generate genc0to5;
		 end generate genc0to6;

--celdas 2
c2_1:	for i in 0 to 6 generate
		caso1:  if (i = 6) generate
			c2: Celda2 port map (VectorE1(i*3),VectorE1(i*3+1),VectorE1(i*3+2),VectorE2(i+3+1),p(i+1));
		else generate
			c2: Celda2 port map (VectorE1(i*3),VectorE1(i*3+1),VectorE1(i*3+2),VectorE2(i+3+1),VectorE2((i+1)*3));
		end generate caso1;
	   end generate c2_1;

c2_2:	for i in 0 to 6 generate
			caso1: if (i = 0) generate
				c2: Celda2 port map (VectorE2(i*3),VectorE2(i*3+1),VectorE2(i*3+2),p(15),p(14));
			else generate
				c2: Celda2 port map (VectorE2(i*3),VectorE2(i*3+1),VectorE2(i*3+2),VectorE2((i-1)*3+2),p(14-i));
			end generate caso1;
	   end generate c2_2;

inicio: process(a,b)
--variable i: integer := 0;
--variable j: integer := 0;
begin
for i in 0 to 6 loop
	for j in 0 to 5 loop
		if i = 0 then
			MatrizG(i,j*3)<= a(a'high-1-j) and b(i);
			MatrizG(i,j*3+1)<= a(a'high-2-j) and b(i+1);
			MatrizG(i,j*3+2)<= '0';
		elsif j = 0 then
			MatrizG(i,j*3)<= a(a'high-1-j) and b(i);
		else
			MatrizG(i,j*3+2)<= a(a'high-2-j) and b(i+1);
		end if;--comprobar extremos
	
	end loop;
end loop;




end process inicio;

end Behavioral;

