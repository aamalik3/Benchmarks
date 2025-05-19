## Description

The project encompasses the research done to integrate benchamrk supports in various benchmarks.
The benchamrks are divided into two main categories
+ PL-based Hardware Accelerators
+ RISC-V Processor-based Hardware Accelerators

## Resource Utilization for PL-based Hardware Accelerators

| Benchmark | Clock Cycles | LUTs | Flip Flops | Block RAM | DSPs | 
|-----------|--------------|------|------------|-----------|------|
| Scalable Matrix Multiplier | 63,108,996 cycles | 557 | 141 | 108 | 2 |
| PNG decoder (Image 14) | 10,181,839 cycles | 2737 | 597 | 22 | 0 |
| Open NOC | 8,941,998 cycles | 4980 | 4017 | 0 | 0 |
| JPEG decoder (Image 007) | 4,147,561 cycles | 2334 | 469 | 4.5 | 0 |
| PNG decoder (Image 10) | 399,996 cycles | 2737 | 597 | 22 | 0 |
| hardh264 | 171,029 cycles | 3034 | 1095 | 1.5 | 2 |
| Image Processor | 98,303 cycles | 84 | 8 | 0 | 0 |
| JPEG decoder (Image 001) | 78,652 cycles | 2334 | 469 | 4.5 | 0 |
| NoC | 49,956 cycles | Area | Too | Large | |
| Kyber Server | 34,806 cycles | 7016 | 2985 | 3 | 2 |
| Kyber Client | 20,802 cycles | 7283 | 3002 | 3 | 2 |
| FFT | 3,274 cycles | 2508 | 6096 | 3 | 32 | 
| MIPS | 1,341 cycles | 916 | 197 | 7.5 | 0 |
| Trigonometry | 1,268 cycles | 1242 | 435 | 0 | 0 |
| Image Classification | Testbench not provided | 1774 | 511 | 9 | 0 |


## Resource Utilization for RISC-V Processor-based Hardware Accelerators
| Benchmark | Clock Cycles | LUTs | Flip Flops | Block RAM | DSPs | 
|-----------|--------------|------|------------|-----------|------|
| AES-128   | 8195		   | 3978 | 2353	   | 32 	   | 3    |
| SHA-256   | 5330		   | 4070 | 2323	   | 32 	   | 3    |
| GEMM      | 2681  	   | 4056 | 696		   | 32 	   | 3    |
| BFS       | 13595  	   | 4059 | 700		   | 32 	   | 3    |
| Sort      | 5468   	   | 4053 | 680		   | 32 	   | 3    |
| NW        | 44707        | 4057 | 685		   | 32 	   | 3    |
| KMP       | 18935        | 4053 | 695		   | 32 	   | 3    |
| Dhrystone | 165207       | 4055 | 686		   | 32 	   | 3    |
| Coremark  | 2159020      | 4052 | 694		   | 32 	   | 3    |
| Falcon-Key-Gen|25551     | 4070 | 2356	   | 32 	   | 3    |
| Falcon-Sign-Gen| 264591000  | 4070 | 2356	   | 32 	   | 3    |
| Falcon-Sign-Verify|706555  | 4070 | 2356	   | 32 	   | 3    |

## Directory Structure
 Bencharks
 |_ How To
	|_ BaseProject
	|_ ctr_example
	|_ RTL_IP
	|_ User Guide
	|_ Useful commands
 |_ PL-based Accelerators
	|_ FFT
	|_ H.264
	|_ Image Classfication 
	|_ Image Processor 
	|_ JPEG Decoder
	|_ PNG Decoder
	|_ ML-KEM (Khyber)
	|_ OpenNOC
	|_ Scalable Matrix Multiplication
	|_ Trigonometry Core
 |_ RISC-V Accelerators
	|_ Accelerator Source Code
	   |_ AES-128   
	   |_ SHA-256   
	   |_ GEMM      
	   |_ BFS       
	   |_ Sort      
	   |_ NW        
	   |_ KMP       
	   |_ Dhrystone 
	   |_ Coremark 
	   |_ Falcon-Key-Gen
	   |_ Falcon-Sign-Gen
	   |_ Falcon-Sign-Verif	   
	|_ Bitfiles
	|_ PR Checkpoints
	|_ cv32e40x Source Code
	|_ memfiles (RISC-V Generated files)
	|_ RISC_BENCHMARKS_BASE_PROJ (Can be used to generate integrate new benchamrks)
	|_ RISC_RTL_Project (Actual Project to test preemptions)
 |_ PS C Source Code
 |_ Utility
 |_ Frame.hex
 |_ README.md
 
## Getting Started

The 'how to' folder contains the a user guide and a simple counter example 
that a user can test to quickly test the preemption support.
### Software

* Xilinix Vivado and SDK 2018.2

### What's included

Provided in this repository are the IPs that were tested and reported latency and area utilization of the Zedboard FPGA. 
The Utility folder contains a exe that can be used to split one large RISC-V memory file into 4 small memory files to fit
onto area constraint devices. (Required Software MATLAB R2020b)

## Help

Provided are some commands that would be useful to test IPs and determine area usage.
```
(* DONT_TOUCH = "yes" *)

----------------------------------------------------------------------------------------------
| First Step-- Synthize Design out of context (in given vivado ANY_IP_FROM_OPENCORES Project) |
----------------------------------------------------------------------------------------------
	# Hash_Chain is the name of the IP that you get from internet , replace with actual name of the IP
synth_design -mode out_of_context -top CUSTOM_IPS
	# if you want save in the same folder, here Synthesized_IP_Checkpoint is the name of the checkpoint
write_checkpoint Synthesized_IP_Checkpoint.dcp  # - cd to directory where you want to place the file
	# if you want save in another folder by navigating through them  either run command at line 5 or 7, not both
write_checkpoint -force ../Parent_folder/Synthesized_IP_Checkpoint.dcp 

---------------------------------------------------------------------------------------------
| Second Step-- Incorporate the saved checkpoint in our design (in given vivado BASEPROJECT) |
---------------------------------------------------------------------------------------------
reset_run synth_1
launch_runs synth_1 -jobs 30
wait_on_run -timeout 10 synth_1
open_run synth_1 -name synth_1

# here set the benchamrk name as per synthesized checkpoint and folder hirecarchy. Path is assumed to be either in "With CRC" or "Without CRC" folder
update_design -cell [get_cell design_1_i/CUSTOM_IP/inst] -black_box

#cd to directory where the new checkpoint is
set benchmarkname "AES"  #change AES to what name you want the simulation to be

read_checkpoint -cell [get_cell design_1_i/CUSTOM_IP/inst] ./$benchmarkname.dcp
opt_design
place_design
route_design

file mkdir $benchmarkname
write_bitstream -force -file ./$benchmarkname/$benchmarkname.bit
write_cfgmem -force -format BIN -interface SMAPx32 -disablebitswap -loadbit "up 0 ./$benchmarkname/${benchmarkname}_pblock_custom_ip_partial.bit" ./$benchmarkname/${benchmarkname}_partial.bin
file delete ./$benchmarkname/${benchmarkname}.prm

report_utilization -hierarchical > ./$benchmarkname/${benchmarkname}_area.txt
report_utilization -name ./$benchmarkname/${benchmarkname}_area_utilization
```
