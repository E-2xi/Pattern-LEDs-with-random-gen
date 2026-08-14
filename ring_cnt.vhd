library ieee; 
use ieee.std_logic_1164.all; 

-- cnt is counter

entity ring_cnt is 
	port( clk, rst : in std_logic;
			cnt		: out std_logic_vector(9 downto 0)
		 ); 
end entity ring_cnt; 

architecture count of ring_cnt is 
	signal s_cnt :  std_logic_vector(9 downto 0); 
begin 
	counting: process(clk, rst)
	begin 
		if rst = '0' then
			s_cnt <= (others => '0');
		elsif rising_edge(clk) then -- this process is a repeat itself so you will see a patten of red leds
			if s_cnt = "0000000001" then s_cnt <= "0000000010";
			elsif s_cnt = "0000000010" then s_cnt <= "0000000100";
			elsif s_cnt = "0000000100" then s_cnt <= "0000001000";
			elsif s_cnt = "0000001000" then s_cnt <= "0000010000";
			elsif s_cnt = "0000010000" then s_cnt <= "0000100000";
			elsif s_cnt = "0000100000" then s_cnt <= "0001000000";
			elsif s_cnt = "0001000000" then s_cnt <= "0010000000";
			elsif s_cnt = "0010000000" then s_cnt <= "0100000000";
			elsif s_cnt = "0100000000" then s_cnt <= "1000000000";
			elsif s_cnt = "1000000000" then s_cnt <= "0000000001";
			else s_cnt <= "0000000001";
			end if;
		end if;
	end process;
	cnt <= s_cnt;

end architecture count; 