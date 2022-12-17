LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;

ENTITY computer IS PORT (
	clock_25MHz : IN std_logic;
	reset       : IN std_logic;
	input_comp  : IN std_logic_vector(7 DOWNTO 0);
	digit1_comp : OUT std_logic_vector(1 TO 8);
	digit2_comp : OUT std_logic_vector(1 TO 8)
); END computer;

ARCHITECTURE structure OF computer IS

COMPONENT clk_generator PORT (
	clock_25Mhz   : IN std_logic;
	clock_1MHz    : OUT std_logic;
	clock_100KHz  : OUT std_logic;
	clock_10KHz   : OUT std_logic;
	clock_1KHz    : OUT std_logic;
	clock_100Hz   : OUT std_logic;
	clock_10Hz    : OUT std_logic;
	clock_1Hz     : OUT std_logic
); END COMPONENT;


COMPONENT cpu PORT (
	clk_cpu    : IN std_logic;
	rst_cpu    : IN std_logic;
	input_cpu  : IN std_logic_vector(7 DOWNTO 0);
	output_cpu : OUT std_logic_vector(7 DOWNTO 0)
); END COMPONENT;

COMPONENT output PORT (
	number         : IN std_logic_vector(7 DOWNTO 0);
	digit1, digit2 : OUT std_logic_vector(1 TO 7)
); END COMPONENT;

SIGNAL clk                : std_logic;
SIGNAL resetN             : std_logic;
SIGNAL C_outcpu           : std_logic_vector(7 DOWNTO 0);
SIGNAL C_digit1, C_digit2 : std_logic_vector(1 TO 7);

BEGIN
	UO: clk_generator PORT MAP(clock_25MHz, OPEN, OPEN, clk, OPEN, OPEN, OPEN, OPEN);
	
	U1: cpu PORT MAP(clk, resetN, input_comp, C_outcpu);
	U2: output PORT MAP(C_outcpu, C_digit1, C_digit2);
	
	digit1_comp <= C_digit1 & '1' WHEN C_outcpu < "01100100" ELSE C_digit1 & '0';
	digit2_comp <= C_digit2 & '1';
	resetN <= NOT reset;
END structure;
	
	