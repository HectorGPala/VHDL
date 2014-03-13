----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:13:08 12/13/2012 
-- Design Name: 
-- Module Name:    CPU_MIPS - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_MIPS is
    Port ( CLK : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Depuracion : out  STD_LOGIC_VECTOR (31 downto 0);
			  Salida_ALU : out STD_LOGIC_VECTOR (31 downto 0);
			  Bra : out STD_LOGIC;
			  Zero : out STD_LOGIC);
end CPU_MIPS;

architecture Behavioral of CPU_MIPS is

component BancoReg is
    Port ( CLK : in  STD_LOGIC;
			  RESET : in STD_LOGIC;
		     RegWr: in STD_LOGIC;
           busW : in  STD_LOGIC_VECTOR (31 downto 0);
           RA : in  STD_LOGIC_VECTOR (4 downto 0);
		     RB : in  STD_LOGIC_VECTOR (4 downto 0);
           RW : in  STD_LOGIC_VECTOR (4 downto 0);
           busA : out  STD_LOGIC_VECTOR (31 downto 0);
		     busB : out  STD_LOGIC_VECTOR (31 downto 0));
end component BancoReg;

component Reg32 is
    Port ( LOAD : in  STD_LOGIC;
           CLKR : in  STD_LOGIC;
			  ResetR: in STD_LOGIC;
           B_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           B_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end component Reg32;

component ALU is
    Port ( CO : in  STD_LOGIC_VECTOR (2 downto 0);
           op1 : in  STD_LOGIC_VECTOR(31 downto 0);
           op2 : in  STD_LOGIC_VECTOR(31 downto 0);
           v_result : out  STD_LOGIC_VECTOR(31 downto 0);
           overflow : out  std_logic;
			  Zero : out std_logic);
end component ALU;

component ControlAlu is
    Port ( AluOP : in  STD_LOGIC_VECTOR (1 downto 0);
           Funct : in  STD_LOGIC_VECTOR (5 downto 0);
           AluCrtl : out  STD_LOGIC_VECTOR (2 downto 0));
end component ControlAlu;

component ExtSigno is
    Port ( B_In : in  STD_LOGIC_VECTOR (15 downto 0);
           B_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component ExtSigno;

component MemDatos is
    Port ( ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           DW : in  STD_LOGIC_VECTOR (31 downto 0);
           DR : out  STD_LOGIC_VECTOR (31 downto 0);
           MemWrite : in  STD_LOGIC;
			  MemRead : in STD_LOGIC;
           CLK : in  STD_LOGIC);
end component MemDatos;

component MemInstrucciones is
    Port ( ADDR : in  STD_LOGIC_VECTOR (31 downto 0);
           DR : out  STD_LOGIC_VECTOR (31 downto 0);
           CLK : in  STD_LOGIC);
end component MemInstrucciones;

component Mux2a1 is
	generic (n: integer := 32);
    Port ( D_In0 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           D_In1 : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Sel : in  STD_LOGIC;
           D_Out : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component Mux2a1;

component UnidadControl is
    Port ( E : in  STD_LOGIC_VECTOR (5 downto 0);
           RegDst : out  STD_LOGIC;
           AluSrc : out  STD_LOGIC;
           MemToReg : out  STD_LOGIC;
           RegWrite : out  STD_LOGIC;
           MemRead : out  STD_LOGIC;
           MemWrite : out  STD_LOGIC;
           Branch : out  STD_LOGIC;
           AluOP : out  STD_LOGIC_VECTOR (1 downto 0));
end component UnidadControl;

signal SalidaPC,SMUX1,SMUX3,S1,S2,Instruccion,busA,busB,SalMD,SExt,S_ALU,datoM : STD_LOGIC_VECTOR (31 downto 0);
signal ALU_CRTL : STD_LOGIC_VECTOR(2 downto 0);
signal SMUX2 : STD_LOGIC_VECTOR(4 downto 0);
signal ALU_OP : STD_LOGIC_VECTOR(1 downto 0);
signal RWrite,RDest,ALUSRC,Z,MToR,Br,WriteM,ReadM : STD_LOGIC;
signal PCSrc : STD_LOGIC;
signal overflow1,overflow2,overflow3,z1,z2: STD_LOGIC;

alias Inst31_26 :STD_LOGIC_VECTOR(5 downto 0) is Instruccion(31 downto 26);
alias Inst25_21 :STD_LOGIC_VECTOR(4 downto 0) is Instruccion(25 downto 21);
alias Inst20_16 :STD_LOGIC_VECTOR(4 downto 0) is Instruccion(20 downto 16);
alias Inst15_11 :STD_LOGIC_VECTOR(4 downto 0) is Instruccion(15 downto 11);
alias Inst15_0 :STD_LOGIC_VECTOR(15 downto 0) is Instruccion(15 downto 0);
alias Inst5_0 :STD_LOGIC_VECTOR(5 downto 0) is Instruccion(5 downto 0);


begin

PCSrc <= Br and Z;

regPC: Reg32 port map ('1',CLK,Reset,SMUX1,SalidaPC);

mInstrucciones: MemInstrucciones port map (SalidaPC,Instruccion,CLK);

alu_PC: ALU port map ("010",SalidaPC,x"00000001",S1,z1,z2);

bReg: BancoReg port map (CLK,Reset,RWrite,SalMD,Inst25_21,Inst20_16,SMUX2,busA,busB);

extendSign: ExtSigno port map (Inst15_0,SExt);

alu_principal: ALU port map (ALU_CRTL,busA,SMUX3,S_ALU,overflow2,Z);

alu_PCDespl: ALU port map ("010",S1,SExt,S2,overflow3,z2);

mDatos: MemDatos port map (S_ALU,busB,datoM,WriteM,ReadM,CLK);

mux1: Mux2a1 generic map (n => 32) port map (S1,S2,PCSrc,SMUX1);
mux2: Mux2a1 generic map (n => 5) port map (Inst20_16,Inst15_11,RDest,SMUX2);
mux3: Mux2a1 generic map (n => 32) port map (busB,SExt,ALUSRC,SMUX3);
mux4: Mux2a1 generic map (n => 32) port map (S_ALU,datoM,MToR,SalMD);

control_ALU: ControlAlu port map (ALU_OP,Inst5_0,ALU_CRTL);

controlPrincipal: UnidadControl port map (Inst31_26,RDest,ALUSRC,MToR,RWrite,ReadM,WriteM,Br,ALU_OP);

--regDepuracion: Reg32 port map (WriteM,CLK,Reset,Instruccion,Depuracion);
Depuracion <= SalidaPC;
Salida_ALU <= S_ALU;
Bra <= Br;
Zero<= Z;

end Behavioral;

