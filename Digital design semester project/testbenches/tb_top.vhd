library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top is
end tb_top;

architecture Behavioral of tb_top is

    -- Component declaration for the Unit Under Test (UUT)
    component top is
        generic (
            N : integer := 12
        );
        port (
            clk         :   in  std_logic;
            sw          :   in  std_logic_vector (N-1 downto 0);
            enable      :   in  std_logic;
            start       :   in  std_logic;
            reset       :   in  std_logic;

            led         :   out  std_logic_vector (N-1 downto 0);
            clk_o       :   out  std_logic;
            stop_o      :   out  std_logic;
            done_o      :   out  std_logic
        );
    end component;

    -- Testbench signals
    signal clk_tb        : std_logic := '0';
    signal sw_tb         : std_logic_vector(11 downto 0) := (others => '0');
    signal enable_tb     : std_logic := '0';
    signal start_tb      : std_logic := '0';
    signal reset_tb      : std_logic := '0';
    signal led_tb        : std_logic_vector(11 downto 0);
    signal clk_o_tb      : std_logic;
    signal stop_o_tb     : std_logic;
    signal done_o_tb     : std_logic;

    -- Clock period definition
    constant clk_period  : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: top
        generic map (
            N => 12
        )
        port map (
            clk     => clk_tb,
            sw      => sw_tb,
            enable  => enable_tb,
            start   => start_tb,
            reset   => reset_tb,
            led     => led_tb,
            clk_o   => clk_o_tb,
            stop_o  => stop_o_tb,
            done_o  => done_o_tb
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk_tb <= '0';
        wait for clk_period / 2;
        clk_tb <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
    
        -- Initialize Inputs
        reset_tb <= '0';
        enable_tb <= '0';
        start_tb <= '0';
        sw_tb <= (others => '0');
        wait for 100 ns;
        
        -- Apply reset
        reset_tb <= '1';
        wait for 100 ns;
        reset_tb <= '0';
        wait for 100 ns;
        
        -- Enable the system
        enable_tb <= '1';
        wait for 100 ns;
        enable_tb <= '0';
        wait for 100 ns;

        -- Enter the correct password
        sw_tb <= "000010010111"; -- Your password
        wait for 100 ns;
        enable_tb <= '1';
        wait for 100 ns;
        enable_tb <= '0';
        wait for 100 ns;

        -- Start the state machine
        start_tb <= '1';
        wait for 100 ns;
        start_tb <= '0';
        wait for 500 ns;

        -- Check the result
        assert (done_o_tb = '1') report "Password Match Failed!" severity error;

        -- Apply reset
        reset_tb <= '1';
        wait for 100 ns;
        reset_tb <= '0';
        wait for 100 ns;

        -- Enter an incorrect password
        sw_tb <= "000010010110"; -- Incorrect password
        wait for 100 ns;
        enable_tb <= '1';
        wait for 100 ns;
        enable_tb <= '0';
        wait for 100 ns;

        -- Start the state machine
        start_tb <= '1';
        wait for 100 ns;
        start_tb <= '0';
        wait for 500 ns;

        -- Check the result
        assert (stop_o_tb = '1') report "Incorrect Password Failed!" severity error;

        -- Observe the LEDs and other outputs
        wait for 250 ms;

        -- End simulation
        wait;
    end process;

end Behavioral;
