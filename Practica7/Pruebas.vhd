--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:27:12 12/14/2012
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/Practica7/Pruebas.vhd
-- Project Name:  Practica7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_MIPS
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
 
ENTITY Pruebas IS
END Pruebas;
 
ARCHITECTURE behavior OF Pruebas IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_MIPS
    PORT(
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         Depuracion : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Depuracion : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 30 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_MIPS PORT MAP (
          CLK => CLK,
          Reset => Reset,
          Depuracion => Depuracion
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
      --wait for 100 ns;	

     -- wait for CLK_period*10;

      -- insert stimulus here 
		Reset<= '1';
		wait for 100ns;
		Reset<= '0';
		wait;
   end process;

END;
