library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rregister is
generic (
N : integer := 12
);
port ( 
clk         :   in  std_logic;
r_in        :   in  std_logic_vector (N-1 downto 0);
enable      :   in  std_logic;
reset       :   in  std_logic;

r_out       :   out  std_logic_vector (N-1 downto 0)
);
end rregister;

architecture Behavioral of rregister is

signal rin :  STD_LOGIC_vector (N-1 downto 0) := "000000000000";

begin
P_MAIN : process (clk) begin
if rising_edge(clk) then

    if reset = '0' then
        if enable = '1' then
            rin <= r_in;
        end if;  
    else
            rin <= "000000000000";
            
        if enable = '1' then
            rin <= r_in;
        end if;  
    end if;  
end if;
end process;

r_out <= rin;

end Behavioral;