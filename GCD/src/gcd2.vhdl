
--mux
entity mux_2 is
	--generic (15 : integer);
	port (a,b: in bit_vector(15 downto 0); ctrl: in bit; mux_out: out bit_vector(15 downto 0));
end entity;

architecture mux_logic of mux_2 is
begin
	mux_out <= (ctrl and a) or ((not ctrl) and b);
end mux_logic;

-- separator
entity separator is
	--generic (15 : integer);
	port (d1,d2:in bit_vector(15 downto 0); g,l : out bit_vector(15 downto 0));
end entity;

architecture separator_logic of separator is

	component mux_2 is
		port (a,b: in bit_vector(15 downto 0); ctrl: in bit; mux_out: out bit_vector(15 downto 0));
	end component;

	component unsigned_comparator is
		port (	a      : in  bit_vector(15 downto 0);
    			b      : in  bit_vector(15 downto 0);
    			a_lt_b : out bit;
    			a_eq_b : out bit;
    			a_gt_b : out bit);
	end component;
	
	signal ctrl_two, A_LT_B, A_GT_B, A_EQ_B: bit;
begin
	g1: unsigned_comparator port map(a=>d1,b=>d2,a_lt_b=>A_LT_B,a_eq_b=>A_EQ_B,a_gt_b=>A_GT_B);
	ctrl_two <= ((A_GT_B and (not A_EQ_B)) and (not A_LT_B));
	
	g2: mux_2 port map(a=>d1,b=>d2,mux_out=>g,ctrl=>ctrl_two);   -- checks d1>d2 puts d1 in g and d2 in l
	g3: mux_2 port map(a=>d2,b=>d1,mux_out=>l,ctrl=>ctrl_two);
	
end separator_logic;


-- gcd2
entity gcd2 is 
	--generic (15 : integer);
	port (vect1,vect2:in bit_vector(15 downto 0);
		vect3: out bit_vector(15 downto 0));
end entity;

architecture logic_2 of gcd2 is
	-- component defined for dregister
	component dregister is
		--generic (15 : integer);                    -- no. of bits
  		port (din  : in  bit_vector(15 downto 0);
    			dout : out bit_vector(15 downto 0);
    			enable: in bit;
    			clk     : in  bit);
	end component;
	-- component defined for divisor
	component Divider16 is
		port ( divisor: in bit_vector(15 downto 0);
	  	dividend: in bit_vector(15 downto 0);
 	  	quotient: out bit_vector(15 downto 0);
 	  	remainder: out bit_vector(15 downto 0);
          	div_start: in bit;
	  	div_done: out bit;
          	clk: in bit;
          	reset: in bit);
	end component;
	-- component defined for separator
	component separator is
		--generic (15 : integer);
		port (d1,d2:in bit_vector(15 downto 0); g,l : out bit_vector(15 downto 0));
	end component;
	-- component for comparator
	component unsigned_comparator is
		--generic (15 : integer);
  		port (  a      : in  bit_vector(15 downto 0);
    			b      : in  bit_vector(15 downto 0);
   			a_lt_b : out bit;
    			a_eq_b : out bit;
    			a_gt_b : out bit);
	end component;
	
	signal DIVISOR,DIVIDEND,QUOTIENT,REMAINDER: bit_vector(15 downto 0);
	signal greater,lower: bit_vector(15 downto 0);
	signal rem_eq_zero: bit;

begin
g1: separator port map(d1=>vect1,d2=>vect2,g=>greater,l=>lower);
g2: dregister port map(din=>greater,dout=>DIVIDEND);   -- stores greater of the two in a register
g3: dregister port map(din=>lower,dout=>DIVISOR);     -- stores smaller of the two in a register
g4: Divider16 port map(dividend=>DIVIDEND,divisor=>DIVISOR,quotient=>QUOTIENT,remainder=>REMAINDER,   );
g5: unsigned_comparator port map(a=>REMAINDER,b=>'0',a_eq_b=>rem_eq_zero); -- compare remainder obtained with zero
g6: 


end logic_2;
