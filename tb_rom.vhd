LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_EEPROM IS
END tb_EEPROM;

ARCHITECTURE testeEEPROM OF tb_EEPROM IS

	COMPONENT EEPROM IS
		GENERIC (
			ADDR_LENGHT : NATURAL := 5;
			R_LENGHT : NATURAL := 16;
			NUM_OF_REGS : NATURAL := 32
		);
		PORT (
			clk : IN STD_LOGIC;
			wr : IN STD_LOGIC;
			addr : IN STD_LOGIC_VECTOR (ADDR_LENGHT - 1 DOWNTO 0);
			datain : IN STD_LOGIC_VECTOR (R_LENGHT - 1 DOWNTO 0);
			dataout : OUT STD_LOGIC_VECTOR (R_LENGHT - 1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL CLK_50MHz : STD_LOGIC := '0';
	SIGNAL WR : STD_LOGIC := '0';
	SIGNAL ADDR : STD_LOGIC_VECTOR (4 DOWNTO 0);
	SIGNAL DATAIN, DATAOUT : STD_LOGIC_VECTOR (15 DOWNTO 0);
	-- Clock period definitions
	CONSTANT PERIOD : TIME := 10 ns;
	CONSTANT DUTY_CYCLE : real := 0.5;
	CONSTANT OFFSET : TIME := 5 ns;

BEGIN
	instancia_EEPROM : EEPROM PORT MAP(
		clk => CLK_50MHz, wr => WR,
		addr => ADDR, datain => DATAIN, dataout => DATAOUT);

	clock_manager : PROCESS -- clock process for clock
	BEGIN
		WAIT FOR OFFSET;
		CLOCK_LOOP : LOOP
			CLK_50MHz <= '0';
			WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
			CLK_50MHz <= '1';
			WAIT FOR (PERIOD * DUTY_CYCLE);
		END LOOP CLOCK_LOOP;
	END PROCESS clock_manager;

	WR <= '1', '1' AFTER 50 ns, '0' AFTER 100 ns, '0' AFTER 200 ns;
	ADDR <= STD_LOGIC_VECTOR(to_unsigned(0, 5)),
		STD_LOGIC_VECTOR(to_unsigned(1, 5)) AFTER 25 ns,
		STD_LOGIC_VECTOR(to_unsigned(2, 5)) AFTER 50 ns,
		STD_LOGIC_VECTOR(to_unsigned(3, 5)) AFTER 75 ns,
		STD_LOGIC_VECTOR(to_unsigned(0, 5)) AFTER 100 ns,
		STD_LOGIC_VECTOR(to_unsigned(1, 5)) AFTER 125 ns,
		STD_LOGIC_VECTOR(to_unsigned(2, 5)) AFTER 150 ns,
		STD_LOGIC_VECTOR(to_unsigned(3, 5)) AFTER 175 ns;
	DATAIN <= STD_LOGIC_VECTOR(to_unsigned(5, 16)),
		STD_LOGIC_VECTOR(to_unsigned(10, 16)) AFTER 25 ns,
		STD_LOGIC_VECTOR(to_unsigned(15, 16)) AFTER 50 ns,
		STD_LOGIC_VECTOR(to_unsigned(20, 16)) AFTER 75 ns;

END testeEEPROM;