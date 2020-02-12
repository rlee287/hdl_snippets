----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/28/2019 12:54:08 PM
-- Design Name: 
-- Module Name: delay_reset - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity delay_reset is
    Port ( clk : in STD_LOGIC;
           reset_in : in STD_LOGIC;
           reset_out : out STD_LOGIC);
end delay_reset;

architecture Behavioral of delay_reset is
    signal in_reset: STD_LOGIC;
    signal reset_ctr: UNSIGNED(1 downto 0);
begin
    process(clk) is
    begin
        if rising_edge(clk) then
            if in_reset = '0' then
                reset_ctr <= (others => '0');
                if reset_in = '1' then
                    reset_ctr <= reset_ctr + 1;
                    if (reset_ctr >= 3) then
                        in_reset <= '1';
                    end if;
                end if;
            else
                reset_ctr <= (others => '0');
                if reset_in = '0' then
                    in_reset <= '0';
                end if;
            end if;
        end if;
    end process;
    
    reset_out <= in_reset;
end Behavioral;
