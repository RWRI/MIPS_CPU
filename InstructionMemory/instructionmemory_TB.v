`timescale 10ns/100ps

module instructionmemory_TB();
	reg Clk;
	reg [9:0] endereco;
	wire [31:0] saida;
	integer i;
	
	instructionmemory DUT(
		.saida(saida),
		.Clk(Clk),
		.endereco(endereco)
	);
	
	always #2 Clk = ~Clk;
	
	initial begin
		endereco = 0;
		Clk = 0;
		#5
		for (i = 0; i < 25; i = i + 1) begin 
			#10 endereco = endereco + 1;
		end
		#20 $stop;
	end
	
endmodule

