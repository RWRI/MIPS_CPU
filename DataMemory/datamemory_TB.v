`timescale 10ns/10ps

module datamemory_TB();
	
	reg  Clk, rd_wr;
	reg  [31:0] entrada;
	reg  [9:0] endereco;
	wire [31:0] saida;
	
	integer i;
	
	datamemory DUT(
		.saida(saida),
		.Clk(Clk),
		.rd_wr(rd_wr),
		.entrada(entrada),
		.endereco(endereco)
	);

	always 
		#10 Clk = ~Clk;

	initial 
	begin
		Clk = 0;
		rd_wr = 0;
		entrada = 0;
		
		for(i = 0; i < 4; i = i+1)
		begin
			#43;
			endereco = i;
		end

		#50
		rd_wr = 1;
		
		for(i = 5; i <= 20; i = i + 1)
		begin
			#50;
			endereco = i;
			entrada = i*5;
		end
		
		#50
		rd_wr = 0;
		
		for(i = 5; i < 20; i = i + 1)	
		begin
			#50;
			endereco = i;
		end
		
		#50 $stop;
	end

endmodule 