module FSM_CONTROLLER(
    input reset,    
    input clk,
    input player1,
    input player2,
    input illegal_move,
    input no_space,   
    input winner,
    output reg player1_turn,
    output reg player2_turn
    );  

    reg [1:0] curr_state;
    reg [1:0] next_state;
    
    always @ (posedge clk)//cuando resetee
    begin
        if(reset)
            curr_state <=2'b00;
        else
            curr_state<=next_state;
    end
    
    always @(*)//Logica de los estados
    begin
        case (curr_state)
            2'b00: 
            begin
                if((reset == 0) && player1 == 1)
                    next_state = 2'b01;
                else
                    next_state = curr_state;
                    player1_turn = 2'b00;
                    player2_turn = 2'b00;
            end
            2'b01: 
            begin
                player1_turn = 1'b1;
                player2_turn = 1'b0;
                if(illegal_move)
                    next_state = 2'b00;
                else 
                    next_state = 2'b10;
            end
            2'b10:
            begin
                player1_turn = 1'b0;
                player2_turn = 1'b1;
                if(player2 == 0)
                begin
                    next_state = curr_state;
                    // player2_turn = 1'b;
                end
                else if((winner == 0) && no_space == 0)
                begin
                    next_state = 2'b00;
                    // player2_turn = 1;
                end
                else if((winner == 1) || (no_space ==1))
                begin
                    next_state = 2'b11;
                    // player2_turn = 1;
                end
            end
            2'b11:
            begin
                player1_turn = 0;
                player2_turn = 0;
                if(reset)
                    next_state = 2'b00;
                else
                    next_state = curr_state;
            end
            default: next_state = curr_state;
        endcase    
    end
endmodule