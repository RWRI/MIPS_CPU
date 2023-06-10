`timescale 1ns/10ps

module CONTROL_TB();
		wire idle;
		wire done; 
		wire load;
		wire sh;
		wire ad;
		reg st;
		reg clk;
		reg k;
		reg m;
		reg reset;
		reg [1:0] state;
	
	
	CONTROL DUT(
		.Idle(idle), 
		.Done(done), 
		.Load(load),
		.Sh(sh),
		.Ad(ad),
		.St(st),
		.Clk(clk),
		.K(k),
		.M(m),
		.Reset(reset)
		
	);
	
	initial begin
		reset = 1;
		st = 1;
		m = 0;
		k = 0;
		clk = 0;
		#15 reset = 0;
		#100
		m = 1;
		#200;
		k = 1;		
		#100 $finish;
	end
	
	always begin
		#10 clk = ~clk;
	end
	
	initial $init_signal_spy("/CONTROL_TB/DUT/state", "state", 1);

endmodule
