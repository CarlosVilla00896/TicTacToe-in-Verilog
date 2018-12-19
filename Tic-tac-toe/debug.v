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
                else if ((player1 == 0) && (player2 ==1))
                    next_state = 2'b10;
                else
                    next_state = curr_state;
                
            end
            2'b10:
            begin
                player1_turn = 1'b0;
                player2_turn = 1'b1;
                if(((player2 == 1) && (player1 == 0)) || illegal_move)
                begin
                    next_state = curr_state;
                    // player2_turn = 1'b;
                end
                else if(((winner == 0) && (no_space == 0)) && (player2 == 0))
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

//fsm original
module fsm_controller(
     input reset,// clk of the circuit 
     input clk,// reset 
     player1, // player plays 
     player2,// computer plays 
     illegal_move,// illegal move detected 
     no_space, // no_space detected 
     winner, // winner detected 
     output reg player1_turn, // enable computer to player1 
     player2_turn // enable player to player1 
     );
// FSM States 
parameter IDLE=2'b00;
parameter PLAYER=2'b01;
parameter COMPUTER=2'b10;
parameter GAME_DONE=2'b11;
reg[1:0] curr_state, next_state;
// current state registers 
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
   next_state <= PLAYER; // player to player1 
  else 
   next_state <= IDLE;
  player2_turn <= 1'b0;
  player1_turn <= 1'b0;
 end 
 PLAYER:begin 
  player2_turn <= 1'b1;
  player1_turn <= 1'b0;
  if(illegal_move==1'b0)
   next_state <= COMPUTER; // computer to player1 
  else 
   next_state <= IDLE;
 end 
 COMPUTER:begin 
  player2_turn <= 1'b0;
  if(player2==1'b0) begin 
   next_state <= COMPUTER;
   player1_turn <= 1'b0;
  end
  else if(winner==1'b0 && no_space == 1'b0)
  begin 
   next_state <= IDLE;
   player1_turn <= 1'b1;// computer to player1 when PC=1
  end 
  else if(no_space == 1 || winner ==1'b1)
  begin 
   next_state <= GAME_DONE; // game done 
   player1_turn <= 1'b1;// computer to player1 when PC=1
  end  
 end 
 GAME_DONE:begin // game done
  player2_turn <= 1'b0;
  player1_turn <= 1'b0; 
  if(reset==1'b1) 
   next_state <= IDLE;// reset the game to IDLE 
  else 
   next_state <= GAME_DONE;  
 end 
 default: next_state <= IDLE; 
 endcase
 end
endmodule 

//fsm actual

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
            end
            2'b01: 
            begin
                if(illegal_move)
                    next_state = 2'b00;
                else 
                    next_state = 2'b10;
            end
            2'b10:
            begin
                // player1_turn = 1'b0;
                // player2_turn = 1'b1;
                if(player2 == 1)
                begin
                    next_state = curr_state;
                    // player2_turn = 1'b0;
                end
                else if((winner == 0) && no_space == 0)
                begin
                    next_state = 2'b00;
                    // player2_turn = 1'b1;
                end
                else if((winner == 1) || (no_space ==1))
                begin
                    next_state = 2'b11;
                    // player2_turn = 1;
                end
            end
            2'b11:
            begin
                // player1_turn = 0;
                // player2_turn = 0;
                if(reset)
                    next_state = 2'b00;
                else
                    next_state = curr_state;
            end
            default: next_state = curr_state;
        endcase    
    end

    always @ (*)
    begin
        case (curr_state)
            2'b00:
            begin
                player1_turn = 1'b0;
                player2_turn = 1'b0;
            end
            2'b01:
            begin
                player1_turn = 1'b1;
                player2_turn = 1'b0;
            end
            2'b10:
            begin
                player1_turn = 1'b0;
                player2_turn = 1'b1;
            end
            2'b11:
            begin
                player1_turn = 1'b0;
                player2_turn = 1'b0;
            end
        endcase
    end
endmodule