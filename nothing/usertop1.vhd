LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY usertop IS
    PORT (
        SW : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
        KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        CLK_500Hz : IN STD_LOGIC;
        LEDR : OUT STD_LOGIC_VECTOR (17 DOWNTO 0)
    );
END usertop;

ARCHITECTURE arch OF usertop IS

BEGIN
END arch;
