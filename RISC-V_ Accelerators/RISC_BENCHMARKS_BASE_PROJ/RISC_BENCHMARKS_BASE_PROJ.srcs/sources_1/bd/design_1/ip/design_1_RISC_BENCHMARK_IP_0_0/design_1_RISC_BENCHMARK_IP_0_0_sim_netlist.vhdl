-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
-- Date        : Thu Oct 26 15:14:42 2023
-- Host        : sophitia running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/RISC_BENCHMARKS_BASE_PROJ/RISC_BENCHMARKS_BASE_PROJ.srcs/sources_1/bd/design_1/ip/design_1_RISC_BENCHMARK_IP_0_0/design_1_RISC_BENCHMARK_IP_0_0_sim_netlist.vhdl
-- Design      : design_1_RISC_BENCHMARK_IP_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_RISC_BENCHMARK_IP_0_0 is
  port (
    clk : in STD_LOGIC;
    cpu_rst : in STD_LOGIC;
    cpu_start : in STD_LOGIC;
    result_vld : out STD_LOGIC;
    MSB_Bits : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_RISC_BENCHMARK_IP_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_RISC_BENCHMARK_IP_0_0 : entity is "design_1_RISC_BENCHMARK_IP_0_0,RISC_BENCHMARK_IP,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_RISC_BENCHMARK_IP_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_RISC_BENCHMARK_IP_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_RISC_BENCHMARK_IP_0_0 : entity is "RISC_BENCHMARK_IP,Vivado 2018.2";
end design_1_RISC_BENCHMARK_IP_0_0;

architecture STRUCTURE of design_1_RISC_BENCHMARK_IP_0_0 is
  component design_1_RISC_BENCHMARK_IP_0_0_RISC_BENCHMARK_IP is
  port (
    clk : in STD_LOGIC;
    cpu_rst : in STD_LOGIC;
    cpu_start : in STD_LOGIC;
    result_vld : out STD_LOGIC;
    MSB_Bits : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component design_1_RISC_BENCHMARK_IP_0_0_RISC_BENCHMARK_IP;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1";
  attribute X_INTERFACE_INFO of cpu_rst : signal is "xilinx.com:signal:reset:1.0 cpu_rst RST";
  attribute X_INTERFACE_PARAMETER of cpu_rst : signal is "XIL_INTERFACENAME cpu_rst, POLARITY ACTIVE_LOW";
begin
inst: component design_1_RISC_BENCHMARK_IP_0_0_RISC_BENCHMARK_IP
     port map (
      MSB_Bits(31 downto 0) => MSB_Bits(31 downto 0),
      clk => clk,
      cpu_rst => cpu_rst,
      cpu_start => cpu_start,
      result_vld => result_vld
    );
end STRUCTURE;
