LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY SUM10 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END SUM10;

ARCHITECTURE arch OF SUM10 IS
BEGIN
    PROCESS (A)
    BEGIN
        S <= "0000" + A(0) + A(1) + A(2) + A(3) + A(4) + A(5) + A(6) + A(7) + A(8) + A(9);
    END PROCESS;
END arch;
