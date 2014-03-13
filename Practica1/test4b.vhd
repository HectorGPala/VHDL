--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:51:30 10/08/2012
-- Design Name:   
-- Module Name:   C:/hlocal/Practica1/test4b.vhd
-- Project Name:  Practica1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sum4b
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test4b IS
END test4b;
 
ARCHITECTURE behavior OF test4b IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sum4b
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         cin : IN  std_logic;
         sum : OUT  std_logic_vector(3 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sum4b PORT MAP (
          a => a,
          b => b,
          cin => cin,
          sum => sum,
          cout => cout
        );


  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      a <= "0100";
		b <= "0101";
		wait for 100 ns;
		b <= "0010";
		wait for 100 ns;
		a <= "1100";
		b <= "0100";
		wait for 100 ns;
		b <= "0000";

      -- insert stimulus here 

      wait;
   end process;

END;
