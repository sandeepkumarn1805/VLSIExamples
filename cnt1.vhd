library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity cnt1 is 
        port(
		    clk1 : in std_logic;
			rst  : in std_logic;
			en   : in std_logic;
			rstn : out std_logic;
			clk2 : out std_logic;
			cnt1_v : out std_logic_vector(2 downto 0);
			en_m1 : out std_logic;
			en_m2 : out std_logic;
			cnt2_v : out std_logic_vector(4 downto 0)
			);
end entity;

architecture behave of cnt1 is

signal en2 : std_logic;
signal cnt1 : std_logic_vector(2 downto 0);
signal cnt2 : std_logic_vector(4 downto 0);

begin

cnt1_proc : process (clk1,rst)
begin 
    if rst ='1' then
        cnt1 <= (others => '0');
    elsif rising_edge (clk1) then
	    if en = '1' then
            cnt1 <= cnt1+ 1;
		else 
		    cnt1 <= cnt1;
		end if;
	end if;
end process;

en2 <= '1' when cnt1 = "101" else '0';
cnt1_v <= cnt1;
clk2 <= cnt1(1);
rstn <= not rst;

cnt2_proc : process (clk1,rst)
begin
    if rst = '1' then
	    cnt2 <= (others => '0');
	elsif rising_edge (clk1) then
	    if en2 = '1' then
		    cnt2 <= cnt2 +1;
		else 
		    cnt2 <= cnt2;
		end if;
	end if;
end process;

cnt2_v <= cnt2;
en_m1 <= '1' when cnt2 = "111" else '0';
en_m2 <= '1' when cnt2 = "1111" else '0';

end behave;
    
    		