`timescale 1ns / 1ps 
 
module alu_TB();
	reg[31:0] a, b;
	reg[1:0] sel;
	wire[31:0] out;

	alu DUT(
		.a(a), 
		.b(b), 
		.sel(sel), 
		.out(out)	
	);

	initial begin
		a = 32'h0000_FFFFF; 
		b = 32'hFFFF_00000; 
		sel = 2'b00;		
		#20;
		
		a = 32'hFFFF_5828; 
		b = 32'hFFFF_0828; 
		sel = 2'b01;
		#20;
		
		a = 32'h0A0A_0A0A; 
		b = 32'h0000_FFFF; 
		sel = 2'b10;
		#20;
		
		a = 32'hF0F0_F0F0; 
		b = 32'h0000_0000; 
		sel = 2'b11;
		#20 $stop;
	end
 
endmodule 