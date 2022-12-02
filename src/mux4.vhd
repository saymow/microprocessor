LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux4 IS PORT (
	sel_mux                            : IN std_logic_vector(1 DOWNTO 0);
	in3_mux, in2_mux, in1_mux, in0_mux : IN std_logic_vector(7 DOWNTO 0);
	out_mux                            : OUT std_logic_vector(7 DOWNTO 0)
); END mux4;

ARCHITECTURE Behavioral OF mux4 IS 
BEGIN 
	PROCESS(sel_mux, in3_mux, in2_mux, in1_mux, in0_mux)
	BEGIN
		IF (sel_mux = "00") THEN
			out_mux <= in0_mux;
		ELSIF (sel_mux = "01") THEN
			out_mux <= in1_mux;
		ELSIF (sel_mux = "10") THEN
			out_mux <= in2_mux;
		ELSE
			out_mux <= in3_mux;
		END IF;
	END PROCESS;
END Behavioral;
