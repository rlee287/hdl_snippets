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
-- Revision 0.10 - Mark proper async reset and internal clock divider
-- Revision 0.20 - Rename inputs and add DP, add to repo
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hex_display is
    Generic ( clk_rollover : natural := 13 );
    Port ( clk : in STD_LOGIC;
           enable: in STD_LOGIC := '1';
           data : in STD_LOGIC_VECTOR (15 downto 0);
           dp_arr : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0);
           anodes : out STD_LOGIC_VECTOR (3 downto 0);
           dp : out STD_LOGIC);
end hex_display;

architecture Behavioral of hex_display is
    signal current_active_segment : BIT_VECTOR (3 downto 0) := "1110";
    signal clk_counter : UNSIGNED (15 downto 0) := (others => '0');
    signal prev_bit : STD_LOGIC := '0';
    
    pure function map_hex (data_val : in STD_LOGIC_VECTOR(3 downto 0))
        return STD_LOGIC_VECTOR is --6 downto 0)
    begin
        
    case (data_val) is
        when "0000" =>
            return "1000000";
        when "0001" =>
            return "1111001";
        when "0010" =>
            return "0100100";
        when "0011" =>
            return "0110000";
        when "0100" =>
            return "0011001";
        when "0101" =>
            return "0010010";
        when "0110" =>
            return "0000010";
        when "0111" =>
            return "1111000";
        when "1000" =>
            return "0000000";
        when "1001" =>
            return "0010000";
        when "1010" =>
            return "0001000";
        when "1011" =>
            return "0000011";
        when "1100" =>
            return "1000110";
        when "1101" =>
            return "0100001";
        when "1110" =>
            return "0000110";
        when "1111" =>
            return "0001110";
        when others =>
            return "1111111";
    end case;
    end;
begin
    clk_div:process(clk) is
    begin
        if enable = '0' then
            clk_counter <= (others => '0');
        elsif rising_edge(clk) then
            clk_counter <= clk_counter + 1;
        end if;
    end process;
    
    process(clk, enable) is
        variable active_segment_loc: natural range 0 to 3;
    begin
        if enable = '0' then
            segments <= (others => '1');
            anodes <= (others => '1');
            dp <= '1';
            prev_bit <= '0';
        elsif rising_edge(clk) then
            if clk_counter(CLK_ROLLOVER) = '1' and prev_bit = '0' then
                if current_active_segment = "1110" then
                    segments <= map_hex(data(3 downto 0));
                    active_segment_loc := 0;
                elsif current_active_segment = "1101" then
                    segments <= map_hex(data(7 downto 4));
                    active_segment_loc := 1;
                elsif current_active_segment = "1011" then
                    segments <= map_hex(data(11 downto 8));
                    active_segment_loc := 2;
                elsif current_active_segment = "0111" then
                    segments <= map_hex(data(15 downto 12));
                    active_segment_loc := 3;
                else 
                    segments <= "0001001";
                end if;
                anodes <= to_stdlogicvector(current_active_segment);
                dp <= not dp_arr(active_segment_loc);
                current_active_segment <= current_active_segment rol 1;
            end if;
            prev_bit <= clk_counter(CLK_ROLLOVER);
        end if;
    end process;
end Behavioral;