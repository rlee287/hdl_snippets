----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2020 02:40:51 PM
-- Design Name: 
-- Module Name: cdc_cross - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cdc_cross is
    Generic (vector_width: natural := 1);
    Port ( clk_new : in STD_LOGIC;
           async_in : in STD_LOGIC_VECTOR (vector_width-1 downto 0);
           sync_out : out STD_LOGIC_VECTOR (vector_width-1 downto 0));
end cdc_cross;

architecture Behavioral of cdc_cross is
    signal input_async: STD_LOGIC_VECTOR (vector_width-1  downto 0);
    signal input_sync: STD_LOGIC_VECTOR (vector_width-1 downto 0);
    attribute ASYNC_REG : string;
    attribute ASYNC_REG of input_async: signal is "TRUE";
    attribute ASYNC_REG of input_sync: signal is "TRUE";
begin
    process(clk_new) is
    begin
        if rising_edge(clk_new) then
            input_async <= async_in;
            input_sync <= input_async;
        end if;
    end process;
    sync_out <= input_sync;
end Behavioral;
