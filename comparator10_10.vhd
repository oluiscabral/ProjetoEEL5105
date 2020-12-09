LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Comparator10_10 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END Comparator10_10;

ARCHITECTURE arch OF Comparator10_10 IS
    SIGNAL ret : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
BEGIN
    PROCESS (A, B)
    BEGIN
        ret <= "0000000000";
        IF A(0) = '1' AND B(0) = '1' THEN
            ret(0) <= '1';
        END IF;
        IF A(1) = '1' AND B(1) = '1' THEN
            ret(1) <= '1';
        END IF;
        IF A(2) = '1' AND B(2) = '1' THEN
            ret(2) <= '1';
        END IF;
        IF A(3) = '1' AND B(3) = '1' THEN
            ret(3) <= '1';
        END IF;
        IF A(4) = '1' AND B(4) = '1' THEN
            ret(4) <= '1';
        END IF;
        IF A(5) = '1' AND B(5) = '1' THEN
            ret(5) <= '1';
        END IF;
        IF A(6) = '1' AND B(6) = '1' THEN
            ret(6) <= '1';
        END IF;
        IF A(7) = '1' AND B(7) = '1' THEN
            ret(7) <= '1';
        END IF;
        IF A(8) = '1' AND B(8) = '1' THEN
            ret(8) <= '1';
        END IF;
        IF A(9) = '1' AND B(9) = '1' THEN
            ret(9) <= '1';
        END IF;
    END PROCESS;
    S <= ret;
END arch;
