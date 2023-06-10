module Multiplicador(
	output [31:0] Produto,
	output Idle,
	output Done,
	input St,
	input Clk,
	input [15:0] Multiplicando,
	input	[15:0] Multiplicador,
	input Reset
);

	wire [16:0] ws;
	wire [32:0] wp;
	wire wl, wsh, wad, wk;
	
	assign Produto = wp[31:0];

	ACC acc(
		.Saidas(wp),
		.Load(wl),
		.Sh(wsh),
		.Ad(wad),
		.Clk(Clk),
		.Entradas({ws,Multiplicador})
	);
	
	CONTROL clt(
		.Idle(Idle), 
		.Done(Done), 
		.Load(wl),
		.Sh(wsh),
		.Ad(wad),
		.St(St),
		.Clk(Clk),
		.K(wk),
		.M(wp[0]),
		.Reset(Reset)
	);
	
	Counter count(
		.K(wk),
		.Load(wl),
		.Clk(Clk)
	);
	
	Adder add(
		.Soma(ws),
		.OperandoA(Multiplicando),
		.OperandoB(wp[31:16])
	);
	
endmodule
