
-----------------------------------------------
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
-----------------------------------------------
entity alu is 
	port( X,Y : in std_logic_vector(7 downto 0); x0,x1 : in std_logic ; Z : out std_logic_vector(7 downto 0));
end entity;

architecture behave of alu is 
	signal sig1,sig2,sig3,sig4 : std_logic_vector(7 downto 0);

	component eightbitadder is 
		port(x,y:in std_logic_vector(7 downto 0); z:out std_logic_vector(7 downto 0));
	end component;
	--- Add component of eightbitsubtractor 

	component leftshift is 
		port( x,y : in std_logic_vector(7 downto 0);
	      z: out std_logic_vector(7 downto 0));
	end component;
	--- Add component of rightshift 
	component rightshift is 
		port( x,y : in std_logic_vector(7 downto 0);
	      z: out std_logic_vector(7 downto 0));
	end component;

	component eightbitsubtractor is 
		port(x,y:in std_logic_vector(7 downto 0); z:out std_logic_vector(7 downto 0));
	end component;
-----------------------------------------------			
begin 
a: eightbitadder       port map(x => X, y => Y, z => sig1);
b: leftshift	       port map(x => X, y => Y, z => sig4);
c: rightshift          port map(x => X, y => Y, z => sig3);
d: eightbitsubtractor  port map(x => X, y => Y, z => sig2);
-----------------------------------------------

process(x0, x1,sig1, sig2, sig3, sig4)
begin
------------------------------
if (x0 = '0' and x1 = '0') then
z<= sig1;
elsif(x0 = '1') and (x1 = '0') then
z<= sig2;
elsif(x0 = '0') and (x1 = '1') then
z<= sig3;
else
z<= sig4;
end if;
------------------------------
end process;

end behave;

-----------------Eight Bit Adder------------------------------------
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

--------------------------------------------------------------------

---------------------------------Left Shifter--------------------------

library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity leftshift is 
port (x,y: in std_logic_vector(7 downto 0);
		z:out std_logic_vector(7 downto 0));
end entity;

architecture behave of leftshift is
	signal a, b:std_logic_vector(7 downto 0);
	signal c:std_logic;
begin
c <= (not (y(7) or y(6) or y(5) or y(4) or y(3)));

a(7) <= (x(3) and y(2)) or ((not y(2)) and x(7));
a(6) <= (x(2) and y(2)) or ((not y(2)) and x(6));
a(5) <= (x(1) and y(2)) or ((not y(2)) and x(5));
a(4) <= (x(0) and y(2)) or ((not y(2)) and x(4));
a(3) <= ((not y(2)) and x(3));
a(2) <= ((not y(2)) and x(2));
a(1) <= ((not y(2)) and x(1));
a(0) <= ((not y(2)) and x(0));

b(7) <= (a(5) and y(1)) or ((not y(1)) and a(7));
b(6) <= (a(4) and y(1)) or ((not y(1)) and a(6));
b(5) <= (a(3) and y(1)) or ((not y(1)) and a(5));
b(4) <= (a(2) and y(1)) or ((not y(1)) and a(4));
b(3) <= (a(1) and y(1)) or ((not y(1)) and a(3));
b(2) <= (a(0) and y(1)) or ((not y(1)) and a(2));
b(1) <= ((not y(1)) and a(1));
b(0) <= ((not y(1)) and a(0));

z(7) <= ((b(6) and y(0)) or ((not y(0)) and b(7))) and c;
z(6) <= ((b(5) and y(0)) or ((not y(0)) and b(6))) and c;
z(5) <= ((b(4) and y(0)) or ((not y(0)) and b(5))) and c;
z(4) <= ((b(3) and y(0)) or ((not y(0)) and b(4))) and c;
z(3) <= ((b(2) and y(0)) or ((not y(0)) and b(3))) and c;
z(2) <= ((b(1) and y(0)) or ((not y(0)) and b(2))) and c;
z(1) <= ((b(0) and y(0)) or ((not y(0)) and b(1))) and c;
z(0) <= (((not y(0)) and b(0))) and c;

end behave;
-------------------------------------------------------------------------
---------------------------------Right Shifter-----------------------------


library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

entity rightshift is 
port (x,y: in std_logic_vector(7 downto 0);
		z:out std_logic_vector(7 downto 0));
end entity;

architecture behave of rightshift is
	signal a, b:std_logic_vector(7 downto 0);
	signal c:std_logic;
begin
c <= (not (y(7) or y(6) or y(5) or y(4) or y(3)));

a(0) <= (x(4) and y(2)) or ((not y(2)) and x(0));
a(1) <= (x(5) and y(2)) or ((not y(2)) and x(1));
a(2) <= (x(6) and y(2)) or ((not y(2)) and x(2));
a(3) <= (x(7) and y(2)) or ((not y(2)) and x(3));
a(4) <= ((not y(2)) and x(4));
a(5) <= ((not y(2)) and x(5));
a(6) <= ((not y(2)) and x(6));
a(7) <= ((not y(2)) and x(7));

b(0) <= (a(2) and y(1)) or ((not y(1)) and a(0));
b(1) <= (a(3) and y(1)) or ((not y(1)) and a(1));
b(2) <= (a(4) and y(1)) or ((not y(1)) and a(2));
b(3) <= (a(5) and y(1)) or ((not y(1)) and a(3));
b(4) <= (a(6) and y(1)) or ((not y(1)) and a(4));
b(5) <= (a(7) and y(1)) or ((not y(1)) and a(5));
b(6) <= ((not y(1)) and a(6));
b(7) <= ((not y(1)) and a(7));

z(0) <= ((b(1) and y(0)) or ((not y(0)) and b(0))) and c;
z(1) <= ((b(2) and y(0)) or ((not y(0)) and b(1))) and c;
z(2) <= ((b(3) and y(0)) or ((not y(0)) and b(2))) and c;
z(3) <= ((b(4) and y(0)) or ((not y(0)) and b(3))) and c;
z(4) <= ((b(5) and y(0)) or ((not y(0)) and b(4))) and c;
z(5) <= ((b(6) and y(0)) or ((not y(0)) and b(5))) and c;
z(6) <= ((b(7) and y(0)) or ((not y(0)) and b(6))) and c;
z(7) <= (((not y(0)) and b(7))) and c;

end behave;

----------------------------Eight Bit Subtractor---------------------------------


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

