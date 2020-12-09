LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY DEC7SEG IS
    PORT (
        bin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
    );
END DEC7SEG;

ARCHITECTURE mydec OF DEC7SEG IS
BEGIN
    out_7seg <= "1000000" WHEN bin = "0000" ELSE
        "1111001" WHEN bin = "0001" ELSE
        "0100100" WHEN bin = "0010" ELSE
        "0110000" WHEN bin = "0011" ELSE
        "0011001" WHEN bin = "0100" ELSE
        "0010010" WHEN bin = "0101" ELSE
        "0000010" WHEN bin = "0110" ELSE
        "1111000" WHEN bin = "0111" ELSE
        "0000000" WHEN bin = "1000" ELSE
        "0011000" WHEN bin = "1001" ELSE
        "1111111";
END mydec;
