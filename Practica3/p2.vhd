--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:48 10/22/2012
-- Design Name:   
-- Module Name:   C:/hlocal/PR3/p2.vhd
-- Project Name:  PR3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CruceSem
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
 
ENTITY p2 IS
END p2;
 
ARCHITECTURE behavior OF p2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CruceSem
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         semaforoPrincipal : OUT  std_logic_vector(2 downto 0);
         semaforoCruce : OUT  std_logic_vector(2 downto 0);
         sensor : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal sensor : std_logic := '0';

 	--Outputs
   signal semaforoPrincipal : std_logic_vector(2 downto 0);
   signal semaforoCruce : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CruceSem PORT MAP (
          Clk => Clk,
          Reset => Reset,
          semaforoPrincipal => semaforoPrincipal,
          semaforoCruce => semaforoCruce,
          sensor => sensor
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      Reset<='1';
		wait for 10 ns ;
		Reset<='0';
		wait for 180 ns;
		sensor<='1';
		wait for 10 ns;

      wait;
   end process;

END;
