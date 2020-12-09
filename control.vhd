LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Control IS
    PORT (
        enter : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        clock : IN STD_LOGIC;
        sw_erro, end_game, end_time, end_round : IN STD_LOGIC;
        R1, R2, E1, E2, E3, E4, E5 : OUT STD_LOGIC
    );
END Control;

ARCHITECTURE arch OF Control IS
    TYPE State_type IS (Init, Setup, Play, Count_Round, Check, Wait_s, Result); -- Define the states
    SIGNAL State : State_Type := Init;
    SIGNAL state_value : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL r1_aux, r2_aux : STD_LOGIC := '0';
BEGIN
    PROCESS (enter, reset, clock)
    BEGIN
        IF r1_aux = '1' THEN
            r1_aux <= '0';
        END IF;
        IF r2_aux = '1' THEN
            r2_aux <= '0';
        END IF;

        CASE State IS
            WHEN Setup =>
                state_value <= "01000";

            WHEN Play =>
                state_value <= "10000";

            WHEN Count_Round =>
                state_value <= "00010";

            WHEN Check =>
                state_value <= "00100";

            WHEN Result =>
                state_value <= "00101";

            WHEN Wait_s =>
                state_value <= "00000";
                r1_aux <= '1';

            WHEN OTHERS =>
                state_value <= "00000";
        END CASE;

        IF (reset = '0') THEN
            State <= Init;
            r2_aux <= '1';
            r1_aux <= '1';
        ELSIF (clock'event AND clock = '1') THEN
            CASE State IS
                WHEN Init =>
                    IF enter = '0' THEN
                        State <= Setup;
                    END IF;

                WHEN Setup =>
                    IF enter = '0' THEN
                        State <= Play;
                    END IF;

                WHEN Play =>
                    IF end_time = '1' THEN
                        State <= Result;
                    ELSIF enter = '0' THEN
                        State <= Count_Round;
                    END IF;

                WHEN Count_Round =>
                    State <= Check;

                WHEN Check =>
                    IF (sw_erro = '0' OR end_game = '1' OR end_round = '1') THEN
                        State <= Result;
                    ELSE
                        State <= Wait_s;
                    END IF;

                WHEN Wait_s =>
                    IF enter = '0' THEN
                        State <= Play;
                    END IF;

                WHEN Result =>
                    IF enter = '0' THEN
                        State <= Init;
                        r1_aux <= '1';
                        r2_aux <= '1';
                    END IF;

                WHEN OTHERS =>
                    State <= Init;
            END CASE;
        END IF;
    END PROCESS;
    R1 <= r1_aux;
    R2 <= r2_aux;
    (E1, E2, E3, E4, E5) <= state_value;
END arch;
