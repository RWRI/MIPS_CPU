/* 
	Grupo 7
	Bárbara Alves de Paiva Barbosa - 2020003139
	Maria Clara Martins Santana 	 - 2020012227
	Ryan Wyllyan Ribeiro Inácio 	 - 2020001770
			
		a) Qual a latência do sistema?
			R.: 5 pulsos de clock, haja vista que o pipeline 5 estágios o que configura esta latencia. 
			
		b) Qual o throughput do sistema?
			R.: O throughput é de 1 instrução por clock quando o pipeline estiver cheio, ou seja, após preencher todos os estágios.
			
		c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)
			R.: FPGA => Cyclone IV GX: EP4CGX150DF31I7AD
	  			 Para realizar o Timing Analyzer  utilizou-se a configuração "Slow 1200mV 100C Model".
	  			 Para o Multiplicador foi de MHz
	  			 Para o Sistema foi 65.92MHz
			
		d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)
			FPGA => Cyclone IV GX: EP4CGX150DF31I7AD
			Como a multiplicação leva 34 pulsos de clock para ser realizada, a frequência do sistema tem que ser 34 vezes menor 
			do que a do multiplicador. Desse modo as frequências ficaram as seguintes:
			Para o Multiplicador foi de 300MHz
			Para o Sistema foi 8.824MHz
			
		e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência ininterrupta)? Por quê? 
			O que pode ser feito para que a expressão seja calculada corretamente?
			Não, visto que acontece "pipeline hazard", onde o resultado de uma instrução ainda não está no registrador de destino 
			e a instrução seguinte tenta acessá-la. Uma maneira de resolver esse problema é inserir 3 bolhas na pipeline depois das instruções de load.
			
		f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?
			Não, visto que o clock do sistema é um multiplo inteiro do clock do multiplicador e a PLL mantém a fase sincronizada.
		
		g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que? 
			Não, visto que essa implementação de multiplicador utilizada possui pipeline enrolada, 
			desse modo não tendo paralelismo e demorando vários ciclos (34 neste caso) para realizar a sua execução.
		
		h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência deoperação maior). 
			Para cada modificação sugerida, qual a nova latência e throughput do sistema?
			Substituir a implementação do multiplicador por um mais condizente com essa implementação do MIPS. por exemplo, 
			o próprio multiplicador da FPGA. Desse modo, o sistema poderia operar em uma frequência maior, 
			e precisaria de apenas um Clock para todo o sistema. A latência e o throughput seriam mantidos.

	*/

module cpu(
	output CS, WR_RD,
	output [31:0] ADDR, Data_BUS_WRITE,
	input CLK, rst,
	input [31:0] Data_BUS_READ
);

	
	(*keep=1*)wire [31:0] out_inst_mem;
	(*keep=1*)wire [9:0] out_PC;
	(*keep=1*)wire CLK_MUL, CLK_SYS;
	(*keep=1*)wire [22:0] ctrl0, ctrl1, ctrl2, ctrl3;
	(*keep=1*)wire [31:0] regFile1, regFile2, writeBack, regA, regB;	
	(*keep=1*)wire [31:0] ex_out, reg_imm_out, mux1_out, out_ALU;	 
	(*keep=1*)wire [31:0] out_MULT, mux2_out, mux3_out, reg_d1_out;		 
	(*keep=1*)wire [31:0] dout, reg_d2_out, enderecoMem1, enderecoMem2;
	(*keep=1*) wire csM;
	
	
	PLL pll(
		.areset(rst),
		.inclk0(CLK),
		.c0(CLK_MUL),
		.c1(CLK_SYS)
	);

	
	assign ADDR = reg_d1_out;
	assign WR_RD = ctrl2[1];
	
	assign enderecoMem1 = out_PC - 32'h0500;
	assign enderecoMem2 = reg_d1_out - 32'h1500;
	
