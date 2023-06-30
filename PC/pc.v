module pc(
	output [31:0]pc_endereco,
	input Clk, rst
);  
	reg [31:0]rpc = 32'h0500;


	always@(posedge Clk, posedge rst) begin 
		if(rst)
			rpc <= 32'h0500;
		else
			rpc <= rpc + 32'b1;
	end

	assign pc_endereco = rpc;
	
endmodule 