--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:29:36 01/17/2013
-- Design Name:   
-- Module Name:   C:/hlocal/PFinal/Test.vhd
-- Project Name:  PFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DosUART
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
 
ENTITY Test IS
END Test;
 
ARCHITECTURE behavior OF Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DosUART
    PORT(
         CLK : IN  std_logic;
         CS_1 : IN  std_logic;
         OP_1 : IN  std_logic_vector(1 downto 0);
         DataIN_1 : IN  std_logic_vector(7 downto 0);
         DataOUT_1 : OUT  std_logic_vector(7 downto 0);
         TRX_1 : OUT  std_logic;
         CS_2 : IN  std_logic;
         OP_2 : IN  std_logic_vector(1 downto 0);
         DataIN_2 : IN  std_logic_vector(7 downto 0);
         DataOUT_2 : OUT  std_logic_vector(7 downto 0);
         TRX_2 : OUT  std_logic;
         ResetSYS : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal CS_1 : std_logic := '0';
   signal OP_1 : std_logic_vector(1 downto 0) := (others => '0');
   signal DataIN_1 : std_logic_vector(7 downto 0) := (others => '0');
   signal CS_2 : std_logic := '0';
   signal OP_2 : std_logic_vector(1 downto 0) := (others => '0');
   signal DataIN_2 : std_logic_vector(7 downto 0) := (others => '0');
   signal ResetSYS : std_logic := '0';

 	--Outputs
   signal DataOUT_1 : std_logic_vector(7 downto 0);
   signal TRX_1 : std_logic;
   signal DataOUT_2 : std_logic_vector(7 downto 0);
   signal TRX_2 : std_logic;
	
	 -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DosUART PORT MAP (
          CLK => CLK,
          CS_1 => CS_1,
          OP_1 => OP_1,
          DataIN_1 => DataIN_1,
          DataOUT_1 => DataOUT_1,
          TRX_1 => TRX_1,
          CS_2 => CS_2,
          OP_2 => OP_2,
          DataIN_2 => DataIN_2,
          DataOUT_2 => DataOUT_2,
          TRX_2 => TRX_2,
          ResetSYS => ResetSYS
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
      -- hold reset state for 100ms.
      --wait for 100ms;	

      --wait for CLK_period*10;

      -- insert stimulus here
			ResetSYS <= '1';--reseteamos el sistema
			wait for 50ns;
			ResetSYS <= '0';
			CS_1 <= '1';
			CS_2 <= '1';
			OP_1 <= "10";
			OP_2 <= "10";--consultamos el estado de ambas uart
			wait for 20ns;
			OP_1 <= "11";
			OP_2 <= "11";
			DataIN_1 <= "10101010";
			DataIN_2 <= "11011101";--escribimos configuracion aunque no la usamos...
			wait for 20ns;
			OP_1 <= "01";
			OP_2 <= "01";
			DataIN_2 <= "10101010";
			DataIN_1 <= "11110000";--escribimos un par de datos de entrada en cada uart
			wait for 20ns;
			OP_1 <= "10";
			OP_2 <= "10";--consultamos el estado para ver cuando termina la transferencia
			--la transferencia dura 1600ns = 10ns/ciclo * 10bits(8bits+bit_start+bit_fin) * 16ciclos/bit
			wait for 1700ns;
			OP_1 <= "00";
			OP_2 <= "00";--leemos los datos y lo que entro en uart1 esta a la salida de uart2 y viceversa
			wait for 50ns;
			--comprobamos sobreescritura
			OP_1 <= "01";
			OP_2 <= "01";
			DataIN_2 <= "11001100";
			DataIN_1 <= "00000000";--escribimos otros datos
			wait for 20ns;
			OP_1 <= "10";
			OP_2 <= "10";--vemos el proceso de transferencia y tras 1600ns...
			wait for 1700ns;
			OP_1 <= "01";
			OP_2 <= "01";
			DataIN_2 <= "11111111";
			DataIN_1 <= "00000000";--escribimos otra vez para transferir sin leer lo recogido en DINREG
			wait for 20ns;
			OP_1 <= "10";
			OP_2 <= "10";--esperamos tranferencia y vemos sobreescritura 
			wait for 1700ns;
			OP_1 <= "00";
			OP_2 <= "00";--leemos ese dato 
			wait for 20ns;
			OP_1 <= "10";
			OP_2 <= "10";--comprobamos que al volver a consultar estado desaparece la sobreescritura
			wait for 20ns;
			OP_1 <= "01";
			OP_2 <= "01";--escribimos otro dato...
			DataIN_2 <= "11111111";
			DataIN_1 <= "00000000";
			wait for 20ns;
			OP_1 <= "10";
			OP_2 <= "10";--consultamos estado...
			
			
			

      wait;
   end process;

END;
