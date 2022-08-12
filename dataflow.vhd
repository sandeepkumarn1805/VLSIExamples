library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity dataflow is 
Port (	
        Clk		: in std_logic;
	    Rst		: in std_logic;
		en      : in std_logic;
		d1      : in std_logic_vector(1 downto 0);
		d2      : in std_logic_vector(1 downto 0);
		d3      : in std_logic_vector(2 downto 0);
		d4      : in std_logic_vector(2 downto 0);
		sel_a_out : out std_logic;
		D_add   : out std_logic_vector(5 downto 0);
		clk2    : out std_logic;
		D_mul   : out std_logic_vector(5 downto 0);
		sel_m_out : out std_logic
		);
end entity;

architecture behave of dataflow is

signal r1 : std_logic_vector(1 downto 0);
signal r2 : std_logic_vector(1 downto 0);
signal r3 : std_logic_vector(2 downto 0);
signal r4 : std_logic_vector(2 downto 0);

signal add_int : std_logic_vector(2 downto 0);
signal mul_int : std_logic_vector(2 downto 0);

signal sel_a : std_logic;
signal sel_m : std_logic;
signal cnt_int : std_logic_vector(2 downto 0);
signal mux_aout : std_logic_vector(5 downto 0);
signal mux_mout : std_logic_vector(5 downto 0);


begin

process(clk,rst)
begin
    if rst = '1' then
	r1 <= (others=> '0');
	r2 <= (others=> '0');
	r3 <= (others=> '0');
	r4 <= (others=> '0');
	elsif rising_edge (clk) then
	r1 <= d1;
	r2 <= d2;
	r3 <= d3;
	r4 <= d4;
	end if;
end process;

add_int <= ext (r1,3) + ext (r2,3);
mul_int <= r3*r4;

process(clk, rst)
begin
    if rst = '1' then
	    cnt_int <= (others => '0');
	elsif rising_edge (clk) then
	    if en = '1' then
		    cnt_int <= cnt_int + 1;
		else 
		    cnt_int <= cnt_int;
		end if;
	end if;
end process;

sel_m <= '1' when cnt_int="000" or cnt_int="001" or cnt_int="010" or cnt_int="011" else '0';
sel_a <= '1' when cnt_int="100" or cnt_int="101" or cnt_int="110" or cnt_int="111" else '0';
clk2 <= cnt_int(1);

sel_proc: process(clk,rst)
	begin
		if 	rst = '1' then
			mux_aout <= (others => '0');
		elsif rising_edge (clk) then
			if sel_a = '1' then
				mux_aout <= add_int;
			else
				mux_aout <= mul_int;
			end if;
		end if;
	end process;
	
sel2_proc: process(clk,rst)
	begin
		if 	rst = '1' then
			mux_mout <= (others => '0');
		elsif rising_edge (clk) then
			if sel_m = '1' then
				mux_mout <= add_int;
			else
				mux_aout <= mul_int;
			end if;
		end if;
	end process;
	
--clk2 <= cnt_int(1);
	
process(rst,clk)
begin
    if rst = '1' then
	    sel_a_out <= '0';
		D_add <= (others => '0');
		D_mul <= (others => '0');
		sel_m_out <= '0';
	elsif rising_edge(clk2) then
	   sel_a_out <= sel_a;
	   D_add <= mux_aout;
	   D_mul <= mux_mout;
	   sel_m_out <= sel_m;
	end if ;
end process;

end behave;	
	
	
	
