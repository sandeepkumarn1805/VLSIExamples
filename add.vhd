library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity add is 
        port(
		cnt1_v :in std_logic_vector(2 downto 0);
		cnt2_v :in std_logic_vector(4 downto 0);
		clk2 : in std_logic;
		rstn : in std_logic;
		en_m1 : in std_logic;
		en_m2 : in std_logic;
		d_out : out std_logic_vector(9 downto 0)
		);
end entity;

architecture behave of add is 

signal r1 : std_logic_vector(2 downto 0);
signal r2 : std_logic_vector(4 downto 0);
signal m1 : std_logic_vector(4 downto 0);
signal mu1 : std_logic_vector(9 downto 0);
signal a1 : std_logic_vector(5 downto 0);

begin

process(clk2,rstn)
begin
    if rstn = '0' then
	    r1 <= (others => '0');
		r2 <= (others => '0');
	elsif rising_edge (clk2) then
	    r1 <= cnt1_v;
		r2 <= cnt2_v;
	end if;
end process;

process(clk2,rstn)
begin
    if rstn = '0' then
	    m1 <= (others => '0');
	elsif rising_edge (clk2) then
	    if en_m1 = '1' then
		    m1 <= r1;
		else 
		    m1 <= r2;
		end if;
	end if;
end process;

a1 <= ext (m1,6) + ext (r2,6);

mu1 <= m1*r2;

process(clk2,rstn)
begin
    if rstn = '0' then
	    D_out <= (others => '0');
	elsif rising_edge (clk2) then
	    if en_m2 = '1' then
		    d_out <= a1;
		else 
		    d_out <= mu1;
		end if;
	end if;
end process;

end behave;
    	
		