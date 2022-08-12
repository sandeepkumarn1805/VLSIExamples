library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

 


entity add_tb is 
end entity;

 

architecture behave of add_tb is

component cnt1 is 
        port(
		    clk1 : in std_logic := '0';
			rst  : in std_logic := '1';
			en   : in std_logic;
			rstn : out std_logic;
			clk2 : out std_logic;
			cnt1_v : out std_logic_vector(2 downto 0);
			en_m1 : out std_logic;
			en_m2 : out std_logic;
			cnt2_v : out std_logic_vector(4 downto 0)
			);
end component;

component add is 
        port(
		cnt1_v :in std_logic_vector(2 downto 0);
		cnt2_v :in std_logic_vector(4 downto 0);
		clk2 : in std_logic;
		rstn : in std_logic;
		en_m1 : in std_logic;
		en_m2 : in std_logic;
		d_out : out std_logic_vector(9 downto 0)
		);
end component;

 constant clk_per: time := 40 ns;
 
 signal clk1_sim : std_logic;
 signal rst_sim : std_logic;
 signal en_sim : std_logic;
 signal rstn_con : std_logic;
 signal clk2_con : std_logic;
 signal cnt1_v_con : std_logic_vector(2 downto 0);
 signal cnt2_v_con : std_logic_vector(4 downto 0);
 signal en_m1_con : std_logic;
 signal en_m2_con : std_logic;
 signal d_out_sim : std_logic_vector(9 downto 0);
 
 begin
 
 cnt1_inst : cnt1 port map (
				            clk1        => clk1_sim,
                            rst        => rst_sim,
							en        => en_sim,
							rstn        => rstn_con,
							clk2        => clk2_con,
							cnt1_v       => cnt1_v_con,
							cnt2_v        => cnt2_v_con,
							en_m1        => en_m1_con,
							en_m2        => en_m2_con
							);
							
add_inst : add port map(
                            rstn        => rstn_con,
							clk2        => clk2_con,
							cnt1_v      => cnt1_v_con,
							cnt2_v      => cnt2_v_con,
							en_m1       => en_m1_con,
							en_m2       => en_m2_con,
							d_out       => d_out_sim
							);
							

clk1_proc: process
begin
	wait for clk_per/2;
		clk1_sim <= not clk1_sim;
end process;

rst_proc: process
begin
	wait for clk_per * 5;
		rst_sim <= not rst_sim;
	wait; 
end process;

en_sim <= '0',
        '1' after clk_per * 6;
end behave;
                        
			  
							
                           
 
 
