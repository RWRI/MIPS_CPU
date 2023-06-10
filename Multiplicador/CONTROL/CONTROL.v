module CONTROL(
		output reg Idle, 
		output reg Done, 
		output reg Load,
		output reg Sh,
		output reg Ad,
		input St,
		input Clk,
		input K,
		input M,
		input Reset
);

	reg [1:0]state;
	parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3;

	always @ (state, St, M)
		begin
			case (state)
				S0:
					begin
						Idle = 1;
						Load = 0;
						Sh = 0;
						Ad = 0;
						Done = 0;
						if (St)
							Load = 1;		
					end
				S1:
					begin
						Idle = 0;
						Load = 0;
						Sh = 0;
						Ad = 0;
						Done = 0;
						if (M)
							Ad = 1;
					end
				S2:
					begin
						Idle = 0;
						Load = 0;
						Sh = 1;
						Ad = 0;
						Done = 0;
					end
				S3:
					begin
						Idle = 0;
						Load = 0;
						Sh = 0;
						Ad = 0;
						Done = 1;
					end
				default:
					begin
						Idle = 0;
						Load = 0;
						Sh = 0;
						Ad = 0;
						Done = 0;
					end
			endcase
		end
	
	always @ (posedge Clk, posedge Reset) begin
		if (Reset)
			state <= S0;
		else
			case (state)
				S0:
					begin
						if(St)
							state <= S1;
						else
							state <= S0;
					end
				S1:
					state <= S2;
				S2:
					begin
						if(K)
							state <= S3;
						else
							state <= S1;
					end
				S3:
					state <= S0;
				default:
					state <= S0;
			endcase
	end

endmodule
