library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

package EE224_Components is
   component inverter is
	port (a: in std_logic; b : out std_logic);
   end component;
   component AND_2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component NAND_2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component or_2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component Nor_2 is
	port (a, b: in std_logic; c : out std_logic);
   end component;
   component positive_d_latch is
	port (d, clk: in std_logic; q : out std_logic);
   end component;
   component negative_d_latch is
	port (d, clk: in std_logic; q : out std_logic);
   end component;
   component DFF is
	port (d, clk: in std_logic; q : out std_logic);
   end component;
   component AND_5 is
	port (a,b,c,d,e: in std_logic; w : out std_logic);
   end component;
   component AND_3 is
	port (a,b,c: in std_logic; w : out std_logic);
   end component;

end EE224_Components;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity AND_5 is
  port(a,b,c,d,e: in std_ulogic; w: out std_ulogic);
end entity AND_5;

architecture behave of AND_5 is
	signal a1,a2,a3: std_ulogic;
begin

G1: AND_2 port map(a,b,a1);
G2: AND_2 port map(a1,c,a2);
G3: AND_2 port map(a2,d,a3);
G4: AND_2 port map(a3,e,w);  -- output of 5 bit and gate

end behave;


library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity AND_3 is
  port(a,b,c: in std_ulogic; w: out std_ulogic);
end entity AND_3;

architecture behave of AND_3 is
	signal a1: std_ulogic;
begin

G1: AND_2 port map(a,b,a1);
G2: AND_2 port map(a1,c,w);    -- output of 3 bit and gate

end behave;

library ieee;
use ieee.std_logic_1164.all;
entity inverter is
  port (a: in std_ulogic;
         b: out std_ulogic);
end entity inverter;
architecture Behave of inverter is
begin
  b <= not a;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity AND_2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity AND_2;
architecture Behave of AND_2 is
begin
  c <= a and b;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity NAND_2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity NAND_2;
architecture Behave of NAND_2 is
begin
  c <= not(a and b);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity or_2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity or_2;
architecture Behave of or_2 is
begin
  c <= a or b;
end Behave;

library ieee;
use ieee.std_logic_1164.all;
entity Nor_2 is
  port (a, b: in std_ulogic;
         c: out std_ulogic);
end entity Nor_2;
architecture Behave of Nor_2 is
begin
  c <= not (a or b);
end Behave;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 
entity positive_d_latch is
  port (d, clk: in std_ulogic; q: out std_ulogic);
end entity positive_d_latch;
architecture Equations of positive_d_latch is
   signal qsig: std_logic;
begin
   -- q cannot be read.
   qsig    <= (d and clk) or (qsig and (not clk));
   q <= qsig;
end Equations;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 
entity negative_d_latch is
  port (d, clk: in std_ulogic; q: out std_ulogic);
end entity negative_d_latch;
architecture Equations of negative_d_latch is
   signal qsig: std_logic;
begin
   qsig    <= (d and (not clk)) or (qsig and clk);
   q <= qsig;
end Equations;

library ieee;
use ieee.std_logic_1164.all;
use work.EE224_Components.all; 
entity DFF is
  port (d, clk: in std_ulogic; q: out std_ulogic);
end entity DFF;
architecture Struct of DFF is
   signal U: std_logic;
begin
   master: negative_d_latch
            port map (d => d, clk => clk, q => U);
   slave: positive_d_latch
            port map (d => U, clk => clk, q => q);
end Struct;
