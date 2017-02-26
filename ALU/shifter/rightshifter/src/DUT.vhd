-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  two-bit adder.
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
   port(input_vector: in std_logic_vector(15 downto 0); ---Note: for alu testing (17 downto 0) for others (15 downto 0)
       	output_vector: out std_logic_vector(7 downto 0));
end entity;

architecture DutWrap of DUT is

	---Add component of eightbitadder 
	component rightshift is
	port (x,y: in std_logic_vector(7 downto 0);
		z:out std_logic_vector(7 downto 0));
	end component;
	--- Add component of eightbitsubtractor 
	--- Add component of leftshift
	--- Add component of rightshift
	

begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
--add_instance: eightbitadder port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector(7 downto 0));
--add_instance: leftshift port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0), z=> output_vector(7 downto 0)); 
add_instance: rightshift port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0), z=> output_vector(7 downto 0)); 
--c: rightshift          port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector); 
--d: eightbitsubtractor  port map(x => input_vector(15 downto 8), y =>input_vector(7 downto 0) , z=> output_vector); --- Note: z = x- y
--dut: alu port map( X => input_vector(15 downto 8), Y => input_vector(7 downto 0) , x0 => input_vector(16) , x1 => input_vector(17), Z => output_vector);
end DutWrap;

