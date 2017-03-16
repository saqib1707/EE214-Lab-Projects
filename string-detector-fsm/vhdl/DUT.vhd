library ieee;
use ieee.std_logic_1164.all;

entity DUT is
 port(input_vector: in std_ulogic_vector(6 downto 0);    
	output_vector: out std_ulogic_vector(0 downto 0));
end entity;


architecture WRAP of DUT is
 component string_detector_fsm is
   port(x4,x3,x2,x1,x0,reset,clk: in std_ulogic; w: out std_ulogic);
end component;
signal x4,x3,x2,x1,x0,reset,clk,w: std_ulogic;

begin

reset <= input_vector(6);
clk<= input_vector(5);
x4<= input_vector(4);
x3<= input_vector(3);
x2<= input_vector(2);
x1<= input_vector(1);
x0<= input_vector(0);

dut_instance: string_detector_fsm port map (reset=>input_vector(6),
			clk=>input_vector(5),
			x4 =>input_vector(4),
			x3=>input_vector(3),
			x2=>input_vector(2),
			x1=>input_vector(1),
			x0=>input_vector(0),
			w=>output_vector(0));

end WRAP;
