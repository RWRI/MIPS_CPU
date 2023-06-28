`timescale 1ns/10ps

module registerfile_TB ();
	reg Clk, rst, write;
	reg [31:0] entradaWb;
	reg [4:0] rs, rt, rd; 	
	wire [31:0] a, b;
	
	wire [31:0] registros [31:0];
	
	registerfile DUT(
		.a(a),
		.b(b),
		.Clk(Clk),
		.rst(rst),
		.write(write),
		.entradaWb(entradaWb),
		.rs(rs),
		.rt(rt),
		.rd(rd)
	);
	
	always #10 Clk = ~Clk;
	
	initial begin
		Clk = 0;
		rst=1;
		write = 0;
		entradaWb = 0;
		rs = 0;
		rt = 0;
		rd = 0;
		#15 rst=0;
		
		entradaWb = 32'ha0a0a0a0;
		rd = 5'h1;
		write = 1;
		#50 write = 0;
		
		#100 entradaWb = 32'hffffffff;
		rd = 5'h2;
		write = 1;
		#50 write = 0;
		
		#100 entradaWb = 32'h19857328;
		rd = 5'h1c;
		write = 1;
		#50 write = 0;
		
		#100 entradaWb = 32'h753b9817;
		rd = 5'h1f;
		write = 1;
		#50 write = 0;
		
		#100;
		rs = 5'h1;
		rt = 5'h2;
		
		#100;
		rs = 5'h1c;
		rt = 5'h1f;
		
		#100 $stop;
		
	end
	
	initial $init_signal_spy("/registerfile_TB/DUT/registros", "registros", 1);	
	
	
endmodule
