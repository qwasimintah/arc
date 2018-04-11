
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 12:18:59 PM CEST
--      
--      LeonardoSpectrum Level 3, 2015a.6
-- 
library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

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

library c35_CORELIB;
use c35_CORELIB.vcomponents.all;

architecture ControllerGray of Oven_ctrl is
   signal Half_EXMPLR, Start_count_EXMPLR, Stop_count_EXMPLR, 
      Finished_EXMPLR, state_1, state_0, state_2, nx413, nx12, nx18, nx24, 
      nx32, nx34, nx40, nx66, nx94, nx110, nx118, nx144, nx422, nx424, nx427, 
      nx430, nx433, nx437, nx441, nx444, nx447, nx450, nx453, nx455, nx458, 
      nx461, nx463, nx466, nx468, nx470, nx473, nx476, nx478, nx481, nx484, 
      nx487, nx490: std_logic ;

-- PSL default clock is (clk'event and clk='1');
-- PSL property prop1 is
-- always((state_0 ='0' and state_1='0' and state_2='0') -> ((state_0/='0' or state_1/='1' or state_2/='1') until (s30='1' or s60 = '1' or s120 = '1')));


-- PSL property prop2 is
-- always(((state_0='1' and state_1='0' and state_2='1') and Door_open='1') -> ((next! (state_0/='1' or state_1/='0' or state_2/='1') and (Start='1' before! (state_0='1' and state_1='0' and state_2='1')))) );


-- PSL property prop3 is
-- always(((state_0 = '0' and state_1='1' and state_2='1') and Start='1') -> In_light='1' until (((state_0 = '1' and state_1='1' and state_2='1') and Door_open='0') or Timeout='1'));

-- PSL property prop4 is
-- always(
--    {((state_0 = '0' and state_1='1' and state_2='1') and Start='1');
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
   Half <= Half_EXMPLR ;
   Finished <= Finished_EXMPLR ;
   Start_count <= Start_count_EXMPLR ;
   Stop_count <= Stop_count_EXMPLR ;
   ix155 : NOR40 port map ( Q=>Finished_EXMPLR, A=>nx422, B=>nx424, C=>nx441, 
      D=>state_1);
   ix423 : CLKIN1 port map ( Q=>nx422, A=>Timeout);
   ix111 : OAI2111 port map ( Q=>nx110, A=>nx427, B=>nx458, C=>nx461, D=>
      nx468);
   ix145 : OAI2111 port map ( Q=>nx144, A=>nx427, B=>nx430, C=>nx447, D=>
      nx455);
   ix431 : AOI221 port map ( Q=>nx430, A=>state_0, B=>state_2, C=>nx444, D=>
      nx40);
   reg_state_0 : DFC1 port map ( Q=>state_0, QN=>nx424, C=>clk, D=>nx110, RN
      =>nx433);
   ix434 : CLKIN1 port map ( Q=>nx433, A=>reset);
   ix31 : NAND21 port map ( Q=>nx413, A=>nx437, B=>nx12);
   ix438 : AOI311 port map ( Q=>nx437, A=>nx424, B=>Time_set, C=>state_1, D
      =>nx24);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx427, C=>clk, D=>nx144, RN
      =>nx433);
   ix25 : AOI211 port map ( Q=>nx24, A=>nx427, B=>Door_open, C=>nx441);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx441, C=>clk, D=>nx413, RN
      =>nx433);
   ix13 : NAND21 port map ( Q=>nx12, A=>state_0, B=>state_2);
   ix445 : NAND41 port map ( Q=>nx444, A=>Start, B=>state_2, C=>state_1, D=>
      nx424);
   ix41 : NAND21 port map ( Q=>nx40, A=>state_0, B=>Full_power);
   ix448 : NOR21 port map ( Q=>nx447, A=>Half_EXMPLR, B=>Stop_count_EXMPLR);
   ix99 : NOR31 port map ( Q=>Half_EXMPLR, A=>nx450, B=>state_1, C=>state_2
   );
   ix451 : CLKIN1 port map ( Q=>nx450, A=>Half_power);
   ix141 : NOR40 port map ( Q=>Stop_count_EXMPLR, A=>nx12, B=>state_1, C=>
      Timeout, D=>nx453);
   ix454 : CLKIN1 port map ( Q=>nx453, A=>Door_open);
   ix456 : OAI311 port map ( Q=>nx455, A=>s60, B=>s120, C=>s30, D=>nx118);
   ix119 : NOR31 port map ( Q=>nx118, A=>nx424, B=>state_1, C=>state_2);
   ix459 : AOI311 port map ( Q=>nx458, A=>nx441, B=>state_0, C=>Full_power, 
      D=>nx34);
   ix35 : NOR31 port map ( Q=>nx34, A=>nx424, B=>nx453, C=>nx441);
   ix462 : AOI2111 port map ( Q=>nx461, A=>nx422, B=>nx463, C=>Half_EXMPLR, 
      D=>nx94);
   ix464 : NOR31 port map ( Q=>nx463, A=>nx424, B=>nx441, C=>state_1);
   ix95 : OAI211 port map ( Q=>nx94, A=>state_2, B=>nx466, C=>nx444);
   ix467 : NAND21 port map ( Q=>nx466, A=>Door_open, B=>nx413);
   ix469 : AOI311 port map ( Q=>nx468, A=>nx470, B=>Full_power, C=>nx424, D
      =>nx66);
   ix471 : NOR21 port map ( Q=>nx470, A=>state_1, B=>state_2);
   ix67 : NOR40 port map ( Q=>nx66, A=>s30, B=>s120, C=>s60, D=>nx473);
   ix474 : NAND21 port map ( Q=>nx473, A=>state_0, B=>nx441);
   ix167 : OAI211 port map ( Q=>In_light, A=>Finished_EXMPLR, B=>nx476, C=>
      nx478);
   ix477 : OAI2111 port map ( Q=>nx476, A=>Door_open, B=>nx427, C=>state_0, 
      D=>state_2);
   ix479 : AOI211 port map ( Q=>nx478, A=>nx441, B=>nx32, C=>
      Start_count_EXMPLR);
   ix33 : NOR21 port map ( Q=>nx32, A=>nx453, B=>nx481);
   ix482 : AOI2111 port map ( Q=>nx481, A=>state_0, B=>state_2, C=>nx24, D=>
      nx18);
   ix19 : NOR21 port map ( Q=>nx18, A=>state_0, B=>nx484);
   ix485 : NAND21 port map ( Q=>nx484, A=>Time_set, B=>state_1);
   ix89 : NOR40 port map ( Q=>Start_count_EXMPLR, A=>nx487, B=>nx441, C=>
      nx427, D=>state_0);
   ix488 : CLKIN1 port map ( Q=>nx487, A=>Start);
   ix185 : OAI311 port map ( Q=>Full, A=>nx40, B=>state_2, C=>nx427, D=>
      nx490);
   ix491 : NAND31 port map ( Q=>nx490, A=>nx470, B=>Full_power, C=>nx424);

end ControllerGray ;

