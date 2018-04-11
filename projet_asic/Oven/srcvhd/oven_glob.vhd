
-- Counter for the Oven project

library IEEE;
use IEEE.std_logic_1164.all;

entity Oven_glob is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120,
            Time_set, Door_open : in std_logic;
            Full, Half, In_light, Finished : out std_logic);
end Oven_glob;

architecture Complete of Oven_glob is
signal Start_count, Stop_count, Timeout : std_logic := '0'; 
    component Oven_ctrl is
     port(reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout : in std_logic;
            Full, Half, In_light, Finished,
            Start_count, Stop_count: out std_logic);
    end component;

    component Oven_count is
    port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         aboveth: out std_logic);
    end component;

    begin
        A : Oven_ctrl port map(reset, clk, Half_power, Full_power, Start, s30, s60, s120, Time_set, Door_open, Timeout, Full, Half, In_light, Finished, Start_count, Stop_count);
        B : Oven_count port map(reset, clk, Start_count, Stop_count, s30, s60, s120, Timeout);
    
end Complete;

library LIB_OVEN;

configuration config2 of LIB_OVEN.Oven_glob is 
    for Complete 
        for A: Oven_ctrl use entity LIB_OVEN.Oven_ctrl(Controller);
            end for;
        for B: Oven_count use entity LIB_OVEN.Oven_count(Impl);
            end for;
        end for; 
    end config2;

library LIB_OVEN;

configuration config3 of LIB_OVEN.Oven_glob is 
    for Complete 
        for A: Oven_ctrl use entity LIB_OVEN.Oven_ctrl(ControllerOneh);
            end for;
        for B: Oven_count use entity LIB_OVEN.Oven_count(Impl);
            end for;
        end for; 
    end config3;
