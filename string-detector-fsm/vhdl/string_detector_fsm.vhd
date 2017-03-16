
-----------------------------------------------
library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.EE224_Components.all;
-----------------------------------------------
entity string_detector_fsm is 
	port(X4,X3,X2,X1,X0,CLK,RESET: in std_logic; W: out std_logic);
end entity;

architecture behave of string_detector_fsm is 
	signal sig1,sig2,sig3,sig4,sig5,sig6,sig7 : std_logic;

	component gun_fsm is 
		port(x4,x3,x2,x1,x0,clk,reset:in std_logic; w:out std_logic);
	end component;

	component bomb_fsm is 
		port(x4,x3,x2,x1,x0,clk,reset:in std_logic; w:out std_logic);
	end component;

	component knife_fsm is 
		port(x4,x3,x2,x1,x0,clk,reset:in std_logic; w:out std_logic);
	end component;

	component terror_fsm is 
		port(x4,x3,x2,x1,x0,clk,reset:in std_logic; w:out std_logic);
	end component;

begin 
a: bomb_fsm      port map(x4=>X4,x3=>X3,x2=>X2,x1=>X1,x0=>X0,clk=>CLK,reset=>RESET,w=>sig1);
b: gun_fsm       port map(x4=>X4,x3=>X3,x2=>X2,x1=>X1,x0=>X0,clk=>CLK,reset=>RESET,w=>sig2);
c: knife_fsm     port map(x4=>X4,x3=>X3,x2=>X2,x1=>X1,x0=>X0,clk=>CLK,reset=>RESET,w=>sig3);
d: terror_fsm  port map(x4=>X4,x3=>X3,x2=>X2,x1=>X1,x0=>X0,clk=>CLK,reset=>RESET,w=>sig4);

o1: or_2 port map(sig1,sig2,sig5);
o2: or_2 port map(sig3,sig4,sig6);
o3: or_2 port map(sig5,sig6,sig7);

W<=sig7;

end behave;




----------------------------gun fsm part -----------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity gun_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;

architecture behave of gun_fsm is
  signal q1, q0, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22: std_ulogic;

begin
G0: inverter port map(reset,a0);
G1: inverter port map (x4,a1);
G2: inverter port map (x3,a2);
G3: inverter port map (x2,a3);
G4: inverter port map (x1,a4);
G5: inverter port map (x0,a5);
G6: inverter port map (q1,a6);
G7: inverter port map (q0,a7);

G8: AND_5 port map (a1,x3,x2,x1,a5,a8);   -- n
G9: AND_5 port map (a1,a2,x2,x1,x0,a9); -- g
G10: AND_5 port map (x4,a2,x2,a4,x0,a10); -- u

G11: inverter port map (a8,a11); -- nbar
G12:inverter port map (a10,a12); -- ubar

G13:AND_3 port map (q1,a7,a8, a13);
G14: AND_2 port map(a13,a0,w);   -- output

G15:AND_3 port map(a6,q0,a10,a15); --q1bq0u
G16: AND_3 port map(q1,a7,a11,a16); --q1q0bnb

G17: AND_3 port map(a6,a7,a9,a17); -- q1bq0bg
G18: AND_3 port map(a6,q0,a12,a18); --q1bq0ub

G19: or_2 port map(a15,a16,a19);
G20: AND_2 port map(a19,a0,nq1);  --nq1

G21: or_2 port map(a17,a18,a21); 
G22: AND_2 port map(a21,a0,nq0); --nq0

d1: DFF port map (d => nq1, clk => clk, q => q1);
d0: DFF port map (d => nq0, clk => clk, q => q0);
end behave;

------------------------------bomb fsm part-------------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity bomb_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;
architecture LogicNetwork of bomb_fsm is
  signal q1, q0, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a15,a16,a17,a18,a20,a21,a22,a23,a24,a25: std_ulogic;
begin

G0: inverter port map (reset, a0);   --resetb
G1: inverter port map (x4,a1);
G2: inverter port map (x3,a2);
G3: inverter port map (x2,a3);
G4: inverter port map (x1,a4);
G5: inverter port map (x0,a5);

G6: inverter port map (q1,a6);
G7: inverter port map (q0,a7);

G8: AND_5 port map (a1,a2,a3,x1,a5,a8);   --b
G9: AND_5 port map (a1,x3,x2,x1,x0,a9);   -- o
G10:  AND_5 port map (a1,x3,x2,a4,x0,a10); --m

G11: inverter port map(a8,a11);   --bb
G12: inverter port map(a9,a12); --ob
G13: inverter port map(a10,a13); --mb

G14:  AND_5 port map (q1,q0,a8,a0,'1',w);   -- output

G15:  AND_5 port map (a6,q0,a9,a0,'1',a15); 
G16:  AND_5 port map (q1,a7,a0,'1','1',a16);   
G17:  AND_5 port map (q1,q0,a11,a0,'1',a17);

G18: or_2 port map(a15,a16,a18);
G19:or_2 port map (a18,a17,nq1);   --nq1

G20: AND_5 port map(a6,a7,a8,a0,'1',a20);
G21: AND_5 port map(q1,a7,a10,a0,'1',a21);
G22: AND_5 port map(a6,q0,a12,a0,'1',a22);
G23:AND_5 port map(q1,q0,a11,a0,'1',a23);

G24: or_2 port map(a20,a21,a24);
G25: or_2 port map(a22,a23,a25);
G26: or_2 port map(a24,a25,nq0);  --nq0


d1: DFF port map (d => nq1, clk => clk, q => q1);
d0: DFF port map (d => nq0, clk => clk, q => q0);
end LogicNetwork;

------------------------------------Knife fsm part------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity knife_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;
architecture behave of knife_fsm is
  signal q2,q1, q0,nq2, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,
