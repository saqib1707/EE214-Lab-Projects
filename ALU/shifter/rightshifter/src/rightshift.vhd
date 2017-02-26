
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
