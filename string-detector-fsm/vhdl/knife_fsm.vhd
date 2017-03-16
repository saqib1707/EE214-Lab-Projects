library ieee;
use ieee.std_logic_1164.all;
library work;
use work.EE224_Components.all;

entity knife_fsm is
  port(x4,x3,x2,x1,x0,reset: in std_ulogic; w: out std_ulogic; clk: in std_ulogic);
end entity;
architecture behave of knife_fsm is
  signal q2,q1, q0,nq2, nq1, nq0: std_ulogic;
  signal a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27,a28,a29,a30,a31,a32,a100: std_ulogic;
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
G24:AND_5 port map(a100,q1,a7,a0,'1',a24);
G25:or_2 port map(a22,a23,a25);
G26: or_2 port map(a25,a24,nq1);  --nq1

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

