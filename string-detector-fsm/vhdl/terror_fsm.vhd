library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity terror_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;
architecture behave of terror_fsm is
  signal q2, q1, q0,nq2, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a18,a19,a20,a21,a22,a23,a25,a26,a27,a28,a30,a31,a32,a33,a34,a35,a36,a37
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

