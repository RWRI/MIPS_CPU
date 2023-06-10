module ACC(
		output reg [8:0] Saidas,
		input Load,
		input Sh,
		input Ad,
		input Clk,
		input [8:0]Entradas
	);
	
	always @(posedge Clk)
		begin
			if(Load)
				begin
					Saidas <= {5'b00000,Entradas[3:0]};
				end
			
			if(Sh)
				begin
					Saidas <= {1'b0,Saidas[8:1]};
				end
			
			if(Ad)
				begin
					Saidas[8:4] <= Entradas[8:4];
				end
			
		end
	
	
endmodule
