library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

 


entity df_fsm_tb is 
end entity;

 

architecture behave of df_fsm_tb is

 

component dataflow 
generic(width : integer := 8);
Port (    
    Clk        : in STD_LOGIC;
    Rst        : in STD_LOGIC;
    Rdd        : in STD_LOGIC;
    Wrt        : in STD_LOGIC;
    sel        : in std_logic;
    RnW        : out STD_LOGIC;
    data_a    : in std_logic_vector(width-1 downto 0);
    data_b    : in std_logic_vector(width-1 downto 0);
    Bus_id    : out std_logic_vector(width downto 0);
    Clk2    : out std_logic;
    Rstn    : out std_logic
    );
end component;

 

component statemachine 
generic(width : integer := 8);
Port (    
    Clk2    : in STD_LOGIC;
    Rstn    : in STD_LOGIC;
    RnW        : in STD_LOGIC;
    Bus_id    : in std_logic_vector(width downto 0);
    OE        : out std_logic;
    WRE        : out std_logic
    );
end component;

 


    constant clk_per: time := 40 ns;
    constant width : integer :=8;
    
    signal clk_sim    : std_logic := '1';
    signal rst_sim    : std_logic;
    signal rdd_sim    : std_logic;
    signal wrt_sim    : std_logic;
    signal sel_sim    : std_logic;
    signal bus_id_con : std_logic_vector(width downto 0);
    signal rnw_con    : std_logic;
    signal data_a_sim : std_logic_vector(width-1 downto 0);
    signal data_b_sim : std_logic_vector(width-1 downto 0);
    signal oe_sim     : std_logic;
    signal wre_sim     : std_logic;
    signal clk2_con    : std_logic;
    signal rstn_con    :std_logic;

 

begin 

 

dataflow_inst : dataflow 
                generic map(width => 8)
                port map (
                            clk        => clk_sim,
                            rst        => rst_sim,
                            rdd        => rdd_sim,
                            wrt        => wrt_sim,
                            sel        => sel_sim,
                            rnw        => rnw_con,
                            data_a    => data_a_sim,
                            data_b    => data_b_sim,
                            bus_id    => bus_id_con,
                            clk2    => clk2_con,
                            rstn    => rstn_con
                            );

 

statemachine_inst : statemachine 
                        generic map(width => 8)
                        port map (
                                clk2    => clk2_con,
                                rstn    => rstn_con,
                                rnw        => rnw_con,
                                bus_id    => bus_id_con,
                                oe        => oe_sim,
                                wre        => wre_sim
                             );
                             
                             

 

clk_proc: process
begin
    wait for clk_per/2;
    clk_sim <= not clk_sim;
end process;

 

reset_proc: process
begin
    rst_sim <= '1';
    wait for (15*clk_per);
    rst_sim <= not rst_sim;
    wait;
end process; 

 

  data_a_sim <=  x"00",
                 x"cc" after (20*clk_per),
                 x"c0" after (25*clk_per),
                 x"cc" after (30*clk_per),
                 x"0c" after (60*clk_per),
                 x"cc" after (64*clk_per),
                 x"c0" after (71*clk_per);
                
  data_b_sim <=  x"00",
                 x"df" after (23*clk_per),
                 x"cc" after (35*clk_per);
                
  rdd_sim   <= '0',
              '1' after (25*clk_per),
              '0' after (33*clk_per);
             
  wrt_sim   <= '0',
              '1' after (25*clk_per),
              '0' after (32*clk_per),
              '1' after (33*clk_per);
             
 sel_sim   <= '0',
               '1' after (26*clk_per),
               '0' after (32*clk_per),
               '1' after (42*clk_per),
               '0' after (54*clk_per);
end behave;