LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY REGQ8 IS
    PORT (
        clk, reset, enable : IN STD_LOGIC;
        data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
END REGQ8;
ARCHITECTURE arch OF REGQ8 IS
    SIGNAL store : STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
BEGIN
    PROCESS (clk, reset, enable, data)
    BEGIN
        IF reset = '1' THEN
            store <= "00000000";
        ELSIF enable = '1' THEN
            IF clk'EVENT AND clk = '1' THEN
                store <= data;
            END IF;
        END IF;
    END PROCESS;
    q <= store;
END arch;
