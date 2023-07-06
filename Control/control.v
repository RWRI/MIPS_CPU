module control(
	output [22:0] saida,
	input [31:0] entrada	
);
	
	
	reg [5:0] code_op, op;
	reg [4:0] rs,rt;
	
	reg [1:0] sel_ALU;
	reg mul_st;
	reg alu1_mux;
	reg alu2_mux;
	reg mem_wr;
	reg mux_sel_wb;
	reg [4:0] rd;
	reg rf_wr;
	
	assign saida = {rs, rt, rd, rf_wr, alu1_mux, sel_ALU, mul_st,  alu2_mux, mem_wr, mux_sel_wb};

	always @ (entrada) 
	begin
		code_op = entrada[31:26];
		op = entrada[5:0];
		rs = entrada[25:21];
		rt = entrada[20:16];
		
		case(code_op)
			5'd8: 					//LW
			begin
				sel_ALU = 2'b00; 		// soma o offset com o registrador 
				rd = rt;           	// regitrador que vai gravar oq vem memória
				rf_wr = 1;				// habilita a escrita no regiter file
				mem_wr = 0;   		 	// habilita ler da memoria     				
				alu1_mux = 1;		 	// escolhe o extend como entrada
				alu2_mux = 1;		 	// utiliza a saida da ALU
				mul_st = 0; 		 	// nao usa o multiplicador
				mux_sel_wb = 1;	 	// seleciona o registador M p writeback
			end
			
			5'd9: 				 	//SW
			begin
				sel_ALU = 2'b00;		// soma o offset com o registrador
				rd = 5'b0;       		// valor default para rd
				rf_wr = 0;				// nao escreve no RegisterFile
				mem_wr = 1;				// Habilita escrever na memoria
				alu1_mux = 1;			// escolha extend como entrada
				alu2_mux = 1;			// utiliza saida da alu
				mul_st = 0;				// nao usa o multiplicador
				mux_sel_wb = 1; 		// seleciona M para writeback
			end
			
			5'd7: 					//Op aritmetica
			begin  
				rd = entrada[15:11]; // Pega o rd da instrucao
				rf_wr = 1; 				// Habilita escrever no register file
				alu1_mux = 0;       	// Usa B como entrada
				mul_st = 0;				// inicia multiplicador desabilitado
				mux_sel_wb = 0;		// Seleciona D para writeback
				mem_wr = 0;				// Nao habilita escrever na memoria
				
				case(op)
					6'd32:  			// add
					begin 
						sel_ALU = 2'b00;	// Escolhe a soma na alu
						alu2_mux = 1;   	// pega a saida do multiplicador
					end
					
					6'd34: 			// sub
					begin
						sel_ALU = 2'b01;	// Escolhe a subtração na alu
						alu2_mux = 1;		// pega a saida do multiplicador		
					end
					
					6'd50: 			
					begin
						sel_ALU = 2'b0;	// default para alu que não vai usar
						mul_st = 1;			// multiplicador ativado
						alu2_mux = 0;  	// escolhe a saida do multiplicador
					end
					
					6'd36: 			//and
					begin
						sel_ALU = 2'b10; 	// Escolhe o and na alu	
						alu2_mux = 1; 		// pega a saida do alu		
					end
					
					6'd37: 			//or
					begin
						sel_ALU = 2'b11;	// Escolhe o or na alu
						alu2_mux = 1; 		// pega a saida do alu
					end
					
					default:
					begin
						sel_ALU = 2'b01;    // Faz uma subtração
						alu2_mux = 1;		// pega a saida da alu
					end
					
				endcase
			end
			
			default: 
			begin
				rd = 0; 			//pega o primeiro registro
				rf_wr = 0; 		//nao escreve no register file
				alu1_mux = 0;	//pega valor do B
				sel_ALU = 0;	//faz uma soma
				mul_st = 0;		//não habilita multiplicador
				alu2_mux = 1;	//pega o resultado da alu
				mem_wr = 0;		//leitura da memória
				mux_sel_wb = 0;//seleciona o D				
			end
			
		endcase
	end

endmodule 