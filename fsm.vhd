library ieee; 
use ieee.std_logic_1164.all; 
-- ledr is a red LED
-- cnt is a short for counter
-- button 0 as known key[0] is reset 
-- button 1 as known key[1] is button with three different mode 
entity fsm is 
	port(btn, clk, rst : in std_logic; 
	     LEDR	   : out std_logic_vector (9 downto 0) 
	     ); 
end entity fsm;

architecture struct of fsm is 

	-- Component declarations 
	component clk_fsm is 
		port (btn, rst, clk : in std_logic; 
			   clk_out  : out std_logic
		); 
	end component; 
	
	component ring_cnt is 
		port( clk, rst : in std_logic;
			   cnt		: out std_logic_vector(9 downto 0)
		 );
	end component; 
	
	signal s_btn, s_clk, s_rst, s_clk_out : std_logic; 
	signal s_ledr : std_logic_vector(9 downto 0); 
	
	begin 
		-- m_clk_fsm: work.clk_fsm(divide) port map (btn=>s_btn, clk=>s_clk,
		--					  rst=>s_rst, clk_out=>s_clk_out); 
		
		m_clk_fsm: entity work.clk_fsm(divide) 
			   port map (
				     btn=>s_btn, 
				     clk=>s_clk,
				     rst=>s_rst, 
			             clk_out=>s_clk_out); 

--		m_clk_fsm: clk_fsm -- if using component declaration instead of direct instantiation 
--			   port map (
--				     btn=>s_btn, 
--				     clk=>s_clk,
--				     rst=>s_rst, 
--			             clk_out=>s_clk_out); 

		m_ring_cnt: entity work.ring_cnt(count) 
			    port map (
				      clk=>s_clk_out, 
				      rst=>s_rst,
				      cnt=>s_ledr); 
	
		s_btn <= btn; 
		s_rst <= rst;
		s_clk <= clk;
		LEDR <= s_ledr; 
end struct; 