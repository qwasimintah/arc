entity testPacces is
end testPacces;

architecture test1 of testPacces is
  component Parking is
     port(clk, reset, require_in, avail, timeout1, timeout2, sensor_in, insert_ticket, ticketOK, sensor_out : in Bit;
          gate_in_open, gate_out_open, car_in, ticket_inserted, car_out  : out Bit);  
  end component;
  signal clk1, reset1, require_in1, avail1, timeout11, timeout21, sensor_in1, insert_ticket1, ticketOK1, sensor_out1, gate_in_open1, gate_out_open1, car_in1, ticket_inserted1, car_out1: bit;
begin
     A: Parking port map(clk1, reset1, require_in1, avail1, timeout11, timeout21, sensor_in1, insert_ticket1, ticketOK1, sensor_out1, gate_in_open1, gate_out_open1, car_in1, ticket_inserted1, car_out1);
	process
	begin
		clk1<='0';
		wait for 10 ns; 
		clk1<='1';
		wait for 10 ns; 
	end process;
	avail1<='1' after 10 ns;
	require_in1<='1' after 20 ns, '0' after 30 ns;
	timeout11<='1' after 30 ns, '0' after 40 ns;
end test1;

library LIB_PACCES;
library LIB_PACCES_BENCH;

configuration config1 of LIB_PACCES_BENCH.testPacces is 
    for test1 
       for A:Parking use entity LIB_PACCES.Parking(Automaton);
       end for;
    end for; 
end config1; 

