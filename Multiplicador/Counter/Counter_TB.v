`timescale 1ns/10ps

module Counter_TB(); 
	wire k;
	reg load;
	reg clk;
	reg [3:0] count;
	
		
	Counter DUT(
		.K(k),
		.Load(load),
		.Clk(clk)
	);

	initial begin
		load = 0;
		clk = 0;
		#45 load = 1;
		#50 load = 0;
		#130 load = 1;
		#50 load = 0;
		#300 load = 1;
		#50 load = 0;
		#350 $finish;
	end

	always begin
		#20 clk = ~clk;
	end
	
	initial $init_signal_spy("/Counter_TB/DUT/count", "count", 1);

endmodule
