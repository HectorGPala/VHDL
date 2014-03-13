--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:35:51 12/17/2012
-- Design Name:   
-- Module Name:   E:/Documentos/UCM-FDI/Curso 2012-2013/LEC/Practica7/Prueba_banco.vhd
-- Project Name:  Practica7
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
 
ENTITY Prueba_banco IS
END Prueba_banco;
 
ARCHITECTURE behavior OF Prueba_banco IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BancoReg
    PORT(
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         RegWr : IN  std_logic;
         busW : IN  std_logic_vector(31 downto 0);
         RA : IN  std_logic_vector(4 downto 0);
         RB : IN  std_logic_vector(4 downto 0);
         RW : IN  std_logic_vector(4 downto 0);
         busA : OUT  std_logic_vector(31 downto 0);
         busB : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal RegWr : std_logic := '0';
   signal busW : std_logic_vector(31 downto 0) := (others => '0');
   signal RA : std_logic_vector(4 downto 0) := (others => '0');
   signal RB : std_logic_vector(4 downto 0) := (others => '0');
   signal RW : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal busA : std_logic_vector(31 downto 0);
   signal busB : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancoReg PORT MAP (
          CLK => CLK,
          RESET => RESET,
          RegWr => RegWr,
          busW => busW,
          RA => RA,
          RB => RB,
          RW => RW,
          busA => busA,
          busB => busB
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
		Reset<= '1';
		RA <= "00001";
		RB <= "00010";
		wait for 100ns;
		Reset<= '0';
		RegWr <= '1';
		busW <= x"AAAAAAAA";
		RW <= "00001";
		wait for 100ns;
		busW <= x"BBAAAABB";
		RW <= "00010";
		wait for 100ns;
		RegWr <= '0';
		RA <= "00001";
		RB <= "00010";
		wait for 100ns;
		RA <= "00010";
		RB <= "00011";
		

      wait;
   end process;

END;
