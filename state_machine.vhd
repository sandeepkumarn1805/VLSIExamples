library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity state_machine is 
Port (	
	Clk2	: in STD_LOGIC;
	Rstn	: in STD_LOGIC;
	RnW		: in STD_LOGIC;
	Bus_id	: in std_logic_vector(8 downto 0);
	OE		: out std_logic;
	WE		: out std_logic
	);
end entity;

Architecture behave of state_machine is

	type fsm is (idle, dec, rd, wr, waitwr2rd, waitrd2wr);
	signal state : fsm;

begin

process (clk2, rstn)

begin
	if rising_edge (clk2) then
		if rstn = '0' then
		state <= idle;
		else
			case state is
			when idle =>
				if bus_id = "110011000" then  --x"198"
					state <= dec;
				end if;
				
			when dec =>
				if rnw = '0' then
					state <= wr;
				else 
					state <= rd;
				end if;
						
			when RD	=>
				if rnw = '0' then 
					state <= waitrd2wr;
				else
					state <= idle;
				end if;
			
			when WR	=>
				if rnw = '1' then
					state <= waitwr2rd;
				else
					state <= idle;
				end if;
			
			when waitwr2rd	=>
				state <= rd;
			
			when waitrd2wr	=>
				state <= wr;
			
			when others  =>
				null;
			end case;
		end if;
	end if;
end process;

	we <= '1' when state = wr else '0';
	oe <= '1' when state = rd else '0';

end behave;