
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
     B: Oven_glob port map(reset1, clk1, Half_power1, Full_power1, Start1, s301, s601, s1201, Time_set1, Door_open1, Full1, Half1, In_light1, Finished1);

process
	begin
		clk1<='0';
		wait for 500 ms; 
		clk1<='1';
		wait for 500 ms; 
	end process;
    reset1 <= '1' after 1000 ms, '0' after 2000 ms; 
    Half_power1 <= '1' after 50  sec, '0' after 60 sec, '1' after 190  sec, '0' after 200 sec;
    Full_power1 <= '1' after 3 sec, '0' after 4 sec, '1' after 200 sec, '0' after 210 sec;
    s301 <= '1' after 4.5 sec, '0' after 40 sec, '1' after 220 sec;
    s601 <= '1' after 65  sec, '0' after 180 sec;
    Start1 <= '1' after 7 sec, '0' after 8  sec,  '1' after 100 sec, '0' after 110 sec, '1' after 240 sec;
    Time_set1 <= '1' after 5.5 sec,  '0' after 6.5 sec, '1' after 80  sec, '0' after 90  sec, '1' after 230  sec;
    Door_open1 <= '1' after 42 sec, '0' after 50 sec,  '1' after 80  sec, '0' after 90 sec, '1' after 180  sec, '0' after 190 sec, '1' after 300  sec;

    --Half_power2 <= '1' after 50  sec, '0' after 60 sec, '1' after 190  sec, '0' after 200 sec;
    --Full_power2 <= '1' after 3 sec, '0' after 4 sec, '1' after 200 sec, '0' after 210 sec;
    --s302 <= '1' after 4.5 sec, '0' after 40 sec, '1' after 220 sec;
    --s602 <= '1' after 65  sec, '0' after 180 sec;
    --Start2 <= '1' after 7 sec, '0' after 8  sec,  '1' after 100 sec, '0' after 110 sec, '1' after 240 sec;
    --Time_set2 <= '1' after 5.5 sec,  '0' after 6.5 sec, '1' after 80  sec, '0' after 90  sec, '1' after 230  sec;
    --Door_open2 <= '1' after 42 sec, '0' after 50 sec,  '1' after 80  sec, '0' after 90 sec, '1' after 180  sec, '0' after 190 sec, '1' after 300  sec;


end test1;

library LIB_OVEN;
library LIB_OVEN_BENCH;

configuration config1 of LIB_OVEN_BENCH.testOven is 
    for test1 
        for A:Oven_glob use configuration LIB_OVEN.config2;
            end for;
        for B:Oven_glob use configuration LIB_OVEN.config3;
            end for;
        end for; 
    end config1; 

