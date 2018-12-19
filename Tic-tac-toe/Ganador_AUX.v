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