`timescale 1ns/10ps

module Adder_TB(); 
		wire [4:0]soma;
		reg [3:0] operandoA;
		reg [3:0] operandoB;
		integer	i, j;
		
	Adder DUT(
		.Soma(soma),
		.OperandoA(operandoA),
		.OperandoB(operandoB)
	);

	initial begin
		for(i = 0;i < 16;i = i+1) begin
			operandoA = i;
			 for(j = 0; j < 16; j = j+1) begin
				#20 operandoB = j;
			 end
		end
	end

//	initial begin
//		operandoA = 15;
//		operandoB = 15;
//		#20 $finish;
//	end
	
	

endmodule