//1º Estágio
	
	// Memória de programa
	instructionmemory inst_mem(
		.Clk(CLK_SYS),
		.endereco(enderecoMem1[9:0]),
		.saida(out_inst_mem)
	);
	
	// Contador de programa
	pc program_counter(
		.rst(rst),
		.Clk(CLK_SYS),
		.pc_endereco(out_PC)
	);

	
	
// 2º Estágio
	
	// Unidade de controle
	control CONTROL(
		.entrada(out_inst_mem),
		.saida(ctrl0)
	);
	 
	// Register File
	registerfile RF(
		.Clk(CLK_SYS),
		.rst(rst),
		.write(ctrl3[7]),
		.entradaWb(writeBack),
		.rs(ctrl0[22:18]),
		.rd(ctrl3[12:8]),
		.rt(ctrl0[17:13]),
		.a(regFile1),
		.b(regFile2)
	);
	
	// Extend
	extend EX(
		.entrada(out_inst_mem),
		.saida(ex_out)
	);

// Registros ID/EX
	Register A(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(regFile1),
		.q(regA)
	);
	 
	Register B(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(regFile2),
		.q(regB)
   );

	Register #(23) CTRL1 (
		.rst(rst),
		.Clk(CLK_SYS),
		.d(ctrl0[22:0]),
		.q(ctrl1[22:0])
	);

	Register IMM(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(ex_out),
		.q(reg_imm_out)
	);
	 
	 
	 
// 3º Estágio
	
	// Mux antes da ALU
	mux MUX1(
		.data1(regB),
		.data2(reg_imm_out),
		.sel(ctrl1[6]),
		.out(mux1_out)
	);
	  
	// ALU
	alu ALU(
		.a(regA),
		.b(mux1_out),
		.sel(ctrl1[5:4]),
		.out(out_ALU)
	);
	  
	// Multiplicador
	Multiplicador MULT(
		.Clk(CLK_MUL),
		.Multiplicador(regA[15:0]),
		.Multiplicando(regB[15:0]),
		.St(ctrl1[3]),
		.Produto(out_MULT)
	);

	// Mux depois da ALU
	mux MUX2(
		.data1(out_MULT),
		.data2(out_ALU),
		.sel(ctrl1[2]),
		.out(mux2_out)
	);
	
	
// Registros EX/MEM
	Register D1(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(mux2_out),
		.q(reg_d1_out)
	);
 
	Register B2(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(regB),
		.q(Data_BUS_WRITE)
	);
	

	Register #(23) CTRL2(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(ctrl1[22:0]),
		.q(ctrl2[22:0])
	);	 

	
// 4º Estágio
	 
	// Decodificador de endereços
	ADDRDecoding ADD (
		.address(reg_d1_out),
		.cs(CS)
	);

	// Memória de Dados
	datamemory MEM_DADOS (
		.Clk(CLK_SYS),
		.rd_wr(ctrl2[1]),
		.endereco(enderecoMem2[9:0]),
		.entrada(Data_BUS_WRITE),
		.saida(dout)
	);
	
	//modificação na estrutura do projeto para conseguir antigir objetivo
	//guarda o valor de cs para usar no mux ao ivés de guardar o valor da memória
	Register #(1) M (
		.rst(rst), 
		.Clk(CLK_SYS), 
		.d(cs), 
		.q(csM)
	);
	
	mux MUX3(
		.data1(dout),
		.data2(Data_BUS_READ),
		.sel(csM),
		.out(mux3_out)
	);
	
	
	Register D2(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(reg_d1_out),
		.q(reg_d2_out)
	);

	Register #(23) CTRL3(
		.rst(rst),
		.Clk(CLK_SYS),
		.d(ctrl2[22:0]),
		.q(ctrl3[22:0])
	);
	

// 5º estágio 
	mux MUX4(
		.data1(reg_d2_out),
		.data2(mux3_out),
		.sel(ctrl3[0]),
		.out(writeBack)
	);
	
	
 endmodule 