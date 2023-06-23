module extend(
	output [31:0] saida,
	input [15:0] entrada
);   
	
	assign saida = (entrada[15]) ? {16'hFFFF,entrada} : {16'h0,entrada};
	
endmodule
