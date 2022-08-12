library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity tb is 
end entity;


architecture behave of tb is

component dataflow is 
Port (	
        Clk		: in std_logic;
	    Rst		: in std_logic;
		en      : in std_logic;
		d1      : in std_logic_vector(1 downto 0);
		d2      : in std_logic_vector(1 downto 0);
		d3      : in std_logic_vector(2 downto 0);
		d4      : in std_logic_vector(2 downto 0);
		sel_a_out : out std_logic;
		D_add   : out std_logic;
		clk2    : out std_logic;
		D_mul   : out std_logic;
		sel_m_out : out std_logic
		);
end component;

component state_machine is 
Port (	
clk2    : in std_logic;
rst     : in std_logic;
output  : out std_logic;
sel_a_in: in std_logic;
sel_m_in: in std_logic;
D_add   : in std_logic_vector;
D_mul   : in std_logic_vector
);
end component;

constant clk_per: time := 10 ns;

    signal clk_sim	: std_logic;
	signal rst_sim	: std_logic;
	signal en_sim	: std_logic;
	signal d1_sim   : std_logic_vector(1 downto 0);
	signal d2_sim   : std_logic_vector(1 downto 0);
	signal d3_sim   : std_logic_vector(2 downto 0);
	signal d4_sim   : std_logic_vector(2 downto 0);
	signal sel_a_out_con: std_logic;
	signal sel_m_out_con : std_logic;
	signal sel_a_in_con : std_logic;
	signal sel_m_in_con : std_logic;
	signal D_add_con : std_logic;
	signal D_mul_con : std_logic;
	signal clk2_con : std_logic;
	
dataflow_inst : dataflow 
				port map (
						clk		=> clk_sim,
						rst		=> rst_sim,
						en      => en_sim,
						d1      => d1_sim,
						d2      => d2_sim,
						d3      => d3_sim,
						d4      => d4_sim,
						sel_a_out => sel_a_in_con,
						sel_m_out => sel_m_in_con,
						D_add   => D_add_con,
						D_mul   => D_mul_con,
						clk2   => clk2_con
						);
						
statemachine_inst : statemachine 
					port map (
						clk2	=> clk2_con,
						rst  	=> rst_con,
						sel_a_in => sel_a_out_con,
						sel_m_in => sel_m_out_con,
						D_add   => D_add_con,
						D_mul  => D_mul_con
						);
						
clk_proc: process
begin
	clk_sim <= '1';
	wait for clk_per/2;
	clk_sim <= not clk_sim;
	wait for clk_per/2;
end process;

rst_proc: process
begin
	rst_sim <= '1';
	wait for (15*clk_per);
	rst_sim <= not rst_sim;
	wait;
end process; 
	
 d1_sim     <=   x"00",
				 x"cc" after (20*clk_per),
				 x"c0" after (25*clk_per),
				 x"cc" after (30*clk_per),
				 x"0c" after (60*clk_per),
				 x"cc" after (64*clk_per),
				 x"c0" after (71*clk_per);
				 
 d2_sim <=   x"00",
				 x"df" after (23*clk_per),
				 x"cc" after (35*clk_per);
	
d3_sim  <=   x"00";

d4_sim  <=   x"00";

en_sim <= '0',
        '1' after clk_per * 6;
end behave;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	