
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 11:34:14 AM CEST
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

architecture ControllerBin of Oven_ctrl is
   signal Full_EXMPLR, Finished_EXMPLR, state_0, state_1, state_2, nx2, nx18, 
      nx20, nx56, nx66, nx404, nx86, nx110, nx114, nx405, nx136, nx415, 
      nx418, nx420, nx424, nx429, nx431, nx433, nx440, nx442, nx445, nx447, 
      nx450, nx452, nx455, nx458, nx460, nx463, nx465, nx469, nx471, nx476: 
   std_logic ;

-- PSL default clock is (clk'event and clk='1');
-- PSL property prop1 is
-- always((state_0 ='0' and state_1='0' and state_2='0') -> ((state_0/='0' or state_1/='0' or state_2/='1') until (s30='1' or s60 = '1' or s120 = '1')));


-- PSL property prop2 is
-- always(((state_0='0' and state_1='1' and state_2='1') and Door_open='1') -> ((next! (state_0/='0' or state_1/='1' or state_2/='1') and (Start='1' before! (state_0='0' and state_1='1' and state_2='1')))) );


-- PSL property prop3 is
-- always(((state_0 = '0' and state_1='0' and state_2='1') and Start='1') -> In_light='1' until (((state_0 = '1' and state_1='0' and state_2='1') and Door_open='0') or Timeout='1'));

-- PSL property prop4 is
-- always(
--    {((state_0 = '0' and state_1='0' and state_2='1') and Start='1');
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
   Full <= Full_EXMPLR ;
   Finished <= Finished_EXMPLR ;
   ix87 : NAND41 port map ( Q=>nx86, A=>nx418, B=>nx450, C=>nx465, D=>nx471
   );
   ix419 : NAND31 port map ( Q=>nx418, A=>nx420, B=>Start, C=>state_2);
   ix421 : NOR21 port map ( Q=>nx420, A=>state_0, B=>state_1);
   ix137 : OAI2111 port map ( Q=>nx136, A=>nx424, B=>nx445, C=>nx450, D=>
      nx455);
   ix425 : AOI311 port map ( Q=>nx424, A=>nx2, B=>Time_set, C=>state_0, D=>
      nx18);
   ix430 : NAND21 port map ( Q=>nx429, A=>nx431, B=>state_1);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx431, C=>clk, D=>nx20, RN
      =>nx433);
   ix434 : CLKIN1 port map ( Q=>nx433, A=>reset);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx415, C=>clk, D=>nx86, RN
      =>nx433);
   ix441 : CLKIN1 port map ( Q=>nx440, A=>Door_open);
   reg_state_0 : DFC1 port map ( Q=>state_0, QN=>nx442, C=>clk, D=>nx136, RN
      =>nx433);
   ix19 : AOI311 port map ( Q=>nx18, A=>state_1, B=>Door_open, C=>state_0, D
      =>nx431);
   ix446 : AOI221 port map ( Q=>nx445, A=>nx447, B=>state_0, C=>Door_open, D
      =>nx404);
   ix451 : NAND21 port map ( Q=>nx450, A=>Timeout, B=>nx452);
   ix453 : NOR21 port map ( Q=>nx452, A=>nx66, B=>state_0);
   ix67 : NAND21 port map ( Q=>nx66, A=>state_1, B=>state_2);
   ix456 : AOI311 port map ( Q=>nx455, A=>nx114, B=>nx424, C=>nx2, D=>nx110
   );
   ix115 : NAND31 port map ( Q=>nx114, A=>nx442, B=>nx458, C=>nx460);
   ix459 : CLKIN1 port map ( Q=>nx458, A=>Full_power);
   ix461 : NOR31 port map ( Q=>nx460, A=>s60, B=>s120, C=>s30);
   ix111 : NOR31 port map ( Q=>nx110, A=>nx463, B=>Half_power, C=>state_2);
   ix464 : AOI221 port map ( Q=>nx463, A=>Full_power, B=>nx420, C=>state_0, 
      D=>nx424);
   ix466 : AOI221 port map ( Q=>nx465, A=>nx440, B=>nx447, C=>nx424, D=>nx56
   );
   ix57 : OAI221 port map ( Q=>nx56, A=>Full_EXMPLR, B=>nx429, C=>nx460, D=>
      nx469);
   ix51 : NOR31 port map ( Q=>Full_EXMPLR, A=>state_0, B=>nx458, C=>state_2
   );
   ix470 : NAND21 port map ( Q=>nx469, A=>nx431, B=>state_0);
   ix472 : NAND31 port map ( Q=>nx471, A=>nx415, B=>Half_power, C=>nx431);
   ix155 : NOR40 port map ( Q=>Stop_count, A=>nx66, B=>state_0, C=>Timeout, 
      D=>nx440);
   ix169 : OAI2111 port map ( Q=>In_light, A=>nx405, B=>Finished_EXMPLR, C=>
      nx476, D=>nx418);
   ix477 : NAND31 port map ( Q=>nx476, A=>nx20, B=>Door_open, C=>state_0);
   ix143 : CLKIN1 port map ( Q=>nx405, A=>nx452);
   ix93 : CLKIN1 port map ( Q=>nx404, A=>nx420);
   ix448 : CLKIN1 port map ( Q=>nx447, A=>nx66);
   ix21 : CLKIN1 port map ( Q=>nx20, A=>nx424);
   ix3 : CLKIN1 port map ( Q=>nx2, A=>nx429);
   ix147 : CLKIN1 port map ( Q=>Finished_EXMPLR, A=>nx450);
   ix83 : CLKIN1 port map ( Q=>Start_count, A=>nx418);
   ix33 : CLKIN1 port map ( Q=>Half, A=>nx471);
end ControllerBin ;

