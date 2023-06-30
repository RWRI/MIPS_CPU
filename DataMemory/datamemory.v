module datamemory(
	output reg [31:0] saida,
	input Clk,
	input rd_wr, //Read em 0, Write em 1
	input [9:0] endereco,
	input [31:0] entrada
);	
	
	reg [31:0] memoria [0:1023];
		
	integer i;
	
	always @(posedge Clk) begin
		if (rd_wr)
			memoria[endereco] <= entrada;
		
		saida <= memoria[endereco];
	end
	
	initial begin
		memoria[0]=32'd2001; // A
		memoria[1]=32'd4001; // B
		memoria[2]=32'd5001; // C
		memoria[3]=32'd3001; // D
	
		for(i = 4; i < 1024;i = i+1) 
			memoria[i] = 32'b0;
	end

endmodule 

