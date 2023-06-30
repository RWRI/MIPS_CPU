module registerfile (
	output [31:0] a, b,
	input Clk, rst, write,
	input [31:0] entradaWb,
	input [4:0] rs, rt, rd
);

	(*keep=1*) reg [31:0] registros [31:0];
	integer i;
	
	assign a = registros[rs];
	assign b = registros[rt];

	always @ (posedge Clk, posedge rst) begin 
		
		if (rst)
			for(i = 0; i <= 31; i = i+1) 
				registros[i] = 32'h00000000;
				
		else if (write)
				registros[rd] <= entradaWb;
	end 

endmodule 