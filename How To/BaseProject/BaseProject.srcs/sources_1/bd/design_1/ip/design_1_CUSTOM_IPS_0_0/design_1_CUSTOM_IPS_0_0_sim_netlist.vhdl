-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Mon May 27 15:01:08 2024
-- Host        : sophitia running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/aamalik3/Desktop/ICAP_Readback/ONRHandover/BaseProject/BaseProject.srcs/sources_1/bd/design_1/ip/design_1_CUSTOM_IPS_0_0/design_1_CUSTOM_IPS_0_0_sim_netlist.vhdl
-- Design      : design_1_CUSTOM_IPS_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_CUSTOM_IPS_0_0 is
  port (
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    Output_1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Output_Bus : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_CUSTOM_IPS_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_CUSTOM_IPS_0_0 : entity is "design_1_CUSTOM_IPS_0_0,CUSTOM_IPS,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_CUSTOM_IPS_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_CUSTOM_IPS_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_CUSTOM_IPS_0_0 : entity is "CUSTOM_IPS,Vivado 2018.2";
end design_1_CUSTOM_IPS_0_0;

architecture STRUCTURE of design_1_CUSTOM_IPS_0_0 is
  component design_1_CUSTOM_IPS_0_0_CUSTOM_IPS is
  port (
    clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    Output_1 : out STD_LOGIC_VECTOR ( 7 downto 0 );
    Output_Bus : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component design_1_CUSTOM_IPS_0_0_CUSTOM_IPS;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clock : signal is "xilinx.com:signal:clock:1.0 clock CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clock : signal is "XIL_INTERFACENAME clock, ASSOCIATED_RESET reset, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW";
begin
inst: component design_1_CUSTOM_IPS_0_0_CUSTOM_IPS
     port map (
      Output_1(7 downto 0) => Output_1(7 downto 0),
      Output_Bus(31 downto 0) => Output_Bus(31 downto 0),
      clock => clock,
      reset => reset
    );
end STRUCTURE;
