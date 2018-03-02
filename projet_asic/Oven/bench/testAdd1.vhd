entity testAdd1 is
end testAdd1;

architecture test1 of testAdd1 is
  component full_adder is
     port(X,Y,Cin : in Bit; Sum,Cout : out Bit);  
  end component;
  signal x,y,c1,s,c2: bit;
begin
     A: full_adder port map(x,y,c1,s,c2);
     x <= '1' after 20 ns;
     y <= '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
     c1 <= '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns, '1' after 35 ns;
     -- Add here your input stimulis
end test1;

library LIB_ADD1;
library LIB_ADD1_BENCH;

configuration config1 of LIB_ADD1_BENCH.testAdd1 is 
    for test1 
       for A:full_adder use entity LIB_ADD1.full_adder(Dataflow_view);
       end for;
    end for; 
end config1; 

