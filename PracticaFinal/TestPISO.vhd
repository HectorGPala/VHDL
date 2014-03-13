--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:13:53 01/15/2013
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/PracticaFinal/TestPISO.vhd
-- Project Name:  PracticaFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegPISO
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
 
ENTITY TestPISO IS
END TestPISO;
 
ARCHITECTURE behavior OF TestPISO IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegPISO
    PORT(
         DIN : IN  std_logic_vector(7 downto 0);
         Load : IN  std_logic;
         Leido : IN  std_logic;
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         DOUT : OUT  std_logic;
         LLeno : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(7 downto 0) := (others => '0');
   signal Load : std_logic := '0';
   signal Leido : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic;
   signal LLeno : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegPISO PORT MAP (
          DIN => DIN,
          Load => Load,
          Leido => Leido,
          CLK => CLK,
          Reset => Reset,
          DOUT => DOUT,
          LLeno => LLeno
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 
		DIN <= "10011110";
		Load <= '1';
		Reset <= '0';
		wait for 100ns;
		Load <= '0';
		wait for 100ns;
		Leido<= '1';
		wait for 10ns;
		Leido <= '0';
		wait for 10ns;
		Leido <= '1';
		wait for 10ns;
		Leido <= '0';
		wait for 10ns;
		Leido <= '1';
      wait;
   end process;

END;
