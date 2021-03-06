module acumulador(input wire clk, input wire reset, input wire tempoLimite, 
input wire [1:0] valorMoeda, output reg [3:0] valorAcumulado);

    reg [3:0] estadoAtual, proxEstado;

    localparam E0_00 = 4'b0000,   //0,00 - Estado Inicial
               E0_25 = 4'b0001,   //0,25
               E0_50 = 4'b0010,   //0,50
               E0_75 = 4'b0011,   //0,75
               E1_00 = 4'b0100,   //1,00
               E1_25 = 4'b0101,   //1,25
               E1_50 = 4'b0110,   //1,50
               E1_75 = 4'b0111,   //1,75
               E2_00 = 4'b1000,   //2,00
					EX   = 4'b1111,

               // Valor Moedas
               M0_25 = 2'b01,
               M0_50 = 2'b10,
               M1_00 = 2'b11,


               //Estados Inválidos

					E_INV1 = 4'b1001,
               E_INV2 = 4'b1010,
               E_INV3 = 4'b1011,
               E_INV4 = 4'b1100,
               E_INV5 = 4'b1101,
               E_INV6 = 4'b1110;
               


    always @(posedge clk or posedge reset) begin   // atualização do estado
		if(reset)
			estadoAtual <= E0_00;
		else
        estadoAtual <= proxEstado;
    end
	 
	 
	 
	 
	 always @(estadoAtual or valorMoeda or tempoLimite) begin //Lógica de transição de estado
			if(tempoLimite)
				proxEstado <= E0_00;
			else begin
				case(estadoAtual)
					E0_00: begin
						 case (valorMoeda)
						 M0_25 : proxEstado <= E0_25;  
						 M0_50 : proxEstado <= E0_50;  
						 M1_00 : proxEstado <= E1_00;
						 default: proxEstado <= estadoAtual;
					  endcase
					end
					E0_25: begin
						 case (valorMoeda)
						 M0_25 : proxEstado <= E0_50;  
						 M0_50 : proxEstado <= E0_75;  
						 M1_00 : proxEstado <= E1_25; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end

					E0_50: begin
						 case (valorMoeda)
						 M0_25 : proxEstado <= E0_75;  
						 M0_50 : proxEstado <= E1_00;  
						 M1_00 : proxEstado <= E1_50; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end

					E0_75: begin
						 case (valorMoeda)
						 M0_25 : proxEstado <= E1_00;  
						 M0_50:  proxEstado <= E1_25;  
						 M1_00 : proxEstado <= E1_75; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end

					E1_00: begin
						case (valorMoeda)
						 M0_25 : proxEstado <= E1_25;  
						 M0_50 : proxEstado <= E1_50;  
						 M1_00 : proxEstado <= E2_00; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end

					E1_25: begin
						case (valorMoeda)
						 M0_25 : proxEstado <= E1_50;  
						 M0_50 : proxEstado <= E1_75;  
						 M1_00 : proxEstado <= EX; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end


					E1_50: begin
						case (valorMoeda)
						 M0_25 : proxEstado <= E1_75;  
						 M0_50 : proxEstado <= E2_00;  
						 M1_00 : proxEstado <= EX; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end

					E1_75: begin
						case (valorMoeda)
						 M0_25 : proxEstado <= E2_00;  
						 M0_50 : proxEstado <= EX;  
						 M1_00 : proxEstado <= EX;
						 default: proxEstado <= estadoAtual; 
						 endcase
					end

					E2_00: begin
						case (valorMoeda)
						 M0_25 : proxEstado <= EX;  
						 M0_50 : proxEstado <= EX;  
						 M1_00 : proxEstado <= EX; 
						 default: proxEstado <= estadoAtual;
						 endcase
					end
					EX: begin
						proxEstado <= EX;
					end
					default: proxEstado <= E0_00; //Estado Inválidos
				endcase
		  end
    end
	 
	 
	 always @(estadoAtual)
			valorAcumulado <= estadoAtual;


			
		
	 
	 
              
endmodule
