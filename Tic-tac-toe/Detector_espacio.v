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
    output wire sin_espacio
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
endmodule