LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY REGQ10 IS
    PORT (
        clk, reset, enable : IN STD_LOGIC;
        data : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
    );
END REGQ10;
ARCHITECTURE arch OF REGQ10 IS
    SIGNAL store : STD_LOGIC_VECTOR (9 DOWNTO 0) := "0000000000";
BEGIN
    PROCESS (clk, reset, enable, data)
    BEGIN
        IF reset = '1' THEN
            store <= "0000000000";
        ELSIF enable = '1' THEN
            IF clk'EVENT AND clk = '1' THEN
                store <= data;
            END IF;
        END IF;
    END PROCESS;
    q <= store;
END arch;
