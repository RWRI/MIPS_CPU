`timescale 1ns/10ps

module ACC_TB(); 
		wire [8:0] saidas;
		reg load;
		reg sh;
		reg ad;
		reg clk;
		reg [8:0] entradas;
		
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
		entradas = 9'b101010111;
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
