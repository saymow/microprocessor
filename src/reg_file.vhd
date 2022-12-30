LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;

ENTITY reg_file IS PORT (
	clk_rf    : IN std_logic; -- clock
	wr_rf     : IN std_logic; --read/write
	addr_rf   : IN std_logic_vector(2 DOWNTO 0); --address selector
	input_rf  : IN std_logic_vector(7 DOWNTO 0); --input
	output_rf : OUT std_logic_vector(7 DOWNTO 0) --outpup
); END reg_file;

ARCHITECTURE Behavioral OF reg_file IS
	SUBTYPE Reg IS std_logic_vector(7 DOWNTO 0);
	TYPE RegArr is ARRAY(0 TO 7) of reg;
	SIGNAL rf: RegArr;
	
BEGIN
	PROCESS(clk_rf, wr_rf, addr_rf)	 
	BEGIN
		IF (clk_rf'event and clk_rf = '1') THEN
			IF wr_rf = '1' THEN
				rf(conv_integer(addr_rf)) <= input_rf;
			ELSE
				output_rf <= rf(conv_integer(addr_rf));
			END IF;
		END IF;
	END PROCESS;
END Behavioral;			
	