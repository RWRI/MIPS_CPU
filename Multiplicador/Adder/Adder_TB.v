`timescale 1ns/10ps

module Adder_TB(); 
		wire [16:0]soma;
		reg [15:0] operandoA;
		reg [15:0] operandoB;
		integer	i, j;
		
	Adder DUT(
		.Soma(soma),
		.OperandoA(operandoA),
		.OperandoB(operandoB)
	);

	initial begin
		for(i = 1;i < 65536;i = i*2) begin
			operandoA = i;
			 for(j = 0; j < 65536; j = j+1) begin	
				#10 operandoB = j;			
				#10 if(soma != i+j) begin
					$display("Erro:%d+%d = %d",i,j,soma);
				end				
			 end
		end
	end

//	initial begin
//		operandoA = 65535;
//		operandoB = 65535;
//		#20 $finish;
//	end
	
	

endmodule
