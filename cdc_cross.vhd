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

-- vector_width > 1 only works correctly for Gray-coded vectors
entity cdc_cross is
    Generic ( vector_width: natural := 1;
              bypass_src_reg: boolean := false);
    Port ( clk_old : in STD_LOGIC;
           clk_new : in STD_LOGIC;
           async_in : in STD_LOGIC_VECTOR (vector_width-1 downto 0);
           sync_out : out STD_LOGIC_VECTOR (vector_width-1 downto 0));
end cdc_cross;

architecture Behavioral of cdc_cross is
    signal old_stable: STD_LOGIC_VECTOR (vector_width-1 downto 0);
    signal new_metastable: STD_LOGIC_VECTOR (vector_width-1  downto 0);
    signal new_stable: STD_LOGIC_VECTOR (vector_width-1 downto 0);
    attribute ASYNC_REG : string;
    attribute ASYNC_REG of old_stable: signal is "TRUE";
    attribute ASYNC_REG of new_metastable: signal is "TRUE";
    attribute ASYNC_REG of new_stable: signal is "TRUE";
begin
    src_reg_gen: if not bypass_src_reg generate
    process(clk_old) is
    begin
        if rising_edge(clk_old) then
            old_stable <= async_in;
        end if;
    end process;
    end generate;

    src_wire_gen: if bypass_src_reg generate
    old_stable <= async_in;
    end generate;

    cdc_dest_regs: process(clk_new) is
    begin
        if rising_edge(clk_new) then
            new_metastable <= old_stable;
            new_stable <= new_metastable;
        end if;
    end process;
    sync_out <= new_stable;
end Behavioral;
