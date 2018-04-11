library ieee;
use ieee.std_logic_1164.all;

entity Oven_ctrl is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout : in std_logic;   -- ports d'entree
            Full, Half, In_light, Finished,
            Start_count, Stop_count: out std_logic;
            LEDR : out std_logic_vector(7 downto 0); -- for red leds
            LEDG : out std_logic_vector(3 downto 0); -- for green leds
            seg_val_hex0: out INTEGER range 0 to 127 -- to display the state
        );   -- ports de sortie
end Oven_ctrl;

architecture Controller of Oven_ctrl is
type States is (Idle, Full_power_on, Half_power_on, Set_time, Operation_enabled, Operation_disabled, Operating, Complete);
signal state,nextstate: States;
-- PSL default clock is (clk'event and clk='1');
-- PSL property prop1 is
-- always(state=Idle -> (state/=Operation_enabled until (s30='1' or s60 = '1' or s120 = '1')));
-- PSL property prop2 is
-- always((state=Operating and Door_open='1') -> ((next! (state/=Operating) and (Start='1' before! (state=Operating)))) );
-- PSL property prop3 is
-- always((state=Operation_enabled and Start='1') -> In_light='1' until ((state=Operation_disabled and Door_open='0') or Timeout='1'));

-- PSL property prop4 is
-- always(
--    {(state=Operation_enabled and Start='1');
--     (Timeout='0' and Door_open='0')[*];
--     Timeout='1'; 
--     Door_open='0'[*];
--     Door_open='1'
--    }
--     |-> (next! state=Idle)
-- );

-- PSL assert prop1;
-- PSL assert prop2;
-- PSL assert prop3;
-- PSL assert prop4;
begin
    process(state, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout) 
    begin
        case state is
            when Idle =>
                seg_val_hex0 <= 2#0000001#; -- 0
                if Half_power = '1' then nextstate <= Half_power_on;
                elsif Full_power = '1' then nextstate <= Full_power_on;
                else nextstate <= state;
                end if;
            when Full_power_on =>
                seg_val_hex0 <= 2#1001111#; -- 1
                if Half_power = '1' then nextstate <= Half_power_on;
                elsif s30 = '1' or s60 = '1' or s120 = '1' then
                    nextstate <= Set_time;
                else nextstate <= state;
                end if;
            when Half_power_on =>
                seg_val_hex0 <= 2#0010010#; -- 2
                if Full_power = '1' then nextstate <= Full_power_on;
                elsif s30 = '1' or s60 = '1' or s120 = '1' then
                    nextstate <= Set_time;
                else nextstate <= state;
                end if;
            when Set_time =>
                seg_val_hex0 <= 2#0000110#; -- 3
                if Time_set = '1' and Door_open = '0' then nextstate <= Operation_enabled;
                elsif Time_set = '1' and Door_open = '1' then nextstate <= Operation_disabled;
                else nextstate <= state;
                end if;
            when Operation_enabled =>
                seg_val_hex0 <= 2#1001100#; -- 4
                if Start = '1' then nextstate <= Operating;
                else nextstate <= state;
                end if;
            when Operation_disabled =>
                seg_val_hex0 <= 2#0100100#; -- 5
                if Door_open = '0' then nextstate <= Operation_enabled;
                else nextstate <= state;
                end if;
            when Operating =>
                seg_val_hex0 <= 2#0100000#; -- 6
                if Timeout = '1' then nextstate <= Complete;
                elsif Door_open = '1' then nextstate <= Operation_disabled; 
                else nextstate <= state;
                end if;
            when Complete =>
                seg_val_hex0 <= 2#0001111#; -- 7
                if Door_open = '1' then nextstate <= Idle;
                else nextstate <= state;
                end if;
        end case;
    end process;


	process(reset, clk)
	begin
		if (reset='0') then state<=Idle;
		elsif (clk'event and clk='1') then
			state <= nextstate;
		end if;
	end process;
	
    process(state, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout) 
    begin
        
        LEDR(7) <= Half_power;
        LEDR(6) <= Full_power;
        LEDR(5) <= Start;
        LEDR(4) <= s30;
        LEDR(3) <= s60;
        LEDR(2) <= s120;
        LEDR(1) <= Time_set;
        LEDR(0) <= Door_open;

        -- unused leds
        LEDR(8) <= '0';
        LEDR(9) <= '0';

        
        LEDG(7) <= '0';
        LEDG(6) <= '0';
        LEDG(5) <= '0';
        LEDG(4) <= '0';
        LEDG(3) <= '0';
        LEDG(2) <= '0';
        LEDG(1) <= '0';
        LEDG(0) <= '0';

        if (state = Idle and Full_power = '1') or (state = Half_power_on and Full_power = '1') then
            Full <= '1';
            LEDG(7) <= '1';
        else Full <= '0';
            LEDG(7) <= '0';
        end if;

        if (state = Idle and Half_power = '1') or (state = Full_power_on and Half_power = '1') then
            Half <= '1';
            LEDG(6) <= '1';
        else Half <= '0';
            LEDG(6) <= '0';
        end if;

        if (state = Set_time and Door_open = '1' and Time_set = '1') or (state = Operation_enabled and Start = '1') or (state = Operation_disabled and Door_open = '1') or (state = Operating and Timeout = '0') then
            In_light <= '1';
            LEDG(5) <= '1';
        else In_light <= '0';
            LEDG(5) <= '0';
        end if;

        if state = Operation_enabled and Start = '1' then
            Start_count <= '1';
            LEDG(4) <= '1';
        else Start_count <= '0'; 
            LEDG(4) <= '0';
        end if;


        if state = Operating and Door_open = '1' and Timeout = '0'then
            Stop_count <= '1';
            LEDG(3) <= '1';
        else  Stop_count <= '0';
            LEDG(3) <= '0';
        end if;
    
        if state = Operating and  Timeout  = '1' then
            Finished <= '1';
            LEDG(2) <= '1';
        else Finished <= '0';
            LEDG(2) <= '0';
        end if;

        end process;

    end Controller;


