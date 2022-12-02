LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY tristatebuffer IS PORT (
	E : IN std_logic;
	D : IN std_logic_vector(7 DOWNTO 0);
	Y : OUT std_logic_vector(7 DOWNTO 0)
); END tristatebuffer;

ARCHITECTURE Behavioral OF tristatebuffer IS
BEGIN
	PROCESS(E, D)
	BEGIN
		IF E = '1' THEN
			Y <= D;
		ELSE
			Y <= (OTHERS => 'Z'); 				-- we get 8 'Z' values
		END IF;
	END PROCESS;
END Behavioral;