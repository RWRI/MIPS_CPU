`timescale 1ns/10ps

module extend_TB();

	reg [15:0] entrada;
	wire [31:0] saida;

	extend DUT(
		.entrada(entrada), 
		.saida(saida)
	);

	initial 
	begin
		entrada = 16'h0;
		#20 entrada = 16'hF;
		#20 entrada = 16'hFF;
		#20 entrada = 16'hFFF;
		#20 entrada = 16'hFFFF;
		#20 entrada = 16'hF000;
		#20 entrada = 16'h8000;		
		#20 $stop;
	end

endmodule 