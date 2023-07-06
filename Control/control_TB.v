`timescale 10ns/10ps

module control_TB();

	reg [31:0] entrada;
	wire [22:0] saida;

	control DUT(
		.saida(saida),
		.entrada(entrada)
	);

	initial begin
		entrada = 32'b0;

		#10 entrada = 32'b001000_11111_00000_0001010100000000; 	 //LW
		#10 entrada = 32'b001001_11111_00110_0001100011111111; 	 //SW
		#10 entrada = 32'b000111_00010_00011_00101_01010_100000;  //ADD
		#10 entrada = 32'b000111_00100_00101_00110_01010_100010;  //SUB
		#10 entrada = 32'b000111_00000_00001_00100_01010_110010;  //MUL
		#10 entrada = 32'b000111_11110_11110_11110_01010_100100;  //AND
		#10 entrada = 32'b000111_11101_11101_11101_01010_100101;  //OR
		#10 $stop;
		
		
	end
	
endmodule 





