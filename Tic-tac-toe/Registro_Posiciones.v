module Registro_Posiciones (
    input clk,
    input reset,
    input illegal_move,
    input [8:0] player1_p,
    input [8:0] player2_p,
    output reg [1:0] pos1, 
    output reg [1:0] pos2, 
    output reg [1:0] pos3, 
    output reg [1:0] pos4, 
    output reg [1:0] pos5, 
    output reg [1:0] pos6, 
    output reg [1:0] pos7, 
    output reg [1:0] pos8, 
    output reg [1:0] pos9
);
/*  Se debe evaluar si ha se ha apretado el boton de reset o si es un movimiento ilegal
    si no es movimiento ilegal entonces se evalua si el que juega es el player1 o el player2
    y en que posicion quiere jugar, luego se registra 01 cuando es player1 o 10 cuando es player2.
    hay que hacer esto por cada posicion (cada bit dentro del arreglo de 9 bits para p1 y p2), 
    es acá donde son utiles las señales del decodificador.
*/
//posicion 1
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos1 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos1 <= pos1; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[0] == 1'b1 )//si el bit en esta posicion del player1 esta encendido...
                pos1 <= 2'b01;
            else if (player2_p[0] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos1 <= 2'b10;
            else
                pos1 <= pos1;
        end
end

//posicion 2
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos2 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos2 <= pos2; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[1] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos2 <= 2'b01;
            else if (player2_p[1] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos2 <= 2'b10;
            else
                pos2 <= pos2;
        end
end

//posicion 3
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos3 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos3 <= pos3; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[2] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos3 <= 2'b01;
            else if(player2_p[2] == 1'b1) //si el bit en esta posicion del player2 esta encendido...
                pos3 <= 2'b10;
            else
                pos3 <= pos3;
        end
end

//posicion 4
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos4 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos4 <= pos4; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[3] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos4 <= 2'b01;
            else if (player2_p[3] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos4 <= 2'b10;
            else
                pos4 <= pos4;
        end
end

//posicion 5
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos5 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos5 <= pos5; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[4] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos5 <= 2'b01;
            else if (player2_p[4] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos5 <= 2'b10;
            else
                pos5 <= pos5;
        end
end

//posicion 6
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos6 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos6 <= pos6; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[5] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos6 <= 2'b01;
            else if (player2_p[5] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos6 <= 2'b10;
            else
                pos6 <= pos6;
        end
end

//posicion 7
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos7 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos7 <= pos7; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[6] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos7 <= 2'b01;
            else if (player2_p[6] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos7 <= 2'b10;
            else
                pos7 <= pos7;
        end
end

//posicion 8
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos8 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos8 <= pos8; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[7] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos8 <= 2'b01;
            else if (player2_p[7] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos8 <= 2'b10;
            else
                pos8 <= pos8;
        end
end

//posicion 9
always @ (posedge clk or posedge reset)
begin
    if(reset)
        pos9 <= 2'b00;
    else 
        begin
            if(illegal_move == 1'b1)
                pos9 <= pos9; // se mantiene la posicion si es movimiento ilegal
            else if(player1_p[8] == 1'b1)//si el bit en esta posicion del player1 esta encendido...
                pos9 <= 2'b01;
            else if (player2_p[8] == 1'b1)//si el bit en esta posicion del player2 esta encendido...
                pos9 <= 2'b10;
            else
                pos9 <= pos9;
        end
end

endmodule //
    