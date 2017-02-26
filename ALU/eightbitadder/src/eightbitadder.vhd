
library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity eightbitadder is 
port (x,y: in std_logic_vector(7 downto 0);
		z:out std_logic_vector(7 downto 0));
end entity;

architecture behave of eightbitadder is
	component onebitadder is
	port(x,y,cin : in std_logic;
	z,cout : out std_logic);
	end component;
	signal c:std_logic_vector(7 downto 0);
begin
 adder0:onebitadder port map(x=>x(0),y=>y(0),cin=>'0',z=>z(0),cout=>c(0));
 adder1:onebitadder port map(x=>x(1),y=>y(1),cin=>c(0),z=>z(1),cout=>c(1));
 adder2:onebitadder port map(x=>x(2),y=>y(2),cin=>c(1),z=>z(2),cout=>c(2));
 adder3:onebitadder port map(x=>x(3),y=>y(3),cin=>c(2),z=>z(3),cout=>c(3));
 adder4:onebitadder port map(x=>x(4),y=>y(4),cin=>c(3),z=>z(4),cout=>c(4));
 adder5:onebitadder port map(x=>x(5),y=>y(5),cin=>c(4),z=>z(5),cout=>c(5));
 adder6:onebitadder port map(x=>x(6),y=>y(6),cin=>c(5),z=>z(6),cout=>c(6));
 adder7:onebitadder port map(x=>x(7),y=>y(7),cin=>c(6),z=>z(7),cout=>c(7));
end behave;



library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity onebitadder is
port (x,y,cin: in std_logic;
		z,cout:out std_logic);
end entity;

architecture behave of onebitadder is
begin
	z <= (cin xor (x xor y));
	cout <= ((cin and (x xor y)) or (x and y));
end behave;

