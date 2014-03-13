----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:55:11 10/22/2012 
-- Design Name: 
-- Module Name:    CruceSem - Behavioral 
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

entity CruceSem is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  semaforoPrincipal : out  STD_LOGIC_vector(2 downto 0);
           semaforoCruce : out  STD_LOGIC_vector(2 downto 0);
           sensor : in  STD_LOGIC);
end CruceSem;

architecture Behavioral of CruceSem is

type ESTADOS is (VR, AR, RV, RA);
signal ESTADO, SIG_ESTADO: ESTADOS;
signal Sal: STD_LOGIC_vector(4 downto 0);
signal cuenta :STD_LOGIC;

component Cont is
    Port ( reset : in  STD_LOGIC;
           cuenta : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Sal : out  STD_LOGIC_vector(4 downto 0));
end component;

begin

	c1: Cont port map (Reset=>reset,cuenta=>cuenta,Clk=>Clk,Sal=>Sal); 

	SEQ: process (Clk, Reset)
	begin
	
		if Reset ='1' then
			
			ESTADO <= VR;
			
		elsif (rising_edge(Clk)) then
			
			ESTADO <= SIG_ESTADO;
			
		end if;
		
	end process SEQ;

	Comb :process(sensor,estado,Sal)
    begin
	 
	 if Reset ='1' then
			cuenta<='1';
	 end if;
	 
	 
	 case ESTADO is
	     when VR=>	if Sal = "01101" and cuenta='1' then  
							cuenta<='0';
						else SIG_ESTADO<=VR;
						end if; 
						if sensor='1' and Sal = "01101" then   
		               SIG_ESTADO<=AR;
							cuenta<='1';
						end if;
		  when AR=> if Sal="10001" then 
                      SIG_ESTADO<=RV;
							 
                   ELSE SIG_ESTADO<=AR;
						 END IF;
        when RV=> IF Sal="11011" then 
                     SIG_ESTADO<=RA;
							
                   else SIG_ESTADO<=RV;
                  end if;
		  when RA=> if Sal="11111" then
                   SIG_ESTADO<=VR ;
						 
                   else SIG_ESTADO <=RA;
                  end if;
				end case;	
		
	case ESTADO is
     when VR=> semaforoPrincipal<="100";
	            semaforoCruce<="001";
		when AR=> semaforoPrincipal<="010";
                semaforoCruce<="001";
      when RV=> semaforoPrincipal<="001";
                semaforoCruce<="100";
      when RA=> semaforoPrincipal<="001";
                semaforoCruce<="010";
   end case;
	
	end process Comb;

end Behavioral;

