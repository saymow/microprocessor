LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY shifter IS PORT (
	sel_shift    : IN std_logic_vector(1 DOWNTO 0);
	input_shift  : IN std_logic_vector(7 DOWNTO 0);
	output_shift : OUT std_logic_vector(7 DOWNTO 0)
); END shifter;	 

ARCHITECTURE Behavioral OF shifter IS
BEGIN
	PROCESS(sel_shift, input_shift)
	BEGIN
		CASE sel_shift IS
			WHEN "00" =>  					--pass through
				output_shift <= input_shift; 
			WHEN "01" =>  					--shift right
				output_shift <= input_shift(6 DOWNTO 0) & '0';
			WHEN "10" =>					--shift left
				output_shift <= '0' & input_shift(7 DOWNTO 1);
			WHEN OTHERS =>					--rotate right 
				output_shift <= input_shift(0) & input_shift(7 DOWNTO 1);
		END CASE;
	END PROCESS;
END Behavioral;
			
			