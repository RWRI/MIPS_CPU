`timescale 1ns/10ps

module Counter_TB(); 
	wire k;
	reg load;
	reg clk;
	
	integer count;
		
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
		#400 load = 1;
		#50 load = 0;
		#700 load = 1;
		#50 load = 0;
		#350 $finish;
	end

	always begin
		#5 clk = ~clk;
	end
	
	initial $init_signal_spy("/Counter_TB/DUT/count", "count", 1);

endmodule
