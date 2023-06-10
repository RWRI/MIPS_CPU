`timescale 1ns/10ps

module Multiplicador_TB(); 
	wire [7:0] produto;
	wire idle;
	wire done;
	reg st;
	reg clk;
	reg [3:0] multiplicando;
	reg	[3:0] multiplicador;
	reg reset;
	
	reg [4:0] ws;
	reg wl, wsh, wad, wk;
	
	Multiplicador DUT(
		.Produto(produto),
		.Idle(idle),
		.Done(done),
		.St(st),
		.Clk(clk),
		.Multiplicando(multiplicando),
		.Multiplicador(multiplicador),
		.Reset(reset)
	);
	
	//iniciando entradas
	initial begin
		reset = 0;
		st = 1;
		clk = 0;
		#5		
		reset = 1;
		#15
		reset = 0;
	end
	
	//para testar somente uma multiplicação
//	initial begin		
//		multiplicador = 11;
//		multiplicando = 13;
//		
//		#70 st = 0;
//		#150 $finish;
//	end

	//para testar todas as possibilidades
	integer i, j;
	reg fail = 0;
	initial begin
		multiplicando = 0;
		multiplicador = 0;
		#200
		
		for(i = 0; i < 16;i = i+1) begin
			for(j = 0; j < 16;j = j+1)begin
				multiplicando = i;
				multiplicador = j;
				#200 
				if(done) begin
					if(produto != i*j)begin
						$display("Erro:%dx%d = %d",i,j,produto);
						fail = 1;
					end
					//else $display("%dx%d = %d",i,j,produto);
				end
			end
		end
		if(fail) $display("Falhou o multiplicador");
		else		$display("Deu bom, soh sucesso");
		#20 $finish;		
	end
	
	always begin
		#10 clk = ~clk;
	end
	
	initial $init_signal_spy("/Multiplicador_TB/DUT/ws", "ws", 1);
	initial $init_signal_spy("/Multiplicador_TB/DUT/wl", "wl", 1);
	initial $init_signal_spy("/Multiplicador_TB/DUT/wsh", "wsh", 1);
	initial $init_signal_spy("/Multiplicador_TB/DUT/wad", "wad", 1);
	initial $init_signal_spy("/Multiplicador_TB/DUT/wk", "wk", 1);

endmodule
