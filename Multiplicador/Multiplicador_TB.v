`timescale 1ns/10ps

module Multiplicador_TB(); 
	wire [31:0] produto;
	wire idle;
	wire done;
	reg st;
	reg clk;
	reg [15:0] multiplicando;
	reg [15:0] multiplicador;
	reg reset;
	
	reg [16:0] ws;
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
//		multiplicador = 65535;
//		multiplicando = 65535;
//		
//		#70 st = 0;
//		#800 $finish;
//	end

	//para testar todas as possibilidades
	integer i;
	reg fail = 0;
	initial begin
		multiplicando = 0;
		multiplicador = 0;
		#680
			
		multiplicando = 65535;		
		for(i = 0; i < 65536;i = i+1) begin
			multiplicador = i;
			#680 
			if(done) begin
				if(produto != i*multiplicando)begin
					$display("Erro:%dx%d = %d",i,1,produto);
					fail = 1;
				end
				//else $display("%dx%d = %d",i,j,produto);
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
