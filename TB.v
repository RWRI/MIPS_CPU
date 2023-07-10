`timescale 1ns/10ps

module TB();
	
	reg CLKIN,rst;
	reg [31:0] Data_BUS_READ;
	wire [31:0] ADDR, Data_BUS_WRITE;
	wire CS,WR_RD;
	
	reg CLK_SYS, CLK_MUL;
	reg [31:0] writeBack;	
	
	cpu DUT (
		.CLK(CLKIN), 
		.rst(rst), 
		.Data_BUS_READ(Data_BUS_READ), 
		.ADDR(ADDR), 
		.Data_BUS_WRITE(Data_BUS_WRITE),
		.CS(CS), 
		.WR_RD(WR_RD)
	);

	initial begin
		$init_signal_spy("DUT/CLK_SYS","CLK_SYS",1);
		$init_signal_spy("DUT/CLK_MUL","CLK_MUL",1);
		$init_signal_spy("DUT/writeBack","writeBack",1);
		
		CLKIN = 0;
		rst = 0;
		Data_BUS_READ = 32'hAAAAAAAA;
		
		#20 rst = 1;
		#80 rst = 0;

		#3600 $stop;
	end
	
	always #2 CLKIN = ~CLKIN;	
endmodule 