LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY usertop IS
    PORT (
        SW : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CLK_1Hz, CLK_500Hz : IN STD_LOGIC;
        LEDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END usertop;
ARCHITECTURE arch OF usertop IS

    COMPONENT ButtonSync IS
        PORT (
            KEY0, KEY1, CLK : IN STD_LOGIC;
            BTN0, BTN1 : OUT STD_LOGIC
        );
    END COMPONENT ButtonSync;

    COMPONENT Control IS
        PORT (
            enter : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clock : IN STD_LOGIC;
            sw_erro, end_game, end_time, end_round : IN STD_LOGIC;
            R1, R2, E1, E2, E3, E4, E5 : OUT STD_LOGIC
        );
    END COMPONENT Control;

    COMPONENT Datapath IS
        PORT (
            SW : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            CLK_1HZ, CLK_500Hz : IN STD_LOGIC;
            R1, R2, E1, E2, E3, E4, E5 : IN STD_LOGIC;
            sw_erro, end_game, end_time, end_round : OUT STD_LOGIC;
            LEDR : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT Datapath;

    SIGNAL sw_erro, end_game, end_time, end_round : STD_LOGIC;
    SIGNAL R1, R2, E1, E2, E3, E4, E5 : STD_LOGIC;
    SIGNAL BTN0, BTN1 : STD_LOGIC;
BEGIN
    BSYNC : ButtonSync PORT MAP(KEY(0), KEY(1), CLK_500Hz, BTN0, BTN1);
    CTRL : Control PORT MAP(BTN1, BTN0, CLK_500Hz, sw_erro, end_game, end_time, end_round, R1, R2, E1, E2, E3, E4, E5);
    DP : Datapath PORT MAP(SW(9 DOWNTO 0), CLK_1HZ, CLK_500Hz, R1, R2, E1, E2, E3, E4, E5, sw_erro, end_game, end_time, end_round, LEDR(9 DOWNTO 0), HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

    LEDR(17 DOWNTO 7) <= R1 & R2 & E1 & E2 & E3 & E4 & E5 & sw_erro & end_game & end_time & end_round;
END arch;
