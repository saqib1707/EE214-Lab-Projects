
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity eightbitsubtractor is 
port (x,y: in std_logic_vector(7 downto 0);
		z:out std_logic_vector(7 downto 0));
end entity;

architecture behave of eightbitsubtractor is
	component onebitsubtractor is
	port(x,y,cin : in std_logic;
	z,cout : out std_logic);
	end component;
	signal c:std_logic_vector(7 downto 0);
begin

 subtractor0:onebitsubtractor port map(x=>x(0),y=>y(0),cin=>'0',z=>z(0),cout=>c(0));
 subtractor1:onebitsubtractor port map(x=>x(1),y=>y(1),cin=>c(0),z=>z(1),cout=>c(1));
 subtractor2:onebitsubtractor port map(x=>x(2),y=>y(2),cin=>c(1),z=>z(2),cout=>c(2));
 subtractor3:onebitsubtractor port map(x=>x(3),y=>y(3),cin=>c(2),z=>z(3),cout=>c(3));
 subtractor4:onebitsubtractor port map(x=>x(4),y=>y(4),cin=>c(3),z=>z(4),cout=>c(4));
 subtractor5:onebitsubtractor port map(x=>x(5),y=>y(5),cin=>c(4),z=>z(5),cout=>c(5));
 subtractor6:onebitsubtractor port map(x=>x(6),y=>y(6),cin=>c(5),z=>z(6),cout=>c(6));
 subtractor7:onebitsubtractor port map(x=>x(7),y=>y(7),cin=>c(6),z=>z(7),cout=>c(7));
end behave;



library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity onebitsubtractor is
port (x,y,cin: in std_logic;
		z,cout:out std_logic);
end entity;

architecture behave of onebitsubtractor is
begin
	z <= (cin xor (x xor y));
	cout <= ((not x) and cin) or ((not x) and y) or (cin and y);
end behave;

