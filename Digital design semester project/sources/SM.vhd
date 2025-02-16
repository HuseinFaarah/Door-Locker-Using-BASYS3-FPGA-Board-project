library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state is
    generic (
        N : integer := 12
    );
    port ( 
        clk         : in  std_logic;
        s_in        : in  std_logic_vector (N-1 downto 0);
        enable      : in  std_logic;
        start       : in  std_logic;
        reset       : in  std_logic;
        s_out       : out std_logic_vector (N-1 downto 0) := (others => '0');
        stop_out    : out std_logic_vector (N-1 downto 0) := (others => '0');
        done_out    : out std_logic := '0'
    );
end state;

architecture Behavioral of state is

    signal counter      : integer range 0 to N-1 := 0;
    constant counter_max: integer := N-1;
    signal password     : std_logic_vector (N-1 downto 0) := "000010010111"; 

    type State_Type is (Idle, Waiting, Stop, Checking, Unlocked);
    signal State : State_Type := Idle;

begin
    P_MAIN: process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                State <= Idle;
                counter <= 0;
                s_out <= (others => '0');
                stop_out <= (others => '0');
                done_out <= '0';
            else
                case State is
                    when Idle =>
                        if enable = '1' then
                            State <= Waiting;
                        end if;                  

                    when Waiting =>
                        if start = '1' then
                            State <= Checking;    
                        end if;
                
                    when Checking =>
                        if (s_in(counter) = password(counter)) then
                            s_out(counter) <= '1';
                            counter <= counter + 1;
                            if counter = counter_max then
                                done_out <= '1';
                                State <= Unlocked;
                            end if;
                        else
                            stop_out(counter) <= '1';
                            State <= Stop;
                        end if;

                    when Unlocked =>
                        if reset = '1' then
                            counter <= 0;
                            s_out <= (others => '0');
                            done_out <= '0';
                            State <= Idle;
                        end if;
                    
                    when Stop =>
                        if reset = '1' then
                            counter <= 0;
                            stop_out <= (others => '0');
                            s_out <= (others => '0');
                            State <= Idle;
                        end if;

                end case;
            end if;
        end if;
    end process;
end Behavioral;
