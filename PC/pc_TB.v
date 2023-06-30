`timescale 1ns/10ps

module pc_TB();

	reg Clk, rst;
	wire [31:0] pc_endereco;

	pc DUT(		
		.pc_endereco(pc_endereco),
		.Clk(Clk),
		.rst(rst)
	);
	
	always #10 Clk = ~Clk;
		
	initial begin
		Clk = 0;
		rst = 1;
		#15
		rst = 0;
		#2000
		rst = 1;
		#10 rst = 0;
		
		#20470 $stop;
	end

endmodule 