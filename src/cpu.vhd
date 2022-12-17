LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY cpu IS PORT (
	clk_cpu    : IN std_logic;	
	rst_cpu    : IN std_logic;
	input_cpu  : IN std_logic_vector(7 DOWNTO 0);
	output_cpu : OUT std_logic_vector(7 DOWNTO 0)
); END cpu;

ARCHITECTURE structure OF cpu IS

COMPONENT ctrl PORT (
	clk_ctrl	  : IN std_logic;
	rst_ctrl	  : IN std_logic;
	muxsel_ctrl   : OUT std_logic_vector(1 DOWNTO 0);
	imm_ctrl      : OUT std_logic_vector(7 DOWNTO 0);
	accwr_ctrl    : OUT std_logic;
	rfaddr_ctrl   : OUT std_logic_vector(2 DOWNTO 0);
	rfwr_ctrl     : OUT std_logic;
	alusel_ctrl   : OUT std_logic_vector(2 DOWNTO 0);
	shiftsel_ctrl : OUT std_logic_vector(1 DOWNTO 0);
	outen_ctrl    : OUT std_logic;
	zero_ctrl     : IN std_logic;
	positive_ctrl : IN std_logic
); END COMPONENT;

COMPONENT dp PORT (
	clk_dp      : IN std_logic;
	rst_dp      : IN std_logic;
	muxsel_dp   : IN std_logic_vector(1 DOWNTO 0);
	imm_dp      : IN std_logic_vector(7 DOWNTO 0);
	input_dp    : IN std_logic_vector(7 DOWNTO 0);
	accwr_dp    : IN std_logic;
	rfaddr_dp   : IN std_logic_vector(2 DOWNTO 0);
	rfwr_dp     : IN std_logic;
	alusel_dp   : IN std_logic_vector(2 DOWNTO 0);
	shiftsel_dp : IN std_logic_vector(1 DOWNTO 0);
	outen_dp    : IN std_logic;
	zero_dp     : OUT std_logic;
	positive_dp : OUT std_logic;
	output_dp   : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

SIGNAL C_immediate: std_logic_vector(7 DOWNTO 0);
--SIGNAL D_immediate: std_logic_vector(7 DOWNTO 0);
SIGNAL C_accwr,C_rfwr,C_outen,C_zero,C_positive: std_logic;
SIGNAL C_muxsel,C_shiftsel: std_logic_vector(1 DOWNTO 0);
SIGNAL C_rfaddr,C_alusel: std_logic_vector(2 DOWNTO 0);

BEGIN
	U0: ctrl PORT MAP (
		clk_cpu, rst_cpu, C_muxsel, C_immediate, C_accwr, C_rfaddr, C_rfwr,
		C_alusel, C_shiftsel, C_outen, C_zero, C_positive
	);

	U1: dp PORT MAP (
		clk_cpu, rst_cpu, C_muxsel, C_immediate, input_cpu, C_accwr,
		C_rfaddr, C_rfwr, C_alusel, C_shiftsel, C_outen, C_zero, C_positive,
		output_cpu
	);

	-- D_immediate <= C_immediate;
END structure;