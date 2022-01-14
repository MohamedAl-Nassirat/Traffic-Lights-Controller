----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/25/2021 10:47:12 AM
-- Design Name: 
-- Module Name: LAB4_PKG - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package LAB4_PKG is

  constant count_for_1Hz: natural:=64000000; --64000000, reduce this number to 1000 for simulation.
  subtype Three_Bit_Vector_Type is std_logic_vector(2 downto 0);
  subtype Seven_Bit_Vector_Type is std_logic_vector(6 downto 0);
  constant Seven_seg_0: Seven_Bit_Vector_Type :="0111111"; 
  constant Seven_seg_1: Seven_Bit_Vector_Type :="0000110"; 
  constant Seven_seg_2: Seven_Bit_Vector_Type :="1011011"; 
  constant Seven_seg_3: Seven_Bit_Vector_Type :="1001111"; 
  constant Seven_seg_4: Seven_Bit_Vector_Type :="1100110"; 
  constant Seven_seg_5: Seven_Bit_Vector_Type :="1101101"; 
  constant Seven_seg_off: Seven_Bit_Vector_Type :="0000000"; 

  
  component traffic_intersection is
    Port ( 
            clk, EMV, Change, reset, btn:    in STD_LOGIC;       -- btn press to see traffic light status for secondary road.
                                                    
            led6_r, led6_g ,led6_b : out STD_LOGIC:='0';         --Traffic light status             
            led:        out Three_Bit_Vector_Type;  --Monitor states [ led(0)-led(2) ] 
            CC :        out STD_LOGIC;                     --Common cathode input to select respective 7-segment digit.
            out_7seg :  out Seven_Bit_Vector_Type   -- Output  signal for selected 7 Segment display. 
           );
  end component traffic_intersection;
  
end LAB4_PKG;


