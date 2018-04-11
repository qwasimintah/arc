
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 08:43:51 AM CEST
--      
--      LeonardoSpectrum Level 3, 2015a.6
-- 

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

architecture Controller of Oven_ctrl is
   signal Half_EXMPLR, Start_count_EXMPLR, Finished_EXMPLR, state_1, state_0, 
      state_2, nx413, nx12, nx24, nx40, nx46, nx66, nx94, nx110, nx120, 
      nx128, nx144, nx422, nx424, nx427, nx430, nx432, nx435, nx439, nx442, 
      nx446, nx448, nx450, nx456, nx458, nx461, nx463, nx466, nx470, nx472, 
      nx474, nx477, nx483, nx485, nx495: std_logic ;

begin
   Half <= Half_EXMPLR ;
   Finished <= Finished_EXMPLR ;
   Start_count <= Start_count_EXMPLR ;
   ix155 : NOR40 port map ( Q=>Finished_EXMPLR, A=>nx422, B=>nx424, C=>nx442, 
      D=>state_1);
   ix423 : CLKIN1 port map ( Q=>nx422, A=>Timeout);
   ix111 : OAI2111 port map ( Q=>nx110, A=>nx427, B=>nx463, C=>nx466, D=>
      nx474);
   ix145 : NAND31 port map ( Q=>nx144, A=>nx430, B=>nx446, C=>nx450);
   ix431 : NAND21 port map ( Q=>nx430, A=>Half_power, B=>nx432);
   ix433 : NOR21 port map ( Q=>nx432, A=>state_1, B=>state_2);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>nx427, C=>clk, D=>nx144, RN
      =>nx435);
   ix436 : CLKIN1 port map ( Q=>nx435, A=>reset);
   ix31 : NAND21 port map ( Q=>nx413, A=>nx439, B=>nx12);
   ix440 : AOI311 port map ( Q=>nx439, A=>nx424, B=>Time_set, C=>state_1, D
      =>nx24);
   ix25 : AOI211 port map ( Q=>nx24, A=>nx427, B=>Door_open, C=>nx442);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx442, C=>clk, D=>nx413, RN
      =>nx435);
   ix13 : NAND21 port map ( Q=>nx12, A=>state_0, B=>state_2);
   reg_state_0 : DFC1 port map ( Q=>state_0, QN=>nx424, C=>clk, D=>nx110, RN
      =>nx435);
   ix447 : NAND31 port map ( Q=>nx446, A=>nx448, B=>nx422, C=>Door_open);
   ix449 : NOR21 port map ( Q=>nx448, A=>nx12, B=>state_1);
   ix451 : AOI211 port map ( Q=>nx450, A=>state_1, B=>nx128, C=>nx120);
   ix129 : OAI211 port map ( Q=>nx128, A=>Start_count_EXMPLR, B=>nx456, C=>
      nx12);
   ix459 : CLKIN1 port map ( Q=>nx458, A=>Full_power);
   ix121 : NOR40 port map ( Q=>nx120, A=>nx461, B=>nx424, C=>state_1, D=>
      state_2);
   ix462 : NOR31 port map ( Q=>nx461, A=>s60, B=>s120, C=>s30);
   ix464 : AOI311 port map ( Q=>nx463, A=>state_0, B=>Door_open, C=>state_2, 
      D=>nx46);
   ix47 : NOR31 port map ( Q=>nx46, A=>state_2, B=>nx424, C=>nx458);
   ix467 : AOI2111 port map ( Q=>nx466, A=>nx422, B=>nx448, C=>Half_EXMPLR, 
      D=>nx94);
   ix99 : CLKIN1 port map ( Q=>Half_EXMPLR, A=>nx430);
   ix95 : OAI211 port map ( Q=>nx94, A=>state_2, B=>nx470, C=>nx472);
   ix471 : NAND21 port map ( Q=>nx470, A=>Door_open, B=>nx413);
   ix473 : NAND41 port map ( Q=>nx472, A=>Start, B=>state_2, C=>state_1, D=>
      nx424);
   ix475 : AOI311 port map ( Q=>nx474, A=>nx432, B=>Full_power, C=>nx424, D
      =>nx66);
   ix67 : NOR40 port map ( Q=>nx66, A=>s30, B=>s120, C=>s60, D=>nx477);
   ix478 : NAND21 port map ( Q=>nx477, A=>state_0, B=>nx442);
   ix167 : OAI211 port map ( Q=>In_light, A=>Finished_EXMPLR, B=>nx483, C=>
      nx485);
   ix484 : OAI2111 port map ( Q=>nx483, A=>Door_open, B=>nx427, C=>state_0, 
      D=>state_2);
   ix185 : OAI311 port map ( Q=>Full, A=>nx40, B=>state_2, C=>nx427, D=>
      nx495);
   ix41 : NAND21 port map ( Q=>nx40, A=>state_0, B=>Full_power);
   ix496 : NAND31 port map ( Q=>nx495, A=>nx432, B=>Full_power, C=>nx424);
   ix486 : CLKIN1 port map ( Q=>nx485, A=>nx94);
   ix457 : CLKIN1 port map ( Q=>nx456, A=>nx40);
   ix141 : CLKIN1 port map ( Q=>Stop_count, A=>nx446);
   ix89 : CLKIN1 port map ( Q=>Start_count_EXMPLR, A=>nx472);
end Controller ;

