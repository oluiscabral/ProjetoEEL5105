LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY Comparator4 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        S : OUT STD_LOGIC
    );
END Comparator4;

ARCHITECTURE arch OF Comparator4 IS
BEGIN
    PROCESS (A)
    BEGIN
        IF A = "0100" THEN
            S <= '0';
        ELSE
            S <= '1';
        END IF;
    END PROCESS;
END arch;
