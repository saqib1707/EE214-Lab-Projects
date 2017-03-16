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
