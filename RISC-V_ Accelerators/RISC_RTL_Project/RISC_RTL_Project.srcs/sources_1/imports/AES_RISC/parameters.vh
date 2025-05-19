//`define BFS           1
//`define COREMARK      1
//`define DHRYSTONE     1
//`define GEMM          1
//`define KMP           1
//`define MERGE_SORT    1
//`define NW            1
//`define FALCON512int  1
//`define FALCON0Delay    1
`define SHA256   1

`ifdef BFS
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/bfs/bfs_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/bfs/bfs_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/bfs/bfs_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/bfs/bfs_4.hex"
		initial $display("Benchmark Selected : BFS");
`elsif COREMARK
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/coremark/coremark_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/coremark/coremark_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/coremark/coremark_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/coremark/coremark_4.hex"
		initial $display("Benchmark Selected : COREMARK");
`elsif DHRYSTONE
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/dhrystone/dhrystone_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/dhrystone/dhrystone_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/dhrystone/dhrystone_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/dhrystone/dhrystone_4.hex"
		initial $display("Benchmark Selected : DHRYSTONE");
`elsif GEMM
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/gemm/gemm_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/gemm/gemm_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/gemm/gemm_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/gemm/gemm_4.hex"
		initial $display("Benchmark Selected : GEMM");
`elsif KMP
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/kmp/kmp_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/kmp/kmp_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/kmp/kmp_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/kmp/kmp_4.hex"
		initial $display("Benchmark Selected : KMP");
`elsif MERGE_SORT
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/merge/merge_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/merge/merge_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/merge/merge_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/merge/merge_4.hex"
		initial $display("Benchmark Selected : MERGE_SORT");
`elsif NW
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/nw/nw_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/nw/nw_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/nw/nw_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/nw/nw_4.hex"
		initial $display("Benchmark Selected : NW");
`elsif FALCON512int
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon512int/falcon512int_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon512int/falcon512int_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon512int/falcon512int_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon512int/falcon512int_4.hex"
		initial $display("Benchmark Selected : FALCON512int");
`elsif FALCON0Delay
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon_0_delay/falcon_0_delay_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon_0_delay/falcon_0_delay_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon_0_delay/falcon_0_delay_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/falcon_0_delay/falcon_0_delay_4.hex"
		initial $display("Benchmark Selected : FALCON0Delay");
`elsif SHA256
`define File1 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/sha256/sha256_1.hex"
`define File2 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/sha256/sha256_2.hex"
`define File3 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/sha256/sha256_3.hex"
`define File4 "C:/Users/aamalik3/Desktop/ICAP_Readback/Benchmarks/memfiles/sha256/sha256_4.hex"
		initial $display("Benchmark Selected : SHA256");	
`endif