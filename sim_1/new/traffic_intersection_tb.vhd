----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/19/2018 03:32:50 PM
-- Design Name: 
-- Module Name: traffic_intersection_tb - Behavioral
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

entity traffic_intersection_tb is
--  Port ( );
end traffic_intersection_tb;

architecture Behavioral of traffic_intersection_tb is

component traffic_intersection
    Port ( 
            clk:    in STD_LOGIC;
            btn :   in STD_LOGIC_VECTOR(3 DOWNTO 0);    -- btn(0) press to see traffic light status for North/South or East/West lights.
                                                        -- btn(3) press to emulate vehicle passing from North/South direction, btn(2) for East/West.
            --Write design line here to get inputs from switches, refer to constraints file.  
            sw:     in STD_LOGIC_VECTOR(3 DOWNTO 0);    -- SW(0)='1'=>Vehicle present on North/South direction of travel (Range Road), 
                                                        -- SW(2)='1'=> Emergency Vehicle on Range Road, SW(3)='1'=> Emergency Vehicle on HW16
            led6_r : out STD_LOGIC:='0';     --Traffic light status as Red
            led6_g : out STD_LOGIC:='0';     --Traffic light status as Green
            led6_b : out STD_LOGIC:='0';     --Traffic light status as Yello=>Blue on board
            
            led: out STD_LOGIC_VECTOR(1 downto 0):="00";                --Monitor states [ led(0), led(1) ] 
            red_led: out STD_LOGIC_VECTOR (1 downto 0):="00";           -- Red Light Camera [red_led(0), red_led(1) ];
            CC :        out STD_LOGIC;                                  --Common cathode input to select respective 7-segment digit.
            out_7seg :  out STD_LOGIC_VECTOR (6 downto 0):="0000000"    -- Output  signal for selected 7 Segment display. 
           );
end component;

signal clk, CC, led6_r,led6_g,led6_b: std_logic:='0';
signal btn, sw: std_logic_vector(3 downto 0):="0000";
signal led, red_led: std_logic_vector(1 downto 0);

signal out_7seg: std_logic_vector(6 downto 0);

begin

Traffic_Int: traffic_intersection port map
    (
        clk=>clk,
        btn=>btn,
        sw=>sw,
        led6_r=>led6_r,
        led6_g=>led6_g,
        led6_b=>led6_b,
        led=>led,
        red_led=>red_led,
        CC=>CC,
        out_7seg=>out_7seg                    
    );

 Clocking: process
 begin
    clk<= '0';
    wait for 10 us;
    clk<= '1';
    wait for 10 us;
 end process;

 Stimulus: process 
 begin
    sw<="0000";
    wait for 1000 ms;     
    sw<="0001";
    wait for 1000 ms;     
--    sw<="1000";
    wait;
--    wait for 150 us;     
--    sw<="0101";
--    wait for 12000 ms;     
end process;

end Behavioral;
