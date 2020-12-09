LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY Comparator10_10 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END Comparator10_10;

ARCHITECTURE arch OF Comparator10_10 IS
    SIGNAL otp : STD_LOGIC_VECTOR(9 DOWNTO 0) := "0000000000";
BEGIN
    PROCESS (A, B)
    BEGIN
        otp <= "0000000000";
        IF A(0) = B(0) THEN
            otp(0) <= '1';
        END IF;
        IF A(1) = B(1) THEN
            otp(1) <= '1';
        END IF;
        IF A(2) = B(2) THEN
            otp(2) <= '1';
        END IF;
        IF A(3) = B(3) THEN
            otp(3) <= '1';
        END IF;
        IF A(4) = B(4) THEN
            otp(4) <= '1';
        END IF;
        IF A(5) = B(5) THEN
            otp(5) <= '1';
        END IF;
        IF A(6) = B(6) THEN
            otp(6) <= '1';
        END IF;
        IF A(7) = B(7) THEN
            otp(7) <= '1';
        END IF;
        IF A(8) = B(8) THEN
            otp(8) <= '1';
        END IF;
        IF A(9) = B(9) THEN
            otp(9) <= '1';
        END IF;
    END PROCESS;
    S <= otp;
END arch;
