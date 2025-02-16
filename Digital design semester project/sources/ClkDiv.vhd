LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkDiv is
    port (
        clk1 : in std_logic;
        clk : out std_logic
    );
end ClkDiv;

architecture Behavioral of ClkDiv is
    signal count : std_logic_vector(25 downto 0) := (others => '0');
    signal b : std_logic := '0';
begin
    -- Clock generation. For simulation, we use a smaller count value.
    process(clk1)
    begin
        if rising_edge(clk1) then
            if count = X"0003D090" then  -- Reduced count for faster simulation (250,000 in decimal)
                b <= not b;
                count <= (others => '0');
            else
                count <= count + 1;
            end if;
        end if;
        clk <= b;
    end process;
end Behavioral;