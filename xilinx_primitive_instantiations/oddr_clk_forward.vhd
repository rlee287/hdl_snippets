----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2020 10:21:55 AM
-- Design Name: 
-- Module Name: oddr_clk_forward - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity oddr_clk_forward is
    Port ( clkin : in STD_LOGIC;
           clken : in STD_LOGIC;
           clkout : out STD_LOGIC);
end oddr_clk_forward;

architecture Behavioral of oddr_clk_forward is
begin
   ODDR_inst : ODDR
   generic map(
      DDR_CLK_EDGE => "OPPOSITE_EDGE", -- "OPPOSITE_EDGE" or "SAME_EDGE" 
      INIT => '0',   -- Initial value for Q port ('1' or '0')
      SRTYPE => "SYNC") -- Reset Type ("ASYNC" or "SYNC")
   port map (
      Q => clkout,  -- 1-bit DDR output
      C => clkin,   -- 1-bit clock input
      CE => clken,  -- 1-bit clock enable input
      D1 => '1',    -- 1-bit data input (positive edge)
      D2 => '0',    -- 1-bit data input (negative edge)
      R => '0',     -- 1-bit reset input
      S => '0'      -- 1-bit set input
   );
end Behavioral;
