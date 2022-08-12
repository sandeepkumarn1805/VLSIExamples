library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity two_cnt_tb is
end entity;

architecture behave of two_cnt_tb is

component two_cnt is
	port (
		clk1	: in std_logic;
		rst		: in std_logic;
		en		: in std_logic;
		countout: out std_logic_vector(3 downto 0)
	);
end component; 

signal clk1_sim : std_logic := '0';
signal rst_sim : std_logic  := '0';
signal en_sim : std_logic;
signal countout_sim : std_logic_vector(3 downto 0);

constant clk_per : time := 10 ns; -- 100MHz

begin

two_cnt_inst: two_cnt port map (
							clk1 => clk1_sim,
							rst  => rst_sim,
							en   => en_sim,
							countout => countout_sim
							);

clk_proc: process
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
		  '1' after clk_per* 8;

end behave;