a28,a29,a30,a31,a32,a100,a101,a102: std_ulogic;
begin
G0: inverter port map(reset , a0);
G1: inverter port map (x4,a1);
G2: inverter port map (x3,a2);
G3: inverter port map (x2,a3);
G4: inverter port map (x1,a4);
G5: inverter port map (x0,a5);

G100:inverter port map (q2,a100);
G6: inverter port map (q1,a6);
G7: inverter port map (q0,a7);

G8: AND_5 port map (a1,x3,a3,x1,x0,a8);   -- k
G9: AND_5 port map (a1,x3,x2,x1,a5,a9); -- n
G10: AND_5 port map (a1,x3,a3,a4,x0,a10); -- i
G11: AND_5 port map (a1,a2,x2,x1,a5,a11); -- f
G12: AND_5 port map (a1,a2,x2,a4,x0,a12); -- e

G13: inverter port map (a9,a13); -- nbar
G14:inverter port map (a8,a14); -- kbar
G15:inverter port map (a10,a15); -- ibar
G16:inverter port map (a11,a16); -- fbar
G17:inverter port map (a12,a17); -- ebar

G18:AND_5 port map (q2,a6,a7,a12,a0,a18);   --output

G19:AND_5 port map(a100,q1,q0,a11,a0,a19); 
G20: AND_5 port map(q2,a6,a7,a17,a0,a20);
G21: or_2 port map(a19,a20,nq2);  --nq2

G22:AND_5 port map(a100,a6,q0,a9,a0,a22);
G23:AND_5 port map(a100,q1,q0,a16,a0,a23);
G24:AND_5 port map(a100,q1,a7,a15,a0,a24);
G101: AND_5 port map(a100,q1,a7,a10,a0,a101);
G25:or_2 port map(a22,a23,a25);
G102: or_2 port map(a24,a101,a102);
G26: or_2 port map(a25,a102,nq1);  --nq1

G27:AND_5 port map(a100,a6,a7,a8,a0,a27);
G28:AND_5 port map(a100,q1,a7,a10,a0,a28);
G29:AND_5 port map(a100,a6,q0,a13,a0,a29);
G30:AND_5 port map(a100,q1,q0,a16,a0,a30);
G31:or_2 port map(a27,a28,a31);
G32:or_2 port map(a29,a30,a32);
G33:or_2 port map(a31,a32,nq0); -- nq0

d2: DFF port map (d => nq2, clk => clk, q => q2);
d1: DFF port map (d => nq1, clk => clk, q => q1);
d0: DFF port map (d => nq0, clk => clk, q => q0);
end behave;

---------------------------terror fsm part---------------

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity terror_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;
architecture behave of terror_fsm is
  signal q2, q1, q0,nq2, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a18,a19,a20,a21,a22,a23,a25,a26,a27,a28,a30,a31,
a32,a33,a34,a35,a36,a37
,a38,a39: std_ulogic;
begin
G0: inverter port map(reset , a0);

G1: inverter port map (x4,a1);
G2: inverter port map (x3,a2);
G3: inverter port map (x2,a3);
G4: inverter port map (x1,a4);
G5: inverter port map (x0,a5);
G6: inverter port map(q2,a6);
G7: inverter port map (q1,a7);
G8: inverter port map (q0,a8);

G9: AND_5 port map(x4,a2,x2,a4,a5,a9);   --t
G10: AND_5 port map(a1,a2,x2,a4,x0,a10);  -- e
G11: AND_5 port map(x4,a2,a3,x1,a5,a11);  -- r
G12:AND_5 port map(a1,x3,x2,x1,x0,a12); -- o

G13: inverter port map(a9,a13);  --tb
G14: inverter port map(a10,a14);  --eb
G15: inverter port map(a11,a15);  --rb
G16: inverter port map(a12,a16);  --ob

G17: AND_5 port map(q2,a7,q0,a11,a0,w);  -- output

G18: AND_5 port map(a6,q1,q0,a11,a0,a18); 
G19: AND_5 port map(q2,a7,q0,a12,a0,a19); 
G20: AND_5 port map(q2,a7,a8,a16,a0,a20);
G21: AND_5 port map(q2,a7,q0,a15,a0,a21);
G22: or_2 port map(a18,a19,a22);
G23: or_2 port map(a20,a21,a23);
G24: or_2 port map(a22,a23,nq2);    --nq2

G25: AND_5 port map(a6,a7,q0,a10,a0,a25);
G26: AND_5 port map(a6,q1,a8,a0,'1',a26);
G27: AND_5 port map(a6,q1,a15,'1',a0,a27);
G28: or_2 port map(a25,a26,a28);
G29: or_2 port map(a28,a27,nq1);   --nq1

G30: AND_5 port map(a6,a7,a8,a9,a0,a30);
G31: AND_5 port map(a6,q1,a8,a11,a0,a31);
G32: AND_5 port map(q2,a7,a8,a12,a0,a32);
G33: AND_5 port map(a6,a7,q0,a14,a0,a33);
G34: AND_5 port map(a6,a7,a8,a15,a0,a34);
G35: AND_5 port map(q2,a7,q0,a15,a0,a35);
G36: or_2 port map(a30,a31,a36);
G37: or_2 port map(a32,a33,a37);
G38: or_2 port map(a34,a35,a38);
G39: or_2 port map(a36,a37,a39);
G40: or_2 port map(a38,a39,nq0);   --nq0

d2: DFF port map (d => nq2, clk => clk, q => q2);
d1: DFF port map (d => nq1, clk => clk, q => q1);
d0: DFF port map (d => nq0, clk => clk, q => q0);
end behave;

--------------------------------	
