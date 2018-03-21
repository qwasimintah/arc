
-- Counter for the Oven project

library IEEE;
use IEEE.std_logic_1164.all;

entity Oven_count is
    port(reset, clk, start, stop, s30, s60, s120: in std_logic; 
         aboveth: out std_logic);
end Oven_count;

architecture Impl of Oven_count is
type States is (idle, counting, stopped);
signal state, nextstate: States;
signal c, nextc: natural;
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
    if (reset = '1') then state <= idle;
                          c <= 0; -- fill here
    -- if rising edge
    elsif (clk'event and clk='1') then
        state <= nextstate;
        c <= nextc; -- fill here
    end if;
  end process;
  aboveth <= '1' when ((s30='1' and c >= 30) or (s60='1' and c >= 60) or 
                       (s120='1' and c >= 120)) else '0';
end Impl; 
