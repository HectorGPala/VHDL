--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;

package alu_pkg is

function vector_to_natural ( v : in std_logic_vector ) return natural;
function natural_to_vector ( nat : in natural; long : in natural ) return std_logic_vector;
function vector_to_integer ( v : in std_logic_vector ) return integer;
function integer_to_vector ( int : in integer; long : in natural ) return std_logic_vector;
procedure vector_add ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic );
procedure vector_sub ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic );
procedure vector_addu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic );
procedure vector_subu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic );
procedure vector_multu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic );

end package alu_pkg;

package body alu_pkg is

function vector_to_natural (v: in std_logic_vector) return natural is

variable aux : natural := 0;
begin
for i in v'range loop
if v(i)='1' then
aux := aux + (2**i);
end if;
end loop;
return aux;
end vector_to_natural;

-------------------------------------------------------

function natural_to_vector ( nat : in natural; long : in natural ) return std_logic_vector is

variable v: std_logic_vector(long-1 downto 0):= (others=>'0');
variable aux:natural:= nat;
begin
for i in 0 to long-1 loop
	if (aux = 0) then
		v(i) := '0';
	else
		if aux mod 2 = 1 then
			v(i) := '1';
		else
			v(i) := '0';
		end if;
	end if;
	aux := aux/2;
end loop;
return v;
end natural_to_vector;

-------------------------------------------------------

function vector_to_integer ( v : in std_logic_vector ) return integer is

variable aux : integer := 0;
variable neg: std_logic := v(v'high);
variable vaux: std_logic_vector(v'high downto 0):= v;
begin
if neg = '1' then
	vaux:= not(v-'1');
	neg:='1';
end if;

for i in v'range loop
if vaux(i)='1' then
	aux := aux + (2**i);
end if;
end loop;

if neg='1' then
  aux:=0-aux; 
end if;  
return aux;
end vector_to_integer;

---------------------------------------------------------

function integer_to_vector ( int : in integer; long : in natural ) return std_logic_vector is

variable vectoraux:std_logic_vector(long-1 downto 0):=(others=>'0');
variable c2 : natural;
begin
	if int<0 then 
		c2 := (2**long)+int;
	else  
		c2:= int;
	end if;
	vectoraux:= natural_to_vector(c2,long); 
	return vectoraux;
end integer_to_vector;

------------------------------------------------------------

procedure vector_add ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic ) is

variable suma,long,aux1,aux2: integer;
variable aux:natural:=0;
begin
	long:=v2'length;
	aux1:= vector_to_integer(v1);
	aux2:= vector_to_integer(v2);
	suma := aux1+aux2;
	v_result:=integer_to_vector(suma,long);
	if (suma> (2**(long-1)-1)) or (suma< -(2**(long-1)))  then
			overflow:= '1';
	else
			overflow:= '0';
	end if;
end vector_add;

----------------------------------------------------------

procedure vector_sub ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic ) is

variable resta: integer;
variable long,restaux: natural;
variable aux:natural:=0;
variable vaux:std_logic_vector(v1'range);
begin
long:=v2'length;
resta:= vector_to_integer(v1) - vector_to_integer(v2);
if resta>2**(long-1)-1 or resta<-(2**(long-1)) then
	overflow:= '1';
	if resta>0 then 
		resta:=resta-(2**(long));
	else  
		resta:=resta+(2**(long));
	end if;
else
	overflow:= '0';
end if;
if resta<0 then 
	restaux:=0-resta; 
	v_result:= integer_to_vector(resta,long);
	
else 
	v_result:= integer_to_vector(resta,long);
end if;
end vector_sub;

---------------------------------------------------------

procedure vector_addu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic ) is

variable suma, long: natural;
begin
long := v2'length;
suma := vector_to_natural(v1) + vector_to_natural(v2);
v_result := NATURAL_TO_VECTOR (suma, long);
if (suma >= 2**(v_result'high+1)) then
	overflow := '1';
else
	overflow := '0';
end if;
end vector_addu;

-----------------------------------------------------------

procedure vector_subu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic ) is

variable resta: integer;
variable long: natural;
begin
long:=v2'length;
resta:= vector_to_natural(v1) - vector_to_natural(v2);
if resta<0 then
	resta:= 0;
	v_result :=natural_to_vector(resta,long);
	overflow:= '1';
else
	v_result := natural_to_vector(resta,long);
	overflow:= '0';
end if;
end vector_subu;

--------------------------------------------------------------

procedure vector_multu ( v1, v2 : in std_logic_vector; v_result : out std_logic_vector; overflow : out std_logic ) is

variable multi,long: natural;
begin
long:=v2'length;
multi:= vector_to_natural(v1) * vector_to_natural(v2);
v_result := natural_to_vector(multi,long);
if multi >= 2**(v_result'high+1) then
	overflow:= '1';
else
	overflow:= '0';
end if;
end vector_multu;

end alu_pkg;