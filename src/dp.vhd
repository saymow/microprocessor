LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dp IS PORT (
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
); END dp;

ARCHITECTURE struct OF dp IS

COMPONENT mux4 PORT (
	sel_mux                            : IN std_logic_vector(1 DOWNTO 0);
	in3_mux, in2_mux, in1_mux, in0_mux : IN std_logic_vector(7 DOWNTO 0);
	out_mux                            : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT acc PORT (
	clk_acc   : IN std_logic;
	rst_acc   : IN std_logic;
	wr_acc    : IN std_logic;
	input_acc : IN std_logic_vector(7 DOWNTO 0);
	
	output_acc : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT reg_file PORT (
	clk_rf   : IN std_logic;
	wr_rf    : IN std_logic;
	addr_rf  : IN std_logic_vector(2 DOWNTO 0);
	input_rf : IN std_logic_vector(7 DOWNTO 0);
	output_rf : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT alu PORT (
	sel_alu    : IN std_logic_vector(2 DOWNTO 0);
	inA_alu    : IN std_logic_vector(7 DOWNTO 0);
	inB_alu    : IN std_logic_vector(7 DOWNTO 0);
	output_alu : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT shifter PORT (
	sel_shift    : IN std_logic_vector(1 DOWNTO 0);
	input_shift  : IN std_logic_vector(7 DOWNTO 0);
		output_shift : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT tristatebuffer PORT (
	E : IN std_logic;
	D : IN std_logic_vector(7 DOWNTO 0);
	Y : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

SIGNAL C_aluout, C_accout, C_rfout, C_muxout, C_shiftout: std_logic_vector(7 DOWNTO 0);
SIGNAL C_outen: std_logic;

BEGIN
	UO: mux4 PORT MAP(muxsel_dp, imm_dp, input_dp, C_rfout, C_shiftout, C_muxout);
	U1: acc PORT MAP(clk_dp, rst_dp, accwr_dp, C_muxout, C_accout);
	U2: reg_file PORT MAP(clk_dp, rfwr_dp, rfaddr_dp, C_accout, C_rfout);
	U3: alu PORT MAP(alusel_dp, C_accout, C_rfout, C_aluout);
	U4: shifter PORT MAP(shiftsel_dp, C_aluout, C_shiftout);
	
	C_outen <= outen_dp OR rst_dp;
	
	U5: tristatebuffer PORT MAP(C_outen, C_accout, output_dp); --output_dp <= C_accout
	
	zero_dp <= '1' WHEN (C_muxout = "00000000") ELSE '0';
	positive_dp <= NOT C_muxout(7);
	
END struct;







