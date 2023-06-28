module ADDRDecoding(
	output reg cs,
	input [31:0] address
);
	//Memória interna de 1KWord 3FFh 
	//Começando em 7 * 300h = 1500h
	//O endereço final de memória é: 1500h + 3FFh = 18FFh
	
	reg [31:0] limiteInf, limiteSup;
	
	always @(*) begin
		limiteInf = 32'h1500;
		limiteSup = 32'h18FF;
		
		if(address >= limiteInf) begin
			if(address <= limiteSup) begin
				cs = 0;
			end else
				cs = 1;
		end else 
			cs = 1;	
	end 
	
endmodule