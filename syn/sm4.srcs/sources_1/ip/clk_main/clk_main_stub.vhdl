-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Feb  1 21:21:59 2021
-- Host        : LAPTOP-89V7LGOT running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub E:/SM4-FPGA/syn/sm4.srcs/sources_1/ip/clk_main/clk_main_stub.vhdl
-- Design      : clk_main
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-3
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_main is
  Port ( 
    clk_out1 : out STD_LOGIC;
    resetn : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_main;

architecture stub of clk_main is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,resetn,locked,clk_in1";
begin
end;
