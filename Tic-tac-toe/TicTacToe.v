module TicTacToe(
    input clk,
    input reset, //boton reset
    input player1, //boton para que el player1 juegue
    input player2, //boton para que el player2 juegue
    input [3:0] player1_posiciones, 
    input [3:0] player2_posiciones,
    output [1:0] pos1,
    output [1:0] pos2,
    output [1:0] pos3,
    output [1:0] pos4,
    output [1:0] pos5,
    output [1:0] pos6,
    output [1:0] pos7,
    output [1:0] pos8,
    output [1:0] pos9,
    output [1:0] winner_player
);

    wire [15:0] player1_posicionesp;
    wire [15:0] player2_posicionesp;
    wire illegal_move;
    wire winner;
    wire player1_turn;
    wire player2_turn;
    wire sin_espacio;

    Registro_Posiciones registro_pos(
        clk,
        reset,
        illegal_move,
        player1_posicionesp [8:0],
        player2_posicionesp [8:0],
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
                                    player1_posicionesp[8:0], player2_posicionesp[8:0], illegal_move);

    Detector_de_espacio de (pos1,pos2,pos3,pos4,pos5,pos6,pos7,pos8,pos9,sin_espacio);
    FSM_CONTROLLER maquina_estado( 
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