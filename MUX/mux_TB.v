`timescale 1ns/100ps

module mux_TB();
	
	reg [31:0] data1, data2;
	reg sel;
	wire [31:0] out;
	
	mux DUT (
		.sel(sel),
		.data1(data1),
		.data2(data2),
		.out(out)
	);
	
	
	initial 
	begin
		data1 = 32'hAAAAAAAA;
		data2 = 32'h22222222;
		sel = 0;
		
		#30 sel = 1;
		
		#30 $stop;
	end
	
	
endmodule 