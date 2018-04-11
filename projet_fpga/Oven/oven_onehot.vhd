
-- 
-- Definition of  Oven_ctrl
-- 
--      Wed 04 Apr 2018 08:47:14 AM CEST
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
   signal Full_EXMPLR, Stop_count_EXMPLR, Half_EXMPLR, state_1, state_2, nx2, 
      nx12, state_0, state_7, state_6, state_4, state_5, nx757, nx34, 
      state_3, nx56, nx74, nx90, nx102, nx110, nx132, nx765, nx768, nx772, 
      nx774, nx776, nx780, nx782, nx786, nx790, nx792, nx794, nx799, nx802, 
      nx807, nx809, nx812, nx814, nx818, nx820, nx825, nx833: std_logic ;

begin
   Full <= Full_EXMPLR ;
   Half <= Half_EXMPLR ;
   Stop_count <= Stop_count_EXMPLR ;
   ix111 : OAI311 port map ( Q=>nx110, A=>nx765, B=>Half_power, C=>
      Full_power, D=>nx768);
   ix769 : NAND21 port map ( Q=>nx768, A=>Door_open, B=>state_7);
   ix103 : OAI211 port map ( Q=>nx102, A=>Door_open, B=>nx772, C=>nx776);
   reg_state_7 : DFC1 port map ( Q=>state_7, QN=>nx772, C=>clk, D=>nx102, RN
      =>nx774);
   ix775 : CLKIN1 port map ( Q=>nx774, A=>reset);
   ix777 : NAND21 port map ( Q=>nx776, A=>Timeout, B=>state_6);
   ix91 : OAI311 port map ( Q=>nx90, A=>nx780, B=>Timeout, C=>Door_open, D=>
      nx782);
   reg_state_6 : DFC1 port map ( Q=>state_6, QN=>nx780, C=>clk, D=>nx90, RN
      =>nx774);
   ix783 : NAND21 port map ( Q=>nx782, A=>Start, B=>state_4);
   ix75 : OAI221 port map ( Q=>nx74, A=>Door_open, B=>nx786, C=>Start, D=>
      nx825);
   ix787 : AOI211 port map ( Q=>nx786, A=>Time_set, B=>state_3, C=>state_5);
   ix57 : OAI221 port map ( Q=>nx56, A=>nx790, B=>nx792, C=>Time_set, D=>
      nx814);
   ix791 : NOR31 port map ( Q=>nx790, A=>s60, B=>s120, C=>s30);
   ix793 : AOI221 port map ( Q=>nx792, A=>nx794, B=>state_2, C=>nx812, D=>
      state_1);
   ix795 : CLKIN1 port map ( Q=>nx794, A=>Full_power);
   ix13 : OAI311 port map ( Q=>nx12, A=>nx2, B=>nx799, C=>Full_EXMPLR, D=>
      nx802);
   ix3 : CLKIN1 port map ( Q=>nx2, A=>nx790);
   reg_state_2 : DFC1 port map ( Q=>state_2, QN=>nx799, C=>clk, D=>nx12, RN
      =>nx774);
   ix803 : OAI211 port map ( Q=>nx802, A=>state_0, B=>state_1, C=>Half_power
   );
   reg_state_0 : DFP1 port map ( Q=>state_0, QN=>nx765, C=>clk, D=>nx110, SN
      =>nx774);
   reg_state_1 : DFC1 port map ( Q=>state_1, QN=>OPEN, C=>clk, D=>nx132, RN
      =>nx774);
   ix133 : OAI221 port map ( Q=>nx132, A=>Half_EXMPLR, B=>nx807, C=>nx799, D
      =>nx809);
   ix808 : AOI211 port map ( Q=>nx807, A=>state_1, B=>nx790, C=>Full_EXMPLR
   );
   ix810 : OAI211 port map ( Q=>nx809, A=>state_0, B=>state_2, C=>Full_power
   );
   ix813 : CLKIN1 port map ( Q=>nx812, A=>Half_power);
   reg_state_3 : DFC1 port map ( Q=>state_3, QN=>nx814, C=>clk, D=>nx56, RN
      =>nx774);
   reg_state_5 : DFC1 port map ( Q=>state_5, QN=>OPEN, C=>clk, D=>nx34, RN=>
      nx774);
   ix35 : OAI211 port map ( Q=>nx34, A=>nx818, B=>nx786, C=>nx820);
   ix819 : CLKIN1 port map ( Q=>nx818, A=>Door_open);
   reg_state_4 : DFC1 port map ( Q=>state_4, QN=>nx825, C=>clk, D=>nx74, RN
      =>nx774);
   ix31 : NOR31 port map ( Q=>Stop_count_EXMPLR, A=>nx780, B=>Timeout, C=>
      nx818);
   ix151 : OAI2111 port map ( Q=>In_light, A=>Timeout, B=>nx780, C=>nx833, D
      =>nx782);
   ix834 : NAND21 port map ( Q=>nx833, A=>Door_open, B=>nx757);
   ix65 : CLKIN1 port map ( Q=>nx757, A=>nx786);
   ix141 : CLKIN1 port map ( Q=>Half_EXMPLR, A=>nx802);
   ix81 : CLKIN1 port map ( Q=>Start_count, A=>nx782);
   ix97 : CLKIN1 port map ( Q=>Finished, A=>nx776);
   ix821 : CLKIN1 port map ( Q=>nx820, A=>Stop_count_EXMPLR);
   ix119 : CLKIN1 port map ( Q=>Full_EXMPLR, A=>nx809);
end Controller ;

