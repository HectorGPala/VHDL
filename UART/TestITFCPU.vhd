--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:09:00 01/15/2013
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/PracticaFinal/TestITFCPU.vhd
-- Project Name:  PracticaFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ITFCPU
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
 
ENTITY TestITFCPU IS
END TestITFCPU;
 
ARCHITECTURE behavior OF TestITFCPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ITFCPU
    PORT(
         CS : IN  std_logic;
         OP : IN  std_logic_vector(1 downto 0);
         DataIN : IN  std_logic_vector(7 downto 0);
         DataOUT : OUT  std_logic_vector(7 downto 0);
         DataREG_OUT : OUT  std_logic_vector(7 downto 0);
         DataREG_IN : IN  std_logic_vector(7 downto 0);
         TBusy : IN  std_logic;
         DAVLB : IN  std_logic;
         DOVRW : IN  std_logic;
         LeidoDOUT : OUT  std_logic;
         LoadDOUT : OUT  std_logic;
         LoadCFG : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CS : std_logic := '0';
   signal OP : std_logic_vector(1 downto 0) := (others => '0');
   signal DataIN : std_logic_vector(7 downto 0) := (others => '0');
   signal DataREG_IN : std_logic_vector(7 downto 0) := (others => '0');
   signal TBusy : std_logic := '0';
   signal DAVLB : std_logic := '0';
   signal DOVRW : std_logic := '0';

 	--Outputs
   signal DataOUT : std_logic_vector(7 downto 0);
   signal DataREG_OUT : std_logic_vector(7 downto 0);
   signal LeidoDOUT : std_logic;
   signal LoadDOUT : std_logic;
   signal LoadCFG : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ITFCPU PORT MAP (
          CS => CS,
          OP => OP,
          DataIN => DataIN,
          DataOUT => DataOUT,
          DataREG_OUT => DataREG_OUT,
          DataREG_IN => DataREG_IN,
          TBusy => TBusy,
          DAVLB => DAVLB,
          DOVRW => DOVRW,
          LeidoDOUT => LeidoDOUT,
          LoadDOUT => LoadDOUT,
          LoadCFG => LoadCFG
        );

   -- Clock process definition
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

     -- wait for <clock>_period*10;

      -- insert stimulus here 
		CS <= '0';
		OP <= "10";
		TBusy <= '1';
		DAVLB <= '1';
		DOVRW <= '1';
		wait for 50ns;
		CS <= '1';
		DataIN <= "10101010";
		wait for 50ns;
		OP <= "01";
		wait for 50ns;
		DataIN <= "10101111";
		OP <= "11";
		wait for 50ns;
		OP <= "00";
		TBusy <= '0';
		DAVLB <= '1';
		DOVRW <= '0';
		wait for 50ns;
		OP <= "10";
		

      wait;
   end process;

END;
