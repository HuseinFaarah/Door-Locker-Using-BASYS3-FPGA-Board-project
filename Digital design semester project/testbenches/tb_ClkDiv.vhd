LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_ClkDiv IS
END tb_ClkDiv;

ARCHITECTURE behavior OF tb_ClkDiv IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ClkDiv
    PORT(
         clk1 : IN  std_logic;
         clk : OUT  std_logic
        );
    END COMPONENT;
    

   -- Inputs
   signal clk1 : std_logic := '0';

   -- Outputs
   signal clk : std_logic;

   -- Clock period definitions
   constant clk1_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
   uut: ClkDiv PORT MAP (
          clk1 => clk1,
          clk => clk
        );

   -- Clock process definitions
   clk1_process :process
   begin
        clk1 <= '0';
        wait for clk1_period/2;
        clk1 <= '1';
        wait for clk1_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin        
      -- Insert stimulus here 
      wait for 10 ms;  -- Run the simulation for 10 milliseconds
      
      -- Finish the simulation
      wait;
   end process;

END;