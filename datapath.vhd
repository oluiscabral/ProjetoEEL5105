LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY Datapath IS
    PORT (
        SW : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        CLK_1Hz, CLK_500Hz : IN STD_LOGIC;
        R1, R2, E1, E2, E3, E4, E5 : IN STD_LOGIC;
        sw_erro, end_game, end_time, end_round : OUT STD_LOGIC;
        LEDR : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END Datapath;

ARCHITECTURE arch OF Datapath IS

    COMPONENT REGQ4 IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT REGQ4;

    COMPONENT REGQ10 IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR (9 DOWNTO 0)
        );
    END COMPONENT REGQ10;

    COMPONENT ROM IS
        PORT (
            address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT ROM;

    COMPONENT Counter_time IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            max : OUT STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT Counter_time;

    COMPONENT Counter_round IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            max : OUT STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT Counter_round;

    COMPONENT MUX4 IS
        PORT (
            a0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            a1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            sel : IN STD_LOGIC;
            b : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT MUX4;

    COMPONENT MUX10 IS
        PORT (
            a0 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            a1 : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            sel : IN STD_LOGIC;
            b : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT MUX10;

    COMPONENT SUM10 IS
        PORT (
            A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT SUM10;

    COMPONENT Comparator10_10 IS
        PORT (
            A : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
        );
    END COMPONENT Comparator10_10;

    COMPONENT Comparator4 IS
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            S : OUT STD_LOGIC
        );
    END COMPONENT Comparator4;

    COMPONENT MUX8 IS
        PORT (
            a0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            a1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            sel : IN STD_LOGIC;
            b : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT MUX8;

    COMPONENT REGQ8 IS
        PORT (
            clk, reset, enable : IN STD_LOGIC;
            data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
        );
    END COMPONENT REGQ8;

    COMPONENT DEC7SEG IS
        PORT (
            bin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
        );
    END COMPONENT DEC7SEG;

    SIGNAL REG1_Q : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL REG2_Q : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL ROM_Q : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL Counter_time_S : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL MUX1_B : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL MUX2_B : STD_LOGIC_VECTOR (9 DOWNTO 0);
    SIGNAL COMP1_S : STD_LOGIC_VECTOR(9 DOWNTO 0);
    SIGNAL SUM1_Q : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL SUM2_Q : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL MUX3_A0 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL MUX3_A1 : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL MUX3_B : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL REG3_Q : STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL N : STD_LOGIC_VECTOR (3 DOWNTO 0);

    SIGNAL end_game_aux : STD_LOGIC;

    CONSTANT none_display : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1111111";
    CONSTANT t_display : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0000111";
    CONSTANT r_display : STD_LOGIC_VECTOR(6 DOWNTO 0) := "0101111";

    SIGNAL HEX0_aux, HEX1_aux, HEX2_aux, HEX3_aux, HEX4_aux, HEX5_aux : STD_LOGIC_VECTOR(6 DOWNTO 0);
BEGIN
    MUX3_A0 <= "0000" & SUM2_Q;
    MUX3_A1 <= "000" & end_game_aux & ("1010" - N);

    REG1 : REGQ4 PORT MAP(CLK_500Hz, R2, E2, SW(9 DOWNTO 6), REG1_Q);
    REG2 : REGQ10 PORT MAP(CLK_500Hz, R2, E1, SW(9 DOWNTO 0), REG2_Q);
    ROM_GETTER : ROM PORT MAP(REG1_Q, ROM_Q);
    CT : Counter_time PORT MAP(CLK_1HZ, R1, E1, end_time, Counter_time_S);
    MUX1 : MUX4 PORT MAP(Counter_time_S, REG1_Q, E2, MUX1_B);
    MUX2 : MUX10 PORT MAP("0000000000", ROM_Q, E5, MUX2_B);
    COMP1 : Comparator10_10 PORT MAP(ROM_Q, REG2_Q, COMP1_S);
    SUM1 : SUM10 PORT MAP(REG2_Q, SUM1_Q);
    SUM2 : SUM10 PORT MAP(COMP1_S, SUM2_Q);
    COMP2 : Comparator4 PORT MAP(SUM1_Q, sw_erro);
    COMP3 : Comparator4 PORT MAP(SUM2_Q, end_game_aux);
    MUX3 : MUX8 PORT MAP(MUX3_A0, MUX3_A1, E5, MUX3_B);
    REG3 : REGQ8 PORT MAP(CLK_500Hz, R2, E3, MUX3_B, REG3_Q);
    CR : Counter_round PORT MAP(CLK_500Hz, R2, E4, end_round, N);

    DEC1 : DEC7SEG PORT MAP(MUX1_B, HEX4_aux);
    DEC2 : DEC7SEG PORT MAP(N, HEX2);
    DEC3 : DEC7SEG PORT MAP(REG3_Q(7 DOWNTO 4), HEX1);
    DEC4 : DEC7SEG PORT MAP(REG3_Q(3 DOWNTO 0), HEX0);

    HEX5 <= t_display WHEN E1 = '1' ELSE
        none_display;
    HEX4 <= HEX4_aux WHEN E1 = '1' ELSE
        none_display;

    HEX3 <= r_display;

    end_game <= end_game_aux;
END arch;
