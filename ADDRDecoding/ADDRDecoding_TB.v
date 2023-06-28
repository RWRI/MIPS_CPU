`timescale 1ns/10ps

module ADDRDecoding_TB();

	reg [31:0] address;
	wire cs;
	
	ADDRDecoding DUT(
		.cs(cs),
		.address(address)
	);

	integer i;

	initial begin
		for(i=16'h1000;i<16'h1FFF;i=i+1)begin
			address = i;
			#10;
		end
		$stop;
	end

endmodule 