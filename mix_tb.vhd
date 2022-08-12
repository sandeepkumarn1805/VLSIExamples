library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mix_tb is 
end entity;


architecture bahve of mix_tb is

component dataflow 
Port (	
	Clk		: in STD_LOGIC;
	Rst		: in STD_LOGIC;
	Rdd		: in STD_LOGIC;
	Wrt		: in STD_LOGIC;
	RnW		: out STD_LOGIC;
	data_a	: in std_logic_vector(7 downto 0);
	data_b	: in std_logic_vector(7 downto 0);
	Bus_id	: out std_logic_vector(8 downto 0);
	Clk2	: out std_logic;
	Rstn	: out std_logic
	);
end component;

component state_machine is 
Port (	
	Clk2	: in STD_LOGIC;
	Rstn	: in STD_LOGIC;
	RnW		: in STD_LOGIC;
	Bus_id	: in std_logic_vector(8 downto 0);
	OE		: out std_logic;
	WE		: out std_logic
	);
end component;


	constant clk_per: time := 40 ns;
	
	signal clk_sim	: std_logic;
	signal rst_sim	: std_logic;
	signal rdd_sim	: std_logic;
	signal wrt_sim	: std_logic;
	signal bus_id_con : std_logic_vector(8 downto 0);
	signal rnw_con	  : std_logic;
	signal data_a_sim : std_logic_vector(7 downto 0);
	signal data_b_sim : std_logic_vector(7 downto 0);
	signal oe_sim	: std_logic;
	signal we_sim	: std_logic;
	signal clk2_con	: std_logic;
	signal rst_con	:std_logic;

begin 

dataflow_inst : dataflow 
				port map (
						clk		=> clk_sim,
						rst		=> rst_sim,
						rdd		=> rdd_sim,
						wrt		=> wrt_sim,
						rnw		=> rnw_con,
						data_a	=> data_a_sim,
						data_b	=> data_b_sim,
						bus_id	=> bus_id_con,
						clk2	=> clk2_con,
						rstn	=> rst_con
						);

state_machine_inst : state_machine 
					port map (
						clk2	=> clk2_con,
						rstn	=> rst_con,
						rnw		=> rnw_con,
						bus_id	=> bus_id_con,
						oe		=> oe_sim,
						we		=> we_sim
					 );
							 
							 

clk_proc: process
begin
	clk_sim <= '1';
	wait for clk_per/2;
	clk_sim <= not clk_sim;
	wait for clk_per/2;
end process;

reset_proc: process
begin
	rst_sim <= '1';
	wait for (15*clk_per);
	rst_sim <= not rst_sim;
	wait;
end process; 

data_a_sim <=  x"cc";

  -- data_a_sim <=  x"00",
				 -- x"cc" after (20*clk_per),
				 -- x"c0" after (25*clk_per),
				 -- x"cc" after (30*clk_per),
				 -- x"0c" after (60*clk_per),
				 -- x"cc" after (64*clk_per),
				 -- x"c0" after (71*clk_per);
				
  data_b_sim <=  x"cc";
  
  -- data_b_sim <=  x"00",
				 -- x"df" after (23*clk_per),
				 -- x"cc" after (35*clk_per);
				
  rdd_sim   <= '0',
              '1' after (25*clk_per),
			  '0' after (33*clk_per);
			 
  wrt_sim   <= '0',
			  '1' after (25*clk_per),
			  '0' after (32*clk_per),
			  '1' after (33*clk_per);
			 

			   							 
end bahve;

