
-- Counter for the Oven project

library IEEE;
use IEEE.std_logic_1164.all;

entity Oven_glob is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open : in std_logic;
            Full, Half, In_light, Finished : out std_logic;
            LEDR : out std_logic_vector(7 downto 0); -- for red leds
            LEDG : out std_logic_vector(3 downto 0); -- for green leds
            seg_val_hex0: out INTEGER range 0 to 127; -- to display the state
            seg_val_hex1: out INTEGER range 0 to 127; -- to display the counter
            seg_val_hex2: out INTEGER range 0 to 127; -- to display the counter
            seg_val_hex3: out INTEGER range 0 to 127 -- to display the counter
        );
end Oven_glob;

architecture Complete of Oven_glob is
signal Start_count, Stop_count, Timeout, ck_1Hz : std_logic := '0'; 
    component Oven_ctrl is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout : in std_logic;
            Full, Half, In_light, Finished,
            Start_count, Stop_count: out std_logic;
				LEDR : out std_logic_vector(7 downto 0); -- for red leds
            LEDG : out std_logic_vector(3 downto 0); -- for green leds
            seg_val_hex0: out INTEGER range 0 to 127 -- to display the state
				);
    end component;

    component Oven_count is
    port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         seg_val_hex1: out INTEGER range 0 to 127; -- to display the counter
         seg_val_hex2: out INTEGER range 0 to 127; -- to display the counter
         seg_val_hex3: out INTEGER range 0 to 127; -- to display the counter
			aboveth: out std_logic
			);
    end component;

    attribute chip_pin : string;
    attribute chip_pin of reset : signal is "R22"; -- rightmost button
    attribute chip_pin of clk : signal is "L1"; -- 50 MHz internal quartz
     -- assignment of inputs to switches (here from left to right) : 
    attribute chip_pin of Half_power: signal is "M2"; -- SW 7
    attribute chip_pin of Full_power : signal is "U11"; -- SW 6
    attribute chip_pin of Start : signal is "U12"; -- SW 5
    attribute chip_pin of s30 : signal is "W12"; -- SW 4
    attribute chip_pin of s60 : signal is "V12"; -- SW 3
    attribute chip_pin of s120 : signal is "M22"; -- SW 2
    attribute chip_pin of Time_set : signal is "L21"; -- SW 1
    attribute chip_pin of Door_open : signal is "L22"; -- SW 0
          -- 7-segment displays : 
    attribute chip_pin of seg_val_hex0 : signal is "J2,J1,H2,H1,F2,F1,E2"; 
    attribute chip_pin of seg_val_hex1 : signal is "E1,H6,H5,H4,G3,D2,D1"; 
    attribute chip_pin of seg_val_hex2 : signal is "G5,G6,C2,C1,E3,E4,D3"; 
    attribute chip_pin of seg_val_hex3 : signal is "F4,D5,D6,J4,L8,F3,D4"; 
           -- idem for seg_val_hex1 to seg_val_hex3, to be completed (see below)
           -- assignment of outputs LEDR and LEDG to leds (here from left to right) :
    attribute chip_pin of LEDR : signal is 
        "U18,Y18,V19,T18,Y19,U19,R19,R20";
    attribute chip_pin of LEDG : signal is 
        "V21,V22,U21,U22";

begin
     -- Clock divider
    PROCESS (clk)
        VARIABLE cnt : INTEGER RANGE 0 TO 67108863;
        CONSTANT verrou_t : INTEGER := 50000000;
    BEGIN
        IF (clk'EVENT AND clk = '1') THEN
            IF (reset = '0') OR (cnt = verrou_t ) THEN cnt := 0;
            ELSE cnt := cnt + 1;
            END IF;
        END IF;
        IF (cnt = verrou_t ) THEN ck_1Hz <= '1'; -- ck_1Hz local signal 
        ELSE ck_1Hz <= '0';
        END IF;
    END PROCESS;


    A : Oven_ctrl port map(reset, ck_1Hz, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout, Full, Half, In_light, Finished, Start_count, Stop_count, LEDR, LEDG, seg_val_hex0);
    B : Oven_count port map(reset, ck_1Hz, Start_count, Stop_count, s30, s60, s120, seg_val_hex1, seg_val_hex2, seg_val_hex3, Timeout);

end Complete;

