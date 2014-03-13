--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:10:31 10/15/2012
-- Design Name:   
-- Module Name:   C:/hlocal/Practica2/bancoPruebas.vhd
-- Project Name:  Practica2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BancoReg
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
 
ENTITY bancoPruebas IS
END bancoPruebas;
 
ARCHITECTURE behavior OF bancoPruebas IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BancoReg
    PORT(
         CLK : IN  std_logic;
         W : IN  std_logic;
         Din : IN  std_logic_vector(7 downto 0);
         Aread : IN  std_logic_vector(2 downto 0);
         Awrite : IN  std_logic_vector(2 downto 0);
         Dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal W : std_logic := '0';
   signal Din : std_logic_vector(7 downto 0) := (others => '0');
   signal Aread : std_logic_vector(2 downto 0) := (others => '0');
   signal Awrite : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal Dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancoReg PORT MAP (
          CLK => CLK,
          W => W,
          Din => Din,
          Aread => Aread,
          Awrite => Awrite,
          Dout => Dout
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

		W <= transport '1';
		Din <= transport std_logic_vector'("11111111"); --FF
		Awrite <= transport std_logic_vector'("000"); --0
		-- --------------------
		WAIT FOR 20 ns; -- Time=20 ns
		W <= transport '0';
		Aread <= transport std_logic_vector'("000"); --0
		-- comprobamos que se ha escrito correctamente en la dirección 0
		-- --------------------
		WAIT FOR 10 ns; -- Time=30 ns
		Aread <= transport std_logic_vector'("001"); --1
		-- comprobamos que hay escrito en 1
		-- --------------------
		WAIT FOR 10 ns; -- Time=40 ns
		W <= transport '1';
		Din <= transport std_logic_vector'("10001111"); --8F
		Awrite <= transport std_logic_vector'("001"); --1
		-- --------------------
		WAIT FOR 10 ns; -- Time=50 ns
		W <= transport '0';
		Aread <= transport std_logic_vector'("001"); --0
		-- comprobamos que se ha escrito correctamente en la dirección 1
		-- --------------------
		-- Este proceso puede seguir hasta comprobar todas las posibles
		-- combinaciones

      -- insert stimulus here 

      wait;
   end process;

END;
