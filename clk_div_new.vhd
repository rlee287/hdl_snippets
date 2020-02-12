----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2019 01:43:33 PM
-- Design Name: 
-- Module Name: hex_display - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Update capitalization, etc. for repository
-- Additional Comments:
-- Code review at
-- https://codereview.stackexchange.com/questions/230323/hardware-clock-divider
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_div is
    port (
        clk : in STD_LOGIC;
        divfactor : in STD_LOGIC_VECTOR (15 downto 0); -- Note this is actually not a factor!
        clkout : out STD_LOGIC);
end entity;

architecture Behavioral of clk_div is
    use IEEE.NUMERIC_STD.ALL;
    signal clk_counter : UNSIGNED(15 downto 0) := (others => '0');
    signal div_clk : STD_LOGIC := '1';

    signal divider_disabled : STD_LOGIC := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if divfactor = x"0000" then
                divider_disabled <= '1';
                clk_counter <= (others => '0'); -- Own addition
            else
                divider_disabled <= '0';
                if clk_counter = 0 then
                    clk_counter <= unsigned(divfactor) - 1;
                    div_clk <= not div_clk;
                else
                    clk_counter <= clk_counter - 1;
                end if;
            end if;
        end if;
    end process;

    clkout <= clk when divider_disabled = '1' else div_clk;
end architecture;