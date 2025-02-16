library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Include the numeric_std library for to_unsigned

entity SM_tb is
end SM_tb;

architecture Behavioral of SM_tb is
    signal clk       : std_logic := '0';
    signal s_in      : std_logic_vector(11 downto 0) := (others => '0');
    signal enable    : std_logic := '0';
    signal start     : std_logic := '0';
    signal reset     : std_logic := '0';
    signal s_out     : std_logic_vector(11 downto 0);
    signal stop_out  : std_logic;
    signal done_out  : std_logic;
    signal alarm     : std_logic; -- New alarm signal

    -- Clock period definition
    constant clk_period : time := 10 ns;

    -- Component Declaration for the Unit Under Test (UUT)
    component SM is
        generic (
            N : integer := 12
        );
        port (
            clk      : in  std_logic;
            s_in     : in  std_logic_vector(N-1 downto 0);
            enable   : in  std_logic;
            start    : in  std_logic;
            reset    : in  std_logic;
            s_out    : out std_logic_vector(N-1 downto 0);
            stop_out : out std_logic;
            done_out : out std_logic;
            alarm    : out std_logic -- New alarm signal
        );
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: SM
        generic map (
            N => 12
        )
        port map (
            clk       => clk,
            s_in      => s_in,
            enable    => enable,
            start     => start,
            reset     => reset,
            s_out     => s_out,
            stop_out  => stop_out,
            done_out  => done_out,
            alarm     => alarm -- Connect alarm signal
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process to test the state machine
    stim_proc: process
    begin
        -- Initialize Inputs
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Test correct password
        enable <= '1';
        wait for clk_period;
        enable <= '0';

        s_in <= "000010010111"; -- Correct password
        start <= '1';
        wait for clk_period;
        start <= '0';

        -- Wait for state machine to process
        wait for 100 ns;

        -- Test incorrect password (all bits wrong)
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        enable <= '1';
        wait for clk_period;
        enable <= '0';

        s_in <= "111111111111"; -- Incorrect password
        start <= '1';
        wait for clk_period;
        start <= '0';

        -- Wait for state machine to process
        wait for 100 ns;

        -- Test incorrect password (partially correct)
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        enable <= '1';
        wait for clk_period;
        enable <= '0';

        s_in <= "000010010110"; -- Incorrect password (one bit wrong)
        start <= '1';
        wait for clk_period;
        start <= '0';

        -- Wait for state machine to process
        wait for 100 ns;

        -- Test another random incorrect password
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        enable <= '1';
        wait for clk_period;
        enable <= '0';

        s_in <= "101010101010"; -- Incorrect password (random)
        start <= '1';
        wait for clk_period;
        start <= '0';

        -- Wait for state machine to process
        wait for 100 ns;

        -- Test with no input
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        enable <= '1';
        wait for clk_period;
        enable <= '0';

        s_in <= (others => '0'); -- No input
        start <= '1';
        wait for clk_period;
        start <= '0';

        -- Wait for state machine to process
        wait for 100 ns;

        -- Test with different random inputs
        for i in 0 to 15 loop
            reset <= '1';
            wait for 20 ns;
            reset <= '0';

            enable <= '1';
            wait for clk_period;
            enable <= '0';

            s_in <= std_logic_vector(to_unsigned(i, 12)); -- Random inputs
            start <= '1';
            wait for clk_period;
            start <= '0';

            -- Wait for state machine to process
            wait for 100 ns;
        end loop;

        -- Stop the simulation
        wait;
    end process;

end Behavioral;
