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

