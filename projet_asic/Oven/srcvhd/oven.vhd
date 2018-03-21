library ieee;
use ieee.std_logic_1164.all;

entity Oven_ctrl is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout : in std_logic;   -- ports d'entree
            Full, Half, In_light, Finished,
            Start_count, Stop_count: out std_logic);   -- ports de sortie
end Oven_ctrl;

architecture Controller of Oven_ctrl is
type States is (Idle, Full_power_on, Half_power_on, Set_time, Operation_enabled, Operation_disabled, Operating, Complete);
signal state,nextstate: States;
begin
    process(state, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout) 
    begin
        case state is
            when Idle =>
                if Half_power = '1' then nextstate <= Half_power_on;
                elsif Full_power = '1' then nextstate <= Full_power_on;
                else nextstate <= state;
                end if;
            when Full_power_on =>
                if Half_power = '1' then nextstate <= Half_power_on;
                elsif s30 = '1' or s60 = '1' or s120 = '1' then
                    nextstate <= Set_time;
                else nextstate <= state;
                end if;
            when Half_power_on =>
                if Full_power = '1' then nextstate <= Full_power_on;
                elsif s30 = '1' or s60 = '1' or s120 = '1' then
                    nextstate <= Set_time;
                else nextstate <= state;
                end if;
            when Set_time =>
                if Time_set = '1' and Door_open = '0' then nextstate <= Operation_enabled;
                elsif Time_set = '1' and Door_open = '1' then nextstate <= Operation_disabled;
                else nextstate <= state;
                end if;
            when Operation_enabled =>
                if Start = '1' then nextstate <= Operating;
                else nextstate <= state;
                end if;
            when Operation_disabled =>
                if Door_open = '0' then nextstate <= Operation_enabled;
                else nextstate <= state;
                end if;
            when Operating =>
                if Timeout = '1' then nextstate <= Complete;
                elsif Door_open = '1' then nextstate <= Operation_disabled; 
                else nextstate <= state;
                end if;
            when Complete =>
                if Door_open = '1' then nextstate <= Idle;
                else nextstate <= state;
                end if;
        end case;
    end process;


	process(reset, clk)
	begin
		if (reset='1') then state<=Idle;
		elsif (clk'event and clk='1') then
			state <= nextstate;
		end if;
	end process;
	
    process(state, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open, Timeout) 
    begin
        
        if (state = Idle and Full_power = '1') or (state = Half_power_on and Full_power = '1') then
            Full <= '1';
        else Full <= '0';
        end if;

        if (state = Idle and Half_power = '1') or (state = Full_power_on and Half_power = '1') then
            Half <= '1';
        else Half <= '0';
        end if;

        if (state = Set_time and Door_open = '1' and Time_set = '1') or (state = Operation_enabled and Start = '1') or (state = Operation_disabled and Door_open = '1') or (state = Operating and Door_open = '1' and Timeout = '0') then
            In_light <= '1';
        else In_light <= '0';
        end if;

        if state = Operation_enabled and Start = '1' then
            Start_count <= '1';
        else Start_count <= '0'; 
        end if;


        if state = Operating and Door_open = '1' and Timeout = '0'then
            Stop_count <= '1';
        else  Stop_count <= '0';
        end if;
    
        if state = Operating and  Timeout  = '1' then
            Finished <= '1';
        else Finished <= '0';
        end if;

        end process;

    end Controller;


