# Trabalho Final de ELTD05 - Projeto de Sistemas Digitais

## Grupo 7
	
>Bárbara Alves de Paiva Barbosa - 2020003139

>Maria Clara Martins Santana    - 2020012227

>Ryan Wyllyan Ribeiro Inácio    - 2020001770


## [Proposta de Projeto](/Documentacao/TrabalhoII_RISC_CPU_Mul_BUSController_Mux.pdf)

## Perguntas sobre o sistema:

**a) Qual a latência do sistema?**
	
	5 pulsos de clock, haja vista o pipeline 5 estágios o que configura esta latencia. 
	
**b) Qual o throughput do sistema?**
	
	O throughput é de 1 instrução por clock quando o pipeline estiver cheio, ou seja, após preencher todos os estágios.
	
**c) Qual a máxima frequência operacional entregue pelo Time Quest Timing Analizer para o multiplicador e para o sistema? (Indique a FPGA utilizada)**
	
	FPGA => Cyclone IV GX: EP4CGX150DF31I7AD
	Para realizar o Timing Analyzer  utilizou-se a configuração "Slow 1200mV 100C Model".
	Para o Multiplicador obteve-se fmax = 298.33 MHz.
	Para o Sistema obteve-se fmax = 97.98 MHz.
	
**d) Qual a máxima frequência de operação do sistema? (Indique a FPGA utilizada)**
	
	FPGA => Cyclone IV GX: EP4CGX150DF31I7AD
	O multiplicador leva 34 pulsos de clk para completar a operação, então, a frequência do sistema tem que ser 34 vezes menor que a dele.
	Desse modo, as frequências escolhidas foram:
		Para o Multiplicador foi de 250 MHz. (Restriced Fmax pelo Quartus)
		Para o Sistema foi  250/34 = 7.353 MHz
	
**e) Com a arquitetura implementada, a expressão (A*B) – (C+D) é executada corretamente (se executada em sequência ininterrupta)? Por quê? O que pode ser feito para que a expressão seja calculada corretamente?**
	
	Não, haja vista que tem-se "pipeline hazard", no qual o resultado de uma instrução ainda não está no registrador de destino.
	Ou seja, tem-se uma dependecia de dados e não obtem-se o valor correto para a expressão.
	Portanto, uma maneira de resolver esse problema é inserir 3 bolhas no pipeline depois das operações anteriores.
	
**f) Analisando a sua implementação de dois domínios de clock diferentes, haverá problemas com metaestabilidade? Por que?**
	
	Não, haja vista que o clock do sistema é um multiplo inteiro do clock do multiplicador. Desta forma a PLL mantém a fase sincronizada.

**g) A aplicação de um multiplicador do tipo utilizado, no sistema MIPS sugerido, é eficiente em termos de velocidade? Por que?**
	
	Não, já que essa implementação do multiplicador possui pipeline enrolada. Consequentemente, não há paralelismo  de operações.
	Por isso, demora vários ciclos de clock (34) para realizar a execução completa da multiplicação.

**h) Cite modificações cabíveis na arquitetura do sistema que tornaria o sistema mais rápido (frequência deoperação maior). Para cada modificação sugerida, qual a nova latência e throughput do sistema?**
	
	Haja vista que os problemas dessa arquitetura são devidos ao multiplicador podem ser aplicadas duas soluções sobre ele:
		1 - Mudar o multiplicador para outro que se adeque melhor a estrutura, ou seja, possua menor latencia. Nesta solução manteria-se a latência e throughput atual.
		2 - Manter o multiplicador atual, mas mudar o seu pipeline enrolado para um desenrolado com  34 estágios. Vale ressaltar que nessa solução também não seria necessário a PLL pois o sistema funcionaria com apenas um clock. Por fim, o throughput se manteria, mas a nova latencia seria de 38 pulsos de clock devido a nova estrutura de pipeline.

	
