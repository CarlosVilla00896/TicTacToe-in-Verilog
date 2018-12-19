module TicTacToe(
    input clk,
    input reset, //boton reset
    input player1, //boton para que el player1 juegue
    input player2, //boton para que el player2 juegue
    input [8:0] player1_posiciones, 
    input [8:0] player2_posiciones,
    output [1:0] pos1,
    output [1:0] pos2,
    output [1:0] pos3,
    output [1:0] pos4,
    output [1:0] pos5,
    output [1:0] pos6,
    output [1:0] pos7,
    output [1:0] pos8,
    output [1:0] pos9,
    output [1:0] winner_player,
    output wire draw
);

    wire [8:0] player1_posicionesp;
    wire [8:0] player2_posicionesp;
    wire illegal_move;
    wire winner;
    wire player1_turn;
    wire player2_turn;
    wire sin_espacio;

    Registro_Posiciones registro_pos(
        clk,
        reset,
        illegal_move,
        player1_posicionesp,
        player2_posicionesp,
        pos1,
        pos2,
        pos3,
        pos4,
        pos5,
        pos6,
        pos7,
        pos8,
        pos9
    );

    Ganador ganador(
        pos1, pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9, winner, winner_player
    );

    Posiciones p1_decodificar (player1_posiciones, player1_turn, player1_posicionesp );

    Posiciones p2_decodificador (player2_posiciones, player2_turn, player2_posicionesp);

    Movimiento_ilegal mov_ilegal (pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9, 
                                    player1_posicionesp, player2_posicionesp, illegal_move);

    Detector_de_espacio de (pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9,sin_espacio,draw);
    fsm_controller maquina_estado( 
        reset,
        clk,
        player1,
        player2,
        illegal_move,
        sin_espacio,
        winner,
        player1_turn,
        player2_turn
    );

endmodule // TicTacToe

