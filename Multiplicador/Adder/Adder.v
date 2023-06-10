module Adder(
		output [32:0]Soma,
		input [15:0] OperandoA,
		input [15:0] OperandoB
	);
	
	assign Soma = OperandoA + OperandoB;

endmodule
