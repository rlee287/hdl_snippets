----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/07/2019 12:58:23 PM
-- Design Name: 
-- Module Name: monostable_pulse - RTL
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - Clean up and add to repo
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity monostable_pulse is
    Port ( clk : in STD_LOGIC;
           trig : in STD_LOGIC;
           reset : in STD_LOGIC;
           pulse_len: in STD_LOGIC_VECTOR (15 downto 0);
           pulse : out STD_LOGIC;
           pulse_bar: out STD_LOGIC;
           pulse_counter_debug: out STD_LOGIC_VECTOR(15 downto 0));
end monostable_pulse;

architecture RTL of monostable_pulse is
    signal pulse_counter : UNSIGNED (15 downto 0) := (others => '0');
begin
    process(clk) is
    begin
        -- Default values
        pulse <= '0';
        pulse_bar <= '1';
        pulse_counter_debug <= (others => '0');
        -- Sequential logic follows (rising edge so far)
        if (rising_edge(clk)) then
            if (reset = '1') then
                pulse_counter <= (others => '0');
            else
                if (trig = '1' and pulse_counter = 0) then
                    pulse <= '1';
                    pulse_bar <= '0';
                    pulse_counter <= pulse_counter + 1;
                end if;
                -- Below if statement will update on next clock cycle because has_pulsed is a signal
                if (pulse_counter > 0) then
                    if (pulse_counter >= unsigned(pulse_len)) then
                        pulse <= '0';
                        pulse_bar <= '1';
                        if (trig = '0') then
                            pulse_counter <= (others => '0');
                        end if;
                    else
                        pulse <= '1';
                        pulse_bar <= '0';
                        pulse_counter <= pulse_counter + 1;
                    end if;
                end if;
                pulse_counter_debug <= std_logic_vector(pulse_counter);
            end if;
        end if;
    end process;
end RTL;
