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