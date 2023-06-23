module pc(
	output [9:0]pc_endereco,
	input Clk, rst
);  
	reg [9:0]rpc = 10'b0;


	always@(posedge Clk, posedge rst) begin 
		if(rst)
			rpc <= 10'b0;
		else
			rpc <= rpc + 10'b1;
	end

	assign pc_endereco = rpc;
	
endmodule 