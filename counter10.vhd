LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Counter_round IS
    PORT (
        clk, reset, enable : IN STD_LOGIC;
        max : OUT STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END Counter_round;

ARCHITECTURE rtl OF Counter_round IS
    SIGNAL store : STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
BEGIN
    PROCESS (clk, reset, enable)
    BEGIN
        IF reset = '1' THEN
            store <= "0000";
        ELSIF enable = '1' THEN
            IF clk'EVENT AND clk = '1' THEN
                store <= store + '1';
            END IF;
        END IF;
    END PROCESS;
    max <= '1' WHEN store > "1001" ELSE
        '0';
    S <= store;
END rtl;
