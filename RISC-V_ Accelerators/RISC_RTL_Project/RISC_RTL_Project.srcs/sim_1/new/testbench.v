`timescale 1 ns / 1 ps

module testbench ();

reg clk=0;
reg cpu_rst=0;
reg cpu_start=0;
wire cpu_stalled;
wire result_vld;
initial
begin
forever
	clk = #5 ~clk ;	
end

initial
begin
			cpu_rst		= 0;			
			cpu_start	= 0;			
			repeat (10)@(posedge clk);
			cpu_rst	= 1;
			repeat (10)@(posedge clk);	
			cpu_start	= 1;			
end
 RISC_BENCHMARK_IP
 RISC_BENCHMARK_IP
  (
  
  .clk        (			clk       ),
  .cpu_rst    (        cpu_rst    ),
  .cpu_start  (        cpu_start  ),
  .cpu_stalled(        cpu_stalled),
  .result_vld (        result_vld )
   );
   
endmodule;