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
