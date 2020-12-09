-- Button Press Synchronizer para keys que são ativas baixas (ou seja, quando pressionadas vao para nivel baixo)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ButtonSync IS
	PORT (
		KEY0, KEY1, CLK : IN STD_LOGIC;
		BTN0, BTN1 : OUT STD_LOGIC
	);
END ButtonSync;
ARCHITECTURE ButtonSyncImpl OF ButtonSync IS
	TYPE STATES IS (EsperaApertar, SaidaAtiva, EsperaSoltar);
	SIGNAL btn0state, btn1state : STATES := EsperaApertar;
	SIGNAL btn0next, btn1next : STATES := EsperaApertar;
BEGIN

	PROCESS (clk)
	BEGIN
		IF clk'event AND clk = '1' THEN -- Resposta na transicao positiva do clock
			btn0state <= btn0next;
			btn1state <= btn1next;
		END IF;
	END PROCESS;

	PROCESS (key0, btn0state)
	BEGIN
		CASE btn0state IS
			WHEN EsperaApertar =>
				IF key0 = '0' THEN
					btn0next <= SaidaAtiva;
				ELSE
					btn0next <= EsperaApertar;
				END IF;
				btn0 <= '1';
			WHEN SaidaAtiva =>
				IF key0 = '0' THEN
					btn0next <= EsperaSoltar;
				ELSE
					btn0next <= EsperaApertar;
				END IF;
				btn0 <= '0';
			WHEN EsperaSoltar =>
				IF key0 = '0' THEN
					btn0next <= EsperaSoltar;
				ELSE
					btn0next <= EsperaApertar;
				END IF;
				btn0 <= '1';
		END CASE;
	END PROCESS;

	PROCESS (key1, btn1state)
	BEGIN
		CASE btn1state IS
			WHEN EsperaApertar =>
				IF key1 = '0' THEN
					btn1next <= SaidaAtiva;
				ELSE
					btn1next <= EsperaApertar;
				END IF;
				btn1 <= '1';
			WHEN SaidaAtiva =>
				IF key1 = '0' THEN
					btn1next <= EsperaSoltar;
				ELSE
					btn1next <= EsperaApertar;
				END IF;
				btn1 <= '0';
			WHEN EsperaSoltar =>
				IF key1 = '0' THEN
					btn1next <= EsperaSoltar;
				ELSE
					btn1next <= EsperaApertar;
				END IF;
				btn1 <= '1';
		END CASE;
	END PROCESS;

END ButtonSyncImpl;
