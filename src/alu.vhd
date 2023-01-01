LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY alu IS PORT (
	sel_alu          : IN std_logic_vector(2 DOWNTO 0);
	inA_alu, inB_alu : IN std_logic_vector(7 DOWNTO 0);
	output_alu       : OUT std_logic_vector(7 DOWNTO 0)
); END alu;

ARCHITECTURE Behavior OF alu IS
BEGIN
	PROCESS(sel_alu, inA_alu, inB_alu)
	BEGIN
		CASE sel_alu IS
			WHEN "000" =>
				output_alu <= inA_alu;
			WHEN "001" =>
				output_alu <= inA_alu AND inB_alu;
			WHEN "010" =>
				output_alu <= inA_alu OR inB_alu;
			WHEN "011" =>
				output_alu <= NOT inA_alu;
			WHEN "100" =>
				output_alu <= inA_alu + inB_alu;
			WHEN "101" =>
				output_alu <= inA_alu - inB_alu;
			WHEN "110" =>
				output_alu <= inA_alu + 1;
			WHEN OTHERS =>
				output_alu <= inA_alu - 1;
		END CASE;
	END PROCESS;
END Behavior;


