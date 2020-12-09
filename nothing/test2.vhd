LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY usertop IS
    PORT (
        SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
        LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
        HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        CLK_1Hz : IN STD_LOGIC
    );
END usertop;

ARCHITECTURE arch OF usertop IS
    SIGNAL CLK_1Hz : STD_LOGIC;
BEGIN
    LEDR(0) <= CLK_1Hz;
END arch;
