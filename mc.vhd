library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity memctrl is
	Port (
			clk:    	in std_logic;
			Rst:	    in std_logic;
			burst, RnW:	in std_logic;
			Bus_id:		in std_logic_vector(7 downto 0);
			We:			out std_logic;
			Oe:			out std_logic
		 );
end entity;

architecture behave of memctrl is

type state_type is (Idle, Dec, Wr, Rd1, Rd2, Rd3, Rd4);
signal state	: state_type;


begin
	process(clk, Rst)
	begin	
		if Rst = '1' then
			state <= Idle;
		elsif rising_edge(clk)then  	
			case(state) is
			when Idle =>
				if Bus_id = "10101011" then  -- x"ab"
					state <= Dec;
				end if;
		
			when Dec =>
				if RnW = '1' then 
					state <= Rd1;
				else
					state <= Wr;
				end if;
				
			when Wr =>
				state <= Idle;
			
			when Rd1 =>
				if burst = '1' then
					state <= Rd2;
				else
					state <= Idle;
				end if;

			when Rd2 =>
				state <= Rd3;
		
			when Rd3 =>
				state <= Rd4;
				
			when Rd4 => 
				state <= Idle;
			end case;
		end if;
   end process;
  
 
   We <= '1' when state = Wr else '0';
   	
   with state select
   Oe <= '1' when Rd1 | Rd2 | Rd3 | Rd4, 
		 '0' when others; 
	   
		 			 
end behave;
