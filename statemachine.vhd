library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity state_machine is 
Port (	
clk2    : in std_logic;
rst     : in std_logic;
output  : out std_logic;
sel_a_in: in std_logic;
sel_m_in: in std_logic;
D_add   : in std_logic_vector;
D_mul   : in std_logic_vector
);
end entity;

architecture behave of state_machine is
type fsm is (idle, st_add, st_mul, result);
	signal state : fsm;
	
begin
process(clk2, rst)
begin
    if rst = '1' then
	   if rising_edge (clk2) then
	    state <= idle;
		else
			case state is
			when idle =>
			    if sel_a_in = '1' & D_add = x"5" then
				    state <= st_add;
				elsif sel_m_in = '1' & D_mul = x"2A" then
				    state <= st_mul;
				end if;
				
			when st_add =>
			   state <= result;
			   
			when st_mul => 
			    state <= result;
				
			when result =>
			    state <= idle;
		
		end if;
		
	end if;
	
end behave;		    
		