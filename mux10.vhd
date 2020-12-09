LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY MUX10 IS
    PORT (
        a0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        a1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        sel : IN STD_LOGIC;
        b : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
    );
END MUX10;
ARCHITECTURE rtl OF MUX10 IS
BEGIN
    PROCESS (a0, a1, sel)
    BEGIN
        IF sel = '0' THEN
            b <= a0;
        ELSE
            b <= a1;
        END IF;
    END PROCESS;
END rtl;
