module Adder(
		output [4:0]Soma,
		input [3:0] OperandoA,
		input [3:0] OperandoB
	);
	
	assign Soma = OperandoA + OperandoB;

endmodule
