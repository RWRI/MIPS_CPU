module Register #(parameter DATA_WIDTH=32)(
	output reg [DATA_WIDTH-1:0] q,
	input [DATA_WIDTH-1:0] d,
	input Clk, rst
);

	 always@(posedge Clk, posedge rst) begin
		if(rst) begin
			q <= 0;
		end
		else begin
			q <= d;
		end
	 end

endmodule
