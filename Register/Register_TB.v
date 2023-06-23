`timescale 1ns/10ps
module Register_TB();

	reg rst, Clk;
	reg [31:0] d;
	wire [31:0] q;
	
	Register DUT(	
		.q(q),
		.d(d),
		.Clk(Clk),
		.rst(rst)
	);
	
	always
		#10 Clk = ~Clk;
	
	initial 
	begin
		rst = 1;
		Clk = 0;
		d = 0;
		#5 rst = 0;
		#20 d = 32'hffffffff;
		#20 d = 32'h00000000;
		#20 d = 32'h00000001;
		#20 d = 32'hA0A0A0A0;
		#20 $stop;
	end
	
endmodule
	