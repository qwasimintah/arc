entity Parking is
     port(clk, reset, require_in, avail, timeout1, timeout2, sensor_in, insert_ticket, ticketOK, sensor_out : in Bit;   -- ports d'entree
          gate_in_open, gate_out_open, car_in, ticket_inserted, car_out  : out Bit);   -- ports de sortie
end Parking;

architecture Automaton of Parking is
type States is (Idle,Open_in, Close_in,Verif_ticket,Open_out,Close_out);
signal state,nextstate: States;
begin
	process(state, require_in, avail, timeout1, timeout2, sensor_in, insert_ticket, ticketOK, sensor_out)
	begin
		case state is
			when Idle => 
				if insert_ticket='1' then nextstate<= Verif_ticket;
				elsif require_in='1' and avail='1' then nextstate <= Open_in;
				else nextstate <= Idle;
				end if;
			when Open_in => if timeout1='1' then
						nextstate <= Close_in;
					elsif sensor_in='1' then
						nextstate <= Close_in;
					else nextstate <= Open_in;
					end if;
			when Close_in => nextstate <= Idle;
			when Verif_ticket => if ticketOK='1' then nextstate <= Open_out;
					     else nextstate <= Idle;
					     end if;
			when Open_out => if timeout2='1' then
						nextstate <= Close_out;
					elsif sensor_out='1' then
						nextstate <= Close_out;
					else nextstate <= Open_out;
					end if;
			when Close_out => nextstate <= Idle;
		end case;
	end process;

	process(reset, clk)
	begin
		if (reset='1') then state<=Idle;
		elsif (clk'event and clk='1') then
			state <= nextstate;
		end if;
	end process;
	
	process(state, require_in, avail, timeout1, timeout2, sensor_in, insert_ticket, ticketOK, sensor_out)
	begin
		if state = Idle and insert_ticket='1' then
			ticket_inserted <= '1';
		else ticket_inserted <= '0';
		end if;

		if state = Idle and require_in='1' and avail='1' and insert_ticket='0' then
			gate_in_open <= '1';
		else gate_in_open <= '0';
		end if;

		if state=Verif_ticket and ticketOK='1' then
			gate_out_open <= '1';
		else gate_out_open <= '0';
		end if;

		if state=Open_in and timeout1='0' and sensor_in='1' then
			car_in <= '1';
		else car_in <= '0';
		end if;

		if state=Open_out and timeout2='0' and sensor_out='1' then
			car_out <= '1';
		else car_out <= '0';
		end if;
	end process;

end Automaton;

