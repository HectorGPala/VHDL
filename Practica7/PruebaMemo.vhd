--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:01:44 12/17/2012
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/Practica7/PruebaMemo.vhd
-- Project Name:  Practica7
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MemDatos
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
 
ENTITY PruebaMemo IS
END PruebaMemo;
 
ARCHITECTURE behavior OF PruebaMemo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MemDatos
    PORT(
         ADDR : IN  std_logic_vector(31 downto 0);
         DW : IN  std_logic_vector(31 downto 0);
         DR : OUT  std_logic_vector(31 downto 0);
         MemWrite : IN  std_logic;
         MemRead : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ADDR : std_logic_vector(31 downto 0) := (others => '0');
   signal DW : std_logic_vector(31 downto 0) := (others => '0');
   signal MemWrite : std_logic := '0';
   signal MemRead : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal DR : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MemDatos PORT MAP (
          ADDR => ADDR,
          DW => DW,
          DR => DR,
          MemWrite => MemWrite,
          MemRead => MemRead,
          CLK => CLK
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
		ADDR <= x"00000001";
		--MemWrite <= '1';
		DW <= x"AAAAAAAA";
		wait for 100ns;
		MemRead <= '1';
		MemWrite <= '0';

      wait;
   end process;

END;
