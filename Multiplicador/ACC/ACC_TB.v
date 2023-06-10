`timescale 1ns/10ps

module ACC_TB(); 
		wire [32:0] saidas;
		reg load;
		reg sh;
		reg ad;
		reg clk;
		reg [32:0] entradas;
		
	ACC DUT(
		.Saidas(saidas),
		.Load(load),
		.Sh(sh),
		.Ad(ad),
		.Clk(clk),
		.Entradas(entradas)
	);

	initial begin
		load = 0;
		sh = 0;
		ad = 0;
		clk = 0;
		entradas = 33'b0_1111_1010_1011_1011_1110_0000_0101_1010;
		#40 load = 1;
		#30 load = 0;
		
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		
		#40 load = 1;
		#30 load = 0;
		
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		
		#10 sh = 1;
		#30 sh = 0;
		ad = 1;
		#30 ad = 0;
		
		#60 $finish;
	end

	always begin
		#10 clk = ~clk;
	end
	
	
	
	

endmodule
