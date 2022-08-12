library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;




entity memctrl_sim is
end memctrl_sim;


architecture behave of memctrl_sim is


component memctrl
	Port (
			clk:    	in std_logic;
			Rst:	    in std_logic;
			burst, RnW:	in std_logic;
			Bus_id:		in std_logic_vector(7 downto 0);
			We:			out std_logic;
			Oe:			out std_logic
		 );
end component;
	
	constant clock_period : time := 10 ns;
	signal sig_clk: 			std_logic;
	signal sig_Rst:				std_logic;
	signal sig_burst, sig_RnW: 	std_logic;
	signal sig_Bus_id:			std_logic_vector(7 downto 0);
	signal sig_We:				std_logic;
	signal sig_Oe:				std_logic;

begin	
	
	memcnt_inst: memctrl port map(	clk		=> sig_clk,  	
									Rst		=> sig_Rst,	    	
									burst	=> sig_burst,	    	
									RnW		=> sig_RnW,
									Bus_id	=> sig_Bus_id,
									We		=> sig_We,				
									Oe		=> sig_Oe
								);
		
clk:process
	begin
	  sig_clk <= '1';
	wait for clock_period/2;
	  sig_clk <= not sig_clk;
	wait for clock_period/2;
end process;	
	
rst:process
	begin
	  sig_Rst <= '1';
	wait for clock_period*10;
	  sig_Rst <='0';
	wait;
end process;

proc_bus_id:process
	begin
	  sig_Bus_id <= X"0B";
	wait for clock_period*15;
	  sig_Bus_id <= X"AB";
	wait for clock_period*12;
	  sig_Bus_id <= X"BA";
	  wait;
	end process;
	
proc_rnw:process
	begin
		sig_rnw <= '1';
	wait for clock_period*18;
		sig_rnw <= '0';
	wait for clock_period*2;
	end process;

proc_burst: process
		begin
			sig_burst <= '0';
		wait for clock_period*21;
			sig_burst <= '1';
		wait for clock_period*30;
			sig_burst <= '0';
			wait for clock_period*40;
		end process;
	
		
end behave;