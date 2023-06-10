module ACC(
		output reg [32:0] Saidas,
		input Load,
		input Sh,
		input Ad,
		input Clk,
		input [32:0]Entradas
	);
	
	always @(posedge Clk)
		begin
			if(Load)
				begin
					Saidas <= {16'b00000,Entradas[15:0]};
				end
			
			if(Sh)
				begin
					Saidas <= {1'b0,Saidas[32:1]};
				end
			
			if(Ad)
				begin
					Saidas[32:16] <= Entradas[32:16];
				end
			
		end
	
	
endmodule
