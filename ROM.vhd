-- Armazena as opções das sequências, dependendo no valor que for escolhido, será escolhida uma sequência aleatória, que deve ser preenchida pelo aluno

-----------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
------------------------------------
ENTITY ROM IS
	PORT (
		address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		data : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY;

ARCHITECTURE Rom_Arch OF ROM IS
	TYPE memory IS ARRAY (00 TO 15) OF STD_LOGIC_VECTOR(9 DOWNTO 0);
	CONSTANT my_Rom : memory := (
		00 => "0001010101",
		01 => "1001101000",
		02 => "0111001000",
		03 => "1111000000",
		04 => "1101100000",
		05 => "0101101000",
		06 => "1000001101",
		07 => "1100100010",
		08 => "0001100101",
		09 => "0100111000",
		10 => "1010010010",
		11 => "1000000111",
		12 => "0011100100",
		13 => "1010100100",
		14 => "1100001010",
		15 => "1010010001");
BEGIN
	PROCESS (address)
	BEGIN
		CASE address IS
			WHEN "0000" => data <= my_rom(00);
			WHEN "0001" => data <= my_rom(01);
			WHEN "0010" => data <= my_rom(02);
			WHEN "0011" => data <= my_rom(03);
			WHEN "0100" => data <= my_rom(04);
			WHEN "0101" => data <= my_rom(05);
			WHEN "0110" => data <= my_rom(06);
			WHEN "0111" => data <= my_rom(07);
			WHEN "1000" => data <= my_rom(08);
			WHEN "1001" => data <= my_rom(09);
			WHEN "1010" => data <= my_rom(10);
			WHEN "1011" => data <= my_rom(11);
			WHEN "1100" => data <= my_rom(12);
			WHEN "1101" => data <= my_rom(13);
			WHEN "1110" => data <= my_rom(14);
			WHEN "1111" => data <= my_rom(15);
			WHEN OTHERS => data <= "0000001111";
		END CASE;
	END PROCESS;
END ARCHITECTURE Rom_Arch;
