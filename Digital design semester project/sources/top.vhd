library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
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
end top;

architecture Behavioral of top is
-----------------------------------------------------------------------
--------------------------SIGNAL ASSIGNMENTS---------------------------
-----------------------------------------------------------------------
signal clk_ou       :   STD_LOGIC;
signal done_ou      :   STD_LOGIC;
signal r_ou         :   STD_LOGIC_vector (N-1 downto 0);
signal led_ou       :   STD_LOGIC_vector (N-1 downto 0);
signal stop_ou      :   STD_LOGIC_vector (N-1 downto 0);



-----------------------------------------------------------------------
----------------------COMPONENT DECLERATIONS---------------------------
-----------------------------------------------------------------------
component clk1Hz is
    Port (
        clk_in          : in  STD_LOGIC;
        clk_ouT         : out STD_LOGIC
    );
end component;

component rregister is
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
end component;

component state is
generic (
N : integer := 12
);
port ( 
clk         :   in  std_logic;
s_in        :   in  std_logic_vector (N-1 downto 0);
enable      :   in  std_logic;
start       :   in  std_logic;
reset       :   in  std_logic;

s_out       :   out  std_logic_vector (N-1 downto 0);
stop_out    :   out  std_logic_vector (N-1 downto 0);
done_out    :   out  std_logic
);
end component;

begin

clkdiv : clk1Hz
Port map (         
    clk_in     => clk,
    clk_out    => clk_ou
);             


reegister : rregister
port map(          
clk        =>  clk_ou, 
r_in       =>  sw, 
enable     =>  enable, 
reset      =>  reset, 
      
r_out      =>  r_ou 
); 

sstate : state   
port map (      
clk      =>   clk_ou, 
s_in     =>   r_ou ,
enable   =>   enable, 
start    =>   start,
reset    =>   reset,
         
s_out    =>   led_ou ,          
stop_out =>   stop_ou  ,
done_out =>   done_ou         
);    
      
P_MAIN : process (clk) begin
if rising_edge(clk) then
    if (stop_ou = "000000000000") then
        stop_o <= '0';
   else
        stop_o <= '1';
   end if; 
end if;
end process;   
       
clk_o   <= clk_ou;
led     <= led_ou;
done_o  <= done_ou;

end Behavioral;