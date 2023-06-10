module Counter(
	output reg K,
	input Load,
	input Clk
);
	reg [3:0] count;

	always @ (posedge Clk)
		begin
			if(Load)
				begin
					K <= 0;
					count <= 0;
				end	
			else
				begin
					count <= count+1;
				end
			
			if(count == 6)
				begin
					 K <= 1;
				end
			else
				begin
					 K <= 0;
				end
			
		end

endmodule
