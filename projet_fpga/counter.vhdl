
-- Counter for the Oven project

library IEEE;
use IEEE.std_logic_1164.all;

entity Oven_count is
    port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         seg_val_hex1: out INTEGER range 0 to 127; -- to display the state
         seg_val_hex2: out INTEGER range 0 to 127; -- to display the state
         seg_val_hex3: out INTEGER range 0 to 127; -- to display the state
         aboveth: out std_logic);
end Oven_count;

architecture Impl of Oven_count is
type States is (idle, counting, stopped);
signal state, nextstate: States;
signal c, nextc: natural range 0 to 120;
begin
  process (state, c, start, stop, s30, s60, s120)
  begin
    case state is
       when idle =>
          if start='1' then nextstate <= counting;
                            nextc <= 1;  -- fill here
          else nextstate <= idle;
               nextc <= 0; -- fill here
          end if;
       when counting =>
          if stop = '1' then nextstate <= stopped;
                             nextc <= c; -- fill here
          elsif ((s30='1' and c >= 30) or (s60='1' and c >= 60) or 
                 (s120='1' and c >= 120)) then nextstate <= idle;
                                               nextc <= 0; -- fill here
          else nextstate <= counting;
               nextc <=  c + 1; -- fill here
          end if;
       when stopped =>
          if start='1' then nextstate <= counting;
                            nextc <= c + 1; -- fill here
          else nextstate <= stopped;
               nextc <= c; -- fill here
          end if;
    end case;
  end process; 
  process (reset, clk)
  begin
    -- if asynchronous reset
    if (reset = '0') then state <= idle;
                          c <= 0; -- fill here
    -- if rising edge
    elsif (clk'event and clk='1') then
        state <= nextstate;
        c <= nextc; -- fill here

    end if;
  end process;
  process (c)
  begin
          if c rem 10 = 0 then
            seg_val_hex1 <= 2#0000001#; -- 0
        elsif c rem 10 = 1 then
                seg_val_hex1 <= 2#1001111#; -- 1
        elsif c rem 10 = 2 then
                seg_val_hex1 <= 2#0010010#; -- 2
        elsif c rem 10 = 3 then
                seg_val_hex1 <= 2#0000110#; -- 3
        elsif c rem 10 = 4 then
                seg_val_hex1 <= 2#1001100#; -- 4
        elsif c rem 10 = 5 then
                seg_val_hex1 <= 2#0100100#; -- 5
        elsif c rem 10 = 6 then
                seg_val_hex1 <= 2#0100000#; -- 6
        elsif c rem 10 = 7 then
                seg_val_hex1 <= 2#0001111#; -- 7
        elsif c rem 10 = 8 then
                seg_val_hex1 <= 2#0000000#; -- 8
        elsif c rem 10= 9 then
                seg_val_hex1 <= 2#0000100#; -- 9
        else
                seg_val_hex1 <= 2#1111111#; -- off 
        end if;
		  if c/10 rem 10= 0 then
            seg_val_hex2 <= 2#0000001#; -- 0
        elsif c/10 rem 10= 1 then
                seg_val_hex2 <= 2#1001111#; -- 1
        elsif c/10 rem 10= 2 then
                seg_val_hex2 <= 2#0010010#; -- 2
        elsif c/10 rem 10= 3 then
                seg_val_hex2 <= 2#0000110#; -- 3
        elsif c/10 rem 10= 4 then
                seg_val_hex2 <= 2#1001100#; -- 4
        elsif c/10 rem 10= 5 then
                seg_val_hex2 <= 2#0100100#; -- 5
        elsif c/10 rem 10= 6 then
                seg_val_hex2 <= 2#0100000#; -- 6
        elsif c/10 rem 10= 7 then
                seg_val_hex2 <= 2#0001111#; -- 7
        elsif c/10 rem 10= 8 then
                seg_val_hex2 <= 2#0000000#; -- 8
        elsif c/10 rem 10= 9 then
                seg_val_hex2 <= 2#0000100#; -- 9
        else
                seg_val_hex2 <= 2#1111111#; -- off 
        end if;
  		  if c/100 = 0 then
            seg_val_hex3 <= 2#0000001#; -- 0
        elsif c/100 = 1 then
                seg_val_hex3 <= 2#1001111#; -- 1
        elsif c/100 = 2 then
                seg_val_hex3 <= 2#0010010#; -- 2
        elsif c/100 = 3 then
                seg_val_hex3 <= 2#0000110#; -- 3
        elsif c/100 = 4 then
                seg_val_hex3 <= 2#1001100#; -- 4
        elsif c/100 = 5 then
                seg_val_hex3 <= 2#0100100#; -- 5
        elsif c/100 = 6 then
                seg_val_hex3 <= 2#0100000#; -- 6
        elsif c/100 = 7 then
                seg_val_hex3 <= 2#0001111#; -- 7
        elsif c/100 = 8 then
                seg_val_hex3 <= 2#0000000#; -- 8
        elsif c/100 = 9 then
                seg_val_hex3 <= 2#0000100#; -- 9
        else
                seg_val_hex3 <= 2#1111111#; -- off 
        end if;
end process;
  aboveth <= '1' when ((s30='1' and c >= 30) or (s60='1' and c >= 60) or 
                       (s120='1' and c >= 120)) else '0';
end Impl; 
