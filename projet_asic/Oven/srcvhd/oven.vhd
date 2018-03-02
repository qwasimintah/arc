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

end Controller;

