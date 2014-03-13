--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:53:39 11/26/2012
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/Practica6/Prueba.vhd
-- Project Name:  Practica6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Cache
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
 
ENTITY Prueba IS
END Prueba;
 
ARCHITECTURE behavior OF Prueba IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Cache
    PORT(
         Dir : IN  std_logic_vector(15 downto 0);
         Entrada : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         CLK : IN  std_logic;
         Reset : IN  std_logic;
         Salida : OUT  std_logic_vector(7 downto 0);
         Acierto : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Dir : std_logic_vector(15 downto 0) := (others => '0');
   signal Entrada : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal CLK : std_logic := '0';
   signal Reset : std_logic := '0';

 	--Outputs
   signal Salida : std_logic_vector(7 downto 0);
   signal Acierto : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Cache PORT MAP (
          Dir => Dir,
          Entrada => Entrada,
          RW => RW,
          CLK => CLK,
          Reset => Reset,
          Salida => Salida,
          Acierto => Acierto
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

      --wait for CLK_period*10;

      -- insert stimulus here 
		Reset <= '1';
		wait for 50 ns;
		Reset <= '0';
		--fallo de lectura
		RW <= '0';
		Dir <= x"0003";
		wait for 50 ns;
		--acierto de lectura
		Dir <= x"0004";
		wait for 50 ns;
		Dir <= x"0020";
		wait for 50 ns;
		Dir <= x"0024";
		wait for 50 ns;
		--acierto de escritura
		Dir <= x"0000";
		Entrada <= "11111111";
		RW <= '1';
		wait for 50 ns;
		--leemos
		RW <= '0';
		--reemplazo
		wait for 50 ns;
		Dir <= x"0200";--lee 512
		wait for 50 ns;
		Dir <= x"0000";--lee otra vez 0
		wait for 50 ns;
		RW <= '1';
		--wait for 100 ns;
		--fallo de escritura
		--Entrada <= "10101010";
		Dir <= x"0400";--1024
		Entrada <= "00110011";
		wait for 50 ns;
		--Entrada <= "10101010";
		--leo el fallo de escritura
		RW <= '0';

      wait;
   end process;

END;
