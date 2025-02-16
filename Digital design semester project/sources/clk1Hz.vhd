library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk1Hz is
    Port (
        clk_in          : in  STD_LOGIC;
        clk_out         : out STD_LOGIC
    );
end clk1Hz;

architecture Behavioral of clk1Hz is
    signal temporal     : STD_LOGIC := '0';
    signal counter      : integer range 0 to 49_999_999 := 0;

    
begin
    frequency_divider: process (clk_in) begin

       if rising_edge(clk_in) then
            if (counter = 49_999_999) then
                temporal    <= NOT(temporal);
                counter     <= 0;
            else
                counter     <= counter + 1;
            end if;
        end if;
    end process;
    
    

    clk_out <= temporal;
  
end Behavioral;