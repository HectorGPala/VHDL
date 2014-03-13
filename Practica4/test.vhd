--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:53:41 10/29/2012
-- Design Name:   
-- Module Name:   C:/hlocal/Practica4/test.vhd
-- Project Name:  Practica4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         CO : IN  std_logic_vector(2 downto 0);
         op1 : IN  std_logic_vector(7 downto 0);
         op2 : IN  std_logic_vector(7 downto 0);
         v_result : OUT  std_logic_vector(7 downto 0);
         overflow : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CO : std_logic_vector(2 downto 0) := (others => '0');
   signal op1 : std_logic_vector(7 downto 0) := (others => '0');
   signal op2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal v_result : std_logic_vector(7 downto 0);
   signal overflow : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CO => CO,
          op1 => op1,
          op2 => op2,
          v_result => v_result,
          overflow => overflow
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100ms.
      --wait for 100ms;	

      -- insert stimulus here 
CO <=  "000";
op1 <=  (x"08");
op2 <=  (x"60");
 --------------------
WAIT FOR 50 ns; 
op1 <= (x"80");
op2 <= (x"60");
 --------------------
WAIT FOR 50 ns;
op1 <= (x"01");
op2 <= (x"9C");
 --------------------
WAIT FOR 50 ns;
op1 <= (x"FF");
op2 <= (x"9C");--desbordamiento

-- --------------------
WAIT FOR 50 ns; 
CO <= "001";
op1 <=  (x"08");
op2 <= (x"07");
-- --------------------
WAIT FOR 50 ns; 
op1 <= (x"01");
op2 <= (x"FF");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"A7");
op2 <= (x"FF");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"A7");
op2 <= (x"83");--desbordamiento

WAIT FOR 50 ns; 

CO <= "010";
op1 <= (x"80");
op2 <= (x"0D");
-- --------------------
WAIT FOR 50 ns; 
op1 <= (x"01");
op2 <= (x"81");--desbordamiento
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"FF");
op2 <= (x"81");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"83");
op2 <= (x"81");
-----------------------
WAIT FOR 50 ns; 
CO <= transport "011";
op1 <= transport (x"80");
op2 <= transport (x"1C");--desbordamiento
-- --------------------

WAIT FOR 50 ns; 
op1 <= (x"01");
op2 <= (x"04");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"FF");
op2 <= (x"04"); 
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"0B");
op2 <= (x"FF");

WAIT FOR 50 ns; 
CO <= transport "100";
op1 <= transport (x"0B");
op2 <= transport (x"FF");--desbordamiento
-- --------------------
WAIT FOR 50 ns; 
op1 <= (x"08");
op2 <= (x"0B");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"0C");
op2 <= (x"0B");
-- --------------------
WAIT FOR 50 ns;
op1 <= (x"05");
op2 <= (x"1E");

      wait;
   end process;

END;
