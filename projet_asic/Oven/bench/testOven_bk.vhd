
library IEEE;
use IEEE.std_logic_1164.all;

entity testOven is
end testOven;

architecture test1 of testOven is
    component Oven_glob is
        port(reset, clk, Half_power, Full_power, Start, s30, s60, s120,
        Time_set, Door_open : in std_logic;
        Full, Half, In_light, Finished : out std_logic);
    end component;
    signal reset1, clk1, Half_power1, Full_power1, Start1, s301, s601, s1201, Time_set1, Door_open1, Full1, Half1, In_light1, Finished1: std_logic := '0'; 

begin

     A: Oven_glob port map(reset1, clk1, Half_power1, Full_power1, Start1, s301, s601, s1201, Time_set1, Door_open1, Full1, Half1, In_light1, Finished1);

process
	begin
		clk1<='0';
		wait for 500 ms; 
		clk1<='1';
		wait for 500 ms; 
	end process;
    reset1 <= '1' after 1000 ms, '0' after 2000 ms; 
    Full_power1 <= '1' after 3000 ms;
    s301 <= '1' after 4500 ms;
    Time_set1 <= '1' after 5500 ms;
    Start1 <= '1' after 7000 ms;
    Door_open1 <= '1' after 40000 ms;

end test1;

library LIB_OVEN;
library LIB_OVEN_BENCH;

configuration config1 of LIB_OVEN_BENCH.testOven is 
    for test1 
        for A:Oven_glob use configuration LIB_OVEN.config2;
            end for;
        end for; 
    end config1; 

