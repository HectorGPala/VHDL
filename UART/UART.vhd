----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:47:24 01/17/2013 
-- Design Name: 
-- Module Name:    UART - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART is
    Port ( CS_UART : in  STD_LOGIC;
           OP_UART : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIN_UART : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT_UART : out  STD_LOGIC_VECTOR (7 downto 0);
           CLKSYS : in  STD_LOGIC;
           ResetSYS : in  STD_LOGIC;
           TRX_UART : out  STD_LOGIC;
           RCX_UART : in  STD_LOGIC);
end UART;

architecture rtl of UART is

component ITFCPU is
    Port ( CS : in  STD_LOGIC;
           OP : in  STD_LOGIC_VECTOR (1 downto 0);
           DataIN : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           DataREG_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
			  DataREG_IN : in  STD_LOGIC_VECTOR (7 downto 0);
			  TBusy : in STD_LOGIC;
			  DAVLB : in STD_LOGIC;
			  DOVRW : in STD_LOGIC;
			  LeidoDOUT : out STD_LOGIC;
			  LoadDOUT : out  STD_LOGIC;
           LoadCFG : out  STD_LOGIC);
end component ITFCPU;

component RECVR is
    Port ( RCX : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
			  CfgIN : in STD_LOGIC_VECTOR(7 downto 0);
			  DataOUT : out  STD_LOGIC;
			  W : out STD_LOGIC);
end component RECVR;

component TRATR is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Enable : in  STD_LOGIC;
           DataIN : in  STD_LOGIC;
           CfgIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  Lee : out STD_LOGIC;
           TRX : out  STD_LOGIC;
           TBusy : out  STD_LOGIC);
end component TRATR;

component RegPISO is
    Port ( DIN : in  STD_LOGIC_VECTOR (7 downto 0);
			  Load: in STD_LOGIC;
			  Leido : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DOUT : out  STD_LOGIC;
			  LLeno: out STD_LOGIC);
end component RegPISO;

component RegSIPO is
    Port ( DIN : in  STD_LOGIC;
           Load : in  STD_LOGIC;
			  Leido : in STD_LOGIC;
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (7 downto 0);
			  DOVRW : out STD_LOGIC;
           LLeno : out  STD_LOGIC);
end component RegSIPO;

component Reg8 is
    Port ( DataIN : in  STD_LOGIC_VECTOR (7 downto 0);
           DataOUT : out  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Load : in  STD_LOGIC);
end component Reg8;

signal DataREG_OUT,DataREG_IN,CFG_OUT : STD_LOGIC_VECTOR(7 downto 0);
signal TBusy,DOVRW,LeidoRegIN,LeidoRegOUT,LoadDOUT,LoadDIN,LoadCFG,SalidaRegOUT,DatoDisponibleR_IN,DatoDisponibleR_OUT,SalidaRECVR : STD_LOGIC;

begin

interfaz : ITFCPU port map (CS_UART,OP_UART,DataIN_UART,DataOUT_UART,DataREG_OUT,DataREG_IN,TBusy,DatoDisponibleR_IN,DOVRW,LeidoRegIN,LoadDOUT,LoadCFG);

RegSalida: RegPISO port map (DataREG_OUT,LoadDOUT,LeidoRegOUT,CLKSYS,ResetSYS,SalidaRegOUT,DatoDisponibleR_OUT);

RegEntrada : RegSIPO port map (SalidaRECVR,LoadDIN,LeidoRegIN,CLKSYS,ResetSYS,DataREG_IN,DOVRW,DatoDisponibleR_IN);

RegConfiguracion : Reg8 port map (DataREG_OUT,CFG_OUT,CLKSYS,ResetSYS,LoadCFG);

M_Recepcion : RECVR port map (RCX_UART,CLKSYS,ResetSYS,CFG_OUT,SalidaRECVR,LoadDIN);

M_Transmision : TRATR port map (CLKSYS,ResetSYS,DatoDisponibleR_OUT,SalidaRegOUT,CFG_OUT,LeidoRegOUT,TRX_UART,TBusy);


end rtl;