//fsm original
module fsm_controller(
    input reset,
    input clk,
    player1, 
    player2,
    illegal_move,
    no_space, 
    winner, 
    output reg player1_turn,
    player2_turn 
);
    // los estados del juego 
    parameter IDLE=2'b00;
    parameter PLAYER1=2'b01;
    parameter PLAYER2=2'b10;
    parameter GAME_DONE=2'b11;
    reg[1:0] curr_state, next_state;
    // Logica de estados 
    always @(posedge clk or posedge reset) 
    begin 
        if(reset)
        curr_state <= IDLE;
        else 
        curr_state <= next_state;
    end 
    // next state 
    always @(*)
    begin
        case(curr_state)
            IDLE: begin 
                if(reset==1'b0 && player1 == 1'b1)
                    next_state <= PLAYER1; 
                else 
                    next_state <= IDLE;
                    player1_turn <= 1'b0;
                    player2_turn <= 1'b0;
            end 
            PLAYER1:begin 
                player1_turn <= 1'b1;
                player2_turn <= 1'b0;
                if(illegal_move==1'b0)
                    next_state <= PLAYER2; 
                else 
                    next_state <= IDLE;
            end 
            PLAYER2:begin 
                player1_turn <= 1'b0;
                if(player2==1'b0) begin 
                    next_state <= PLAYER2;
                    player2_turn <= 1'b0;
                end
                else if(winner==1'b0 && no_space == 1'b0)
                begin 
                    next_state <= IDLE;
                    player2_turn <= 1'b1;
                end 
                else if(no_space == 1 || winner ==1'b1)
                begin 
                    next_state <= GAME_DONE; 
                    player2_turn <= 1'b1;
                end  
            end 
            GAME_DONE:begin // game done
                player1_turn <= 1'b0;
                player2_turn <= 1'b0; 
                if(reset==1'b1) 
                    next_state <= IDLE;// reset the game to IDLE 
                else 
                    next_state <= GAME_DONE;  
            end 
            default: next_state <= IDLE; 
        endcase
    end
endmodule 

//Registro de las posiciones

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

//decoder

module Posiciones(
    input[8:0] posiciones_tablero, 
    input enable, 
    output wire [8:0] out_en
);
    reg[8:0] temp1;
    assign out_en = (enable==1'b1)?temp1:9'b000000000;

    /*se decodifican las posiciones para que el proceso de detectar espacio, movimiento ilegal y 
        ganador sea mas facil al analizar bit encendido por posicion. 
        Recordar que se usan registros de 4 bits para almacenar la2 9 combinaciones de las 9 posiciones
        el mayor valor representado por los 4 bits son 16 valores, es por eso que se codifican
        los 16 valores de los cuales luego solo se usan 9.
    */

    always @(*)
    begin
        case(posiciones_tablero)
            9'b000000000: temp1 <= 9'b000000000;
            9'b000000001: temp1 <= 9'b000000001; 
            9'b000000010: temp1 <= 9'b000000010;
            9'b000000100: temp1 <= 9'b000000100;
            9'b000001000: temp1 <= 9'b000001000;
            9'b000010000: temp1 <= 9'b000010000;
            9'b000100000: temp1 <= 9'b000100000;
            9'b001000000: temp1 <= 9'b001000000;
            9'b010000000: temp1 <= 9'b010000000;
            9'b100000000: temp1 <= 9'b100000000;
            default: temp1 <= 9'b000000000; 
        endcase 
    end 
endmodule 

//Ganador

module Ganador(
    input[1:0] pos1,
    input[1:0] pos2,
    input[1:0] pos3,
    input[1:0] pos4,
    input[1:0] pos5,
    input[1:0] pos6,
    input[1:0] pos7,
    input[1:0] pos8,
    input[1:0] pos9,
    output winner,
    output [1:0] winner_player
    
);
    /*Las condiciones en las que se gana son cuando se hace 3 en linea:
        (1,2,3), (4,5,6), (7,8,9), (1,4,7),(2,5,8), (3,6,9), (1,5,9), (3,5,7)
     */
    wire win1, win2, win3, win4, win5, win6, win7, win8;
    wire [1:0] winner_player1, winner_player2, winner_player3, winner_player4,winner_player5, winner_player6,winner_player7,winner_player8;

    Ganador_AUX f1(pos1, pos2, pos3, win1, winner_player1); //(1,2,3)
    Ganador_AUX f2(pos4, pos5, pos6, win2, winner_player2); //(4,5,6)
    Ganador_AUX f3(pos7, pos8, pos9, win3, winner_player3); //(7,8,9)
    Ganador_AUX f4(pos1, pos4, pos7, win4, winner_player4); //(1,4,7)
    Ganador_AUX f5(pos2, pos5, pos8, win5, winner_player5); //(2,5,8)
    Ganador_AUX f6(pos3, pos6, pos9, win6, winner_player6); //(3,6,9)
    Ganador_AUX f7(pos1, pos5, pos9, win7, winner_player7); //(1,5,9)
    Ganador_AUX f8(pos3, pos5, pos7, win8, winner_player8); //(3,5,7)

    assign winner = (((((((win1 | win2) | win3) | win4) | win5) | win6) | win7) | win8);
    assign winner_player = (((((((winner_player1 | winner_player2) | winner_player3) 
                                    | winner_player4) | winner_player5) | winner_player6) 
                                    | winner_player7) | winner_player8);

endmodule // Ganador

module Ganador_AUX(
    input [1:0] pos0,
    input [1:0] pos1, 
    input [1:0] pos2,
    output winner,
    output [1:0] winner_player
);
    wire [1:0] t0, t1, t2;
    wire winner_;

    assign t0[1] = !(pos0[1]^pos1[1]);
    assign t0[0] = !(pos0[0]^pos1[0]);
    assign t1[1] = !(pos2[1]^pos1[1]);
    assign t1[0] = !(pos2[0]^pos1[0]);
    assign t2[1] = t0[1] & t1[1];
    assign t2[0] = t0[0] & t1[0];
    assign winner_ = pos0[1] | pos0[0];
    // winner if 3 positions are similar and should be 01 or 10 
    assign winner = winner_ & t2[1] & t2[0];
    // determine who the winner is 
    assign winner_player[1] = winner & pos0[1];
    assign winner_player[0] = winner & pos0[0];

endmodule // Ganador_AUX

//Detector espacios

module Detector_de_espacio (
    input [1:0] pos1,
    input [1:0] pos2,
    input [1:0] pos3,
    input [1:0] pos4,
    input [1:0] pos5,
    input [1:0] pos6,
    input [1:0] pos7,
    input [1:0] pos8,
    input [1:0] pos9,
    output wire sin_espacio,
    output wire draw
);

wire pos1_space;
wire pos2_space;
wire pos3_space;
wire pos4_space;
wire pos5_space; 
wire pos6_space;
wire pos7_space;
wire pos8_space;
wire pos9_space;

/*Si alguna de las posiciones está vacía el resultado de sin_espacio será 0 
    pero si todas las posiciones están tomadas los pos_space serán 1 por lo tanto
    sin_espacio será 1.
*/

assign pos1_space = pos1[1] | pos1[0];
assign pos2_space = pos2[1] | pos2[0];
assign pos3_space = pos3[1] | pos3[0];
assign pos4_space = pos4[1] | pos4[0];
assign pos5_space = pos5[1] | pos5[0];
assign pos6_space = pos6[1] | pos6[0];
assign pos7_space = pos7[1] | pos7[0];
assign pos8_space = pos8[1] | pos8[0];
assign pos9_space = pos9[1] | pos9[0];

assign sin_espacio = ((((((((pos1_space & pos2_space) & pos3_space) & pos4_space) 
                            & pos5_space) & pos6_space) & pos7_space) & pos8_space) & pos9_space);
assign draw = sin_espacio;
endmodule

//Movimiento ilegal

module Movimiento_ilegal(
    input [1:0] pos1,
    input [1:0] pos2,
    input [1:0] pos3,
    input [1:0] pos4,
    input [1:0] pos5,
    input [1:0] pos6,
    input [1:0] pos7,
    input [1:0] pos8,
    input [1:0] pos9,
    input [8:0] player1_p,
    input [8:0] player2_p,
    output wire illegal_move
);

    wire p1_mi1;
    wire p1_mi2;
    wire p1_mi3;
    wire p1_mi4;
    wire p1_mi5;
    wire p1_mi6;
    wire p1_mi7;
    wire p1_mi8;
    wire p1_mi9;

    wire p2_mi1;
    wire p2_mi2;
    wire p2_mi3;
    wire p2_mi4;
    wire p2_mi5;
    wire p2_mi6;
    wire p2_mi7;
    wire p2_mi8;
    wire p2_mi9;

    wire p1_mit;
    wire p2_mit;
    //cuando la posicion este tomada y un jugador quiera jugarla el resultado para p1_mi sera 1

    //player1 movimiento ilegal por posicion
    assign p1_mi1 = (pos1[1] | pos1[0]) & player1_p[0];
    assign p1_mi2 = (pos2[1] | pos2[0]) & player1_p[1];
    assign p1_mi3 = (pos3[1] | pos3[0]) & player1_p[2];
    assign p1_mi4 = (pos4[1] | pos4[0]) & player1_p[3];
    assign p1_mi5 = (pos5[1] | pos5[0]) & player1_p[4];
    assign p1_mi6 = (pos6[1] | pos6[0]) & player1_p[5];
    assign p1_mi7 = (pos7[1] | pos7[0]) & player1_p[6];
    assign p1_mi8 = (pos8[1] | pos8[0]) & player1_p[7];
    assign p1_mi9 = (pos9[1] | pos9[0]) & player1_p[8];

    //player2 movimiento ilegal por posicion
    assign p2_mi1 = (pos1[1] | pos1[0]) & player2_p[0];
    assign p2_mi2 = (pos2[1] | pos2[0]) & player2_p[1];
    assign p2_mi3 = (pos3[1] | pos3[0]) & player2_p[2];
    assign p2_mi4 = (pos4[1] | pos4[0]) & player2_p[3];
    assign p2_mi5 = (pos5[1] | pos5[0]) & player2_p[4];
    assign p2_mi6 = (pos6[1] | pos6[0]) & player2_p[5];
    assign p2_mi7 = (pos7[1] | pos7[0]) & player2_p[6];
    assign p2_mi8 = (pos8[1] | pos8[0]) & player2_p[7];
    assign p2_mi9 = (pos9[1] | pos9[0]) & player2_p[8];

    //player1 y player2 movimiento ilegal
    assign p1_mit = ((((((((p1_mi1 | p1_mi2 ) | p1_mi3) | p1_mi4) | p1_mi5) | p1_mi6) | p1_mi7) | p1_mi8) | p1_mi9); 
    assign p2_mit = ((((((((p2_mi1 | p2_mi2 ) | p2_mi3) | p2_mi4) | p2_mi5) | p2_mi6) | p2_mi7) | p2_mi8) | p2_mi9);

    //verificar si hay movimiento ilegal del player1 o player2
    assign illegal_move = p1_mit | p2_mit;

endmodule // Movimiento_ilegal