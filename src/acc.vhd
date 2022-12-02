LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY acc IS PORT (
	clk_acc	   : IN std_logic; -- clock
	wr_acc     : IN std_logic; -- read/write
	rst_acc    : IN std_logic; -- reset
	input_acc  : IN std_logic_vector(7 DOWNTO 0); -- input
	output_acc : OUT std_logic_vector(7 DOWNTO 0) -- output
); END acc;

ARCHITECTURE Behavioral OF acc IS

BEGIN
	PROCESS (clk_acc, wr_acc)
	BEGIN
		IF rst_acc = '1' THEN
			output_acc <= "00000000";
		ELSIF rising_edge(clk_acc) THEN
			IF wr_acc = '1' THEN
				output_acc <= input_acc;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
		