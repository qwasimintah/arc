
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 08:26:25 AM CEST
--      
--      LeonardoSpectrum Level 3, 2015a.6
-- 
library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder_3 is
   port (
      data : IN std_logic_vector (2 DOWNTO 0) ;
      eq : OUT std_logic_vector (7 DOWNTO 0)) ;
end decoder_3 ;

architecture INTERFACE of decoder_3 is
   component eq_3u_3u
      port (
         a : IN std_logic_vector (2 DOWNTO 0) ;
         b : IN std_logic_vector (2 DOWNTO 0) ;
         d : OUT std_logic) ;
   end component ;
   signal nx3, nx5: std_logic ;

begin
   nx3 <= '0' ;
   nx5 <= '1' ;
   ix7 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx5, b(1)=>nx5, b(0)=>nx5, d=>eq(7));
   ix9 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx5, b(1)=>nx5, b(0)=>nx3, d=>eq(6));
   ix11 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx5, b(1)=>nx3, b(0)=>nx5, d=>eq(5));
   ix13 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx5, b(1)=>nx3, b(0)=>nx3, d=>eq(4));
   ix15 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx3, b(1)=>nx5, b(0)=>nx5, d=>eq(3));
   ix17 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx3, b(1)=>nx5, b(0)=>nx3, d=>eq(2));
   ix19 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx3, b(1)=>nx3, b(0)=>nx5, d=>eq(1));
   ix21 : eq_3u_3u port map ( a(2)=>data(2), a(1)=>data(1), a(0)=>data(0), 
      b(2)=>nx3, b(1)=>nx3, b(0)=>nx3, d=>eq(0));
end INTERFACE ;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Oven_ctrl is
   port (
      reset : IN std_logic ;
      clk : IN std_logic ;
      Half_power : IN std_logic ;
      Full_power : IN std_logic ;
      Start : IN std_logic ;
      s30 : IN std_logic ;
      s60 : IN std_logic ;
      s120 : IN std_logic ;
      Time_set : IN std_logic ;
      Door_open : IN std_logic ;
      Timeout : IN std_logic ;
      Full : OUT std_logic ;
      Half : OUT std_logic ;
      In_light : OUT std_logic ;
      Finished : OUT std_logic ;
      Start_count : OUT std_logic ;
      Stop_count : OUT std_logic) ;
end Oven_ctrl ;

architecture ControllerBin of Oven_ctrl is
   component mux_8u_8u
      port (
         a : IN std_logic_vector (7 DOWNTO 0) ;
         b : IN std_logic_vector (7 DOWNTO 0) ;
         d : OUT std_logic) ;
   end component ;
   procedure DFFPC (
      constant data   : in std_logic;
      constant preset : in std_logic;
      constant clear  : in std_logic;
      signal clk      : in std_logic;
      signal q        : out std_logic)
   is begin
       if (preset = '1') then
           q <= '1' ;
       elsif (clear = '1') then
           q <= '0' ;
       elsif (clk'event and clk'last_value = '0' and clk = '1') then
           q <= data and data ;    -- takes care of q<='X' if data='Z'
       end if ;
       if ((clear/='1' or preset/='1') and clk/='0' and clk/='1') then
           q <= 'X' ;
       end if ;
   end DFFPC ;
   component select_3_3
      port (
         a : IN std_logic_vector (2 DOWNTO 0) ;
         b : IN std_logic_vector (2 DOWNTO 0) ;
         d : OUT std_logic) ;
   end component ;
   component decoder_3
      port (
         data : IN std_logic_vector (2 DOWNTO 0) ;
         eq : OUT std_logic_vector (7 DOWNTO 0)) ;
   end component ;
   signal state_2, state_1, state_0, nextstate_2, nextstate_1, nextstate_0, 
      GND, PWR, nx17, nx45, nx47, NOT_Door_open, nx80, nx105, nx138, nx140, 
      nx141, nx147, nx148, nx150, nx151, nx157, nx158, nx160, nx162, 
      Start_count_EXMPLR, nx165, nx167, nx168, nx170, NOT_Timeout, nx175, 
      nx186, nx187, nx207, nx219, nx223, nx225, nx226, nx235, NOT_nx223, 
      NOT_Time_set, NOT_Full_power, NOT_Half_power: std_logic ;
   
   signal DANGLING : std_logic_vector (0 downto 0 );

