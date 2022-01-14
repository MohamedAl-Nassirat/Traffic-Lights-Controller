----------------------------------------------------------------------------------
-- Company: University of Alberta
-- Engineer: Fudong Li
-- 
-- Create Date: 05/11/2018 11:22:20 AM
-- Design Name: 
-- Module Name: traffic_intersection - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.LAB4_PKG.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic_intersection is
    Port ( 
            clk, EMV, Change, reset, btn:    in STD_LOGIC;       -- btn press to see traffic light status for secondary road.
                                                    
            led6_r, led6_g ,led6_b : out STD_LOGIC:='0';         --Traffic light status             
            led:        out Three_Bit_Vector_Type;  --Monitor states [ led(0)-led(2) ] . Three_Bit_Vector_Type is defined as STD_LOGIC_VECTOR(2 downto 0) in LAB4_PKG.
            CC :        out STD_LOGIC;                     --Common cathode input to select respective 7-segment digit.
            out_7seg :  out Seven_Bit_Vector_Type   -- Output  signal for selected 7 Segment display. Seven_Bit_Vector_Type is defined as STD_LOGIC_VECTOR(6 downto 0) in LAB4_PKG
           );
end traffic_intersection;

architecture Behavioral of traffic_intersection is

signal clk_1Hz: std_logic:='0';
signal count : natural;
signal clk_out: std_logic:='0';

-- Use following signals to implement your FSM.
signal D: Three_Bit_Vector_Type :="000";  --Next state
signal Q: Three_Bit_Vector_Type :="000";  --Current state


-- Use CD to show digit on the display
signal CD: Three_Bit_Vector_Type :="000";


begin
    --1Hz clock process 
    clock_1Hz: process(clk)
    begin
        if rising_edge(clk) then
            if(count<count_for_1Hz) then --count_for_1Hz=64000000 this constant is defined in LAB4_PKG
                count<=count+1;
            else
                count<=0;
                clk_out<=not clk_out;
                clk_1Hz<=clk_out;
            end if;
        end if;
    end process;

   -- Finite State Machine Design Fulfilling Lab4 requirements.
   TrafficIntersection: process (clk, clk_1Hz)
   begin
        
--*Write  Flip-flop input and output equations --- (Hint: D <= function of Q and sw)
 
        D(2) <= (not EMV) and ((Q(2) and (not Q(1))) or (Q(2) and (not Q(0))) or ((not Q(2)) and Q(1) and Q(0)));
        D(1) <= (not EMV) and (Q(1) XOR Q(0));
        D(0) <= (not EMV) and (not Q(0)) and ((Q(1) XOR Change) or Q(2));
        
        -----------------------------------------------
        if btn='0' then    
--*Write light status equations of Highway --- (Hint: led6 <= function of Q)
            led6_r <= Q(2) or Q(1);
            led6_g <= (not Q(2)) and (not Q(1)) and (not Q(0));
            led6_b <= (not Q(2)) and (not Q(1)) and Q(0);
        else 
--*Write light status equations of secondary road --- (Hint: led6 <= function of Q)  
            led6_r <= (not Q(2)) and (not Q(1));
            led6_g <= (Q(2) XOR Q(1)) or (Q(1) and (not Q(0)));
            led6_b <= Q(2) and Q(1) and Q(0);
        end if; 

--*Write the equations of Seven Segment Display --- (Hint: CD <= function of Q).
        CD(2) <= ((not Q(2)) and Q(1));
        CD(1) <= (Q(2) and (not Q(1))); 
        CD(0) <= ((Q(2)) and (not Q(0))) or (Q(1) and (not Q(0)));
      
   end process;


D_flipflop : process (clk_1Hz) is
begin
        if rising_edge(clk_1Hz) then
            if reset='1' then
               Q<="000";
          else
               Q<=D;
            end if;
        end if;
       led <= Q;            -- Shows current state on LEDs.
   
end process D_flipflop;

 
    Decoder_7Segment: process (clk)
    begin
    --*Write the case statements below to implement the 7-segment decoder (this was done in lab 3)
    -- We want to show CD on one of the seven segments(out_7seg(6 downto 0))
    -- In LAB4_PKG we defined the bit patern for 0 to 5 as Seven_seg_0 to Seven_seg_5. Therefore you can simply use Seven_seg_0 instead of writing "0111111". 


      case CD is 
	           when "000" => out_7seg <= Seven_seg_0;
	           when "001" => out_7seg <= Seven_seg_0;
	           when "010" => out_7seg <= Seven_seg_5;
	           when "011" => out_7seg <= Seven_seg_4;
	           when "100" => out_7seg <= Seven_seg_3;
	           when "101" => out_7seg <= Seven_seg_2;
	           when "110" => out_7seg <= Seven_seg_1;
	           when "111" => out_7seg <= Seven_seg_0;
	           when others => out_7seg <= Seven_seg_0;

	  end case;           
  
    end process;
--*Don't forget the CC signal.
    CC <= '0'; -- Might not be right
        
end Behavioral;