-- PSL default clock is (clk'event and clk='1');
-- PSL property prop1 is
-- always((state_0 ='0' and state_1='0' and state_2='0') -> ((state_0/='1' or state_1/='0' or state_2/='0') until (s30='1' or s60 = '1' or s120 = '1')));
-- PSL property prop2 is
-- always(((state_0='1' and state_1='1' and state_2='0') and Door_open='1') -> ((next! (state_0\='1' or state_1\='1' or state_2\='0') and (Start='1' before! (state_0='1' and state_1='1' and state_2='0')))) );
-- PSL property prop3 is
-- always(((state_0 = '1' and state_1='0' a,d state_2='0') and Start='1') -> In_light='1' until (((state_0 = '1' and state_1='0' and state_2='1') and Door_open='0') or Timeout='1'));

-- PSL property prop4 is
-- always(
--    {((state_0 = '1' and state_1='0' a,d state_2='0') and Start='1');
--     (Timeout='0' and Door_open='0')[*];
--     Timeout='1'; 
--     Door_open='0'[*];
--     Door_open='1'
--    }
--     |-> (next! (state_0 ='0' and state_1='0' and state_2='0'))
-- );

-- PSL assert prop1;
-- PSL assert prop2;
-- PSL assert prop3;
-- PSL assert prop4;


begin
   Start_count <= Start_count_EXMPLR ;
   GND <= '0' ;
   PWR <= '1' ;
   nx45 <= s30 OR s60 ;
   nx47 <= nx45 OR s120 ;
   NOT_Door_open <= NOT Door_open ;
   nx225 <= Time_set AND NOT_Door_open ;
   nx226 <= Time_set AND Door_open ;
   modgen_mux_8 : mux_8u_8u port map ( a(7)=>NOT_Door_open, a(6)=>PWR, a(5)
      =>PWR, a(4)=>PWR, a(3)=>nx223, a(2)=>GND, a(1)=>GND, a(0)=>GND, b(7)=>
      GND, b(6)=>GND, b(5)=>GND, b(4)=>GND, b(3)=>GND, b(2)=>state_2, b(1)=>
      state_1, b(0)=>state_0, d=>nextstate_2);
   modgen_mux_9 : mux_8u_8u port map ( a(7)=>NOT_Door_open, a(6)=>nx105, 
      a(5)=>GND, a(4)=>Start, a(3)=>NOT_nx223, a(2)=>NOT_Full_power, a(1)=>
      nx207, a(0)=>Half_power, b(7)=>GND, b(6)=>GND, b(5)=>GND, b(4)=>GND, 
      b(3)=>GND, b(2)=>state_2, b(1)=>state_1, b(0)=>state_0, d=>nextstate_1
   );
   modgen_mux_10 : mux_8u_8u port map ( a(7)=>NOT_Door_open, a(6)=>nx235, 
      a(5)=>Door_open, a(4)=>GND, a(3)=>nx80, a(2)=>nx219, a(1)=>
      NOT_Half_power, a(0)=>nx17, b(7)=>GND, b(6)=>GND, b(5)=>GND, b(4)=>GND, 
      b(3)=>GND, b(2)=>state_2, b(1)=>state_1, b(0)=>state_0, d=>nextstate_0
   );
   DFFPC (nextstate_2,GND,reset,clk,state_2) ;
   DFFPC (nextstate_1,GND,reset,clk,state_1) ;
   DFFPC (nextstate_0,GND,reset,clk,state_0) ;
   nx138 <= nx147 AND Full_power ;
   nx141 <= nx140 AND Full_power ;
   Full <= nx138 OR nx141 ;
   nx148 <= nx147 AND Half_power ;
   nx151 <= nx150 AND Half_power ;
   Half <= nx148 OR nx151 ;
   nx158 <= nx157 AND Door_open ;
   nx160 <= nx158 AND Time_set ;
   Start_count_EXMPLR <= nx162 AND Start ;
   nx165 <= nx160 OR Start_count_EXMPLR ;
   nx168 <= nx167 AND Door_open ;
   nx170 <= nx165 OR nx168 ;
   NOT_Timeout <= NOT Timeout ;
   nx175 <= nx186 AND NOT_Timeout ;
   In_light <= nx170 OR nx175 ;
   nx187 <= nx186 AND Door_open ;
   Stop_count <= nx187 AND NOT_Timeout ;
   Finished <= nx186 AND Timeout ;
   nx207 <= Half_power OR nx47 ;
   nx219 <= Full_power OR nx47 ;
   nx223 <= nx225 OR nx226 ;
   modgen_select_30 : select_3_3 port map ( a(2)=>nx225, a(1)=>nx226, a(0)=>
      NOT_Time_set, b(2)=>GND, b(1)=>PWR, b(0)=>PWR, d=>nx80);
   nx235 <= Timeout OR Door_open ;
   NOT_nx223 <= NOT nx223 ;
   NOT_Time_set <= NOT Time_set ;
   NOT_Full_power <= NOT Full_power ;
   NOT_Half_power <= NOT Half_power ;
   nx17 <= Full_power AND NOT_Half_power ;
   nx105 <= NOT_Door_open OR Timeout ;
   ix357 : decoder_3 port map ( data(2)=>state_2, data(1)=>state_1, data(0)
      =>state_0, eq(7)=>DANGLING(0), eq(6)=>nx186, eq(5)=>nx167, eq(4)=>
      nx162, eq(3)=>nx157, eq(2)=>nx140, eq(1)=>nx150, eq(0)=>nx147);
end ControllerBin ;

