module Lab1_top (
input KEY0, //Slow clock
input KEY3, //Reset
input CLOCK50,
output [6:0] HEX0,
output [6:0] HEX1,
output [6:0] HEX2,
output [6:0] HEX3,
output [6:0] HEX4,
output [6:0] HEX5,
output [0:9] LEDR);


wire [3:0] pscore, dscore, new_card, card_outP1,card_outP2,card_outP3, card_outD1,card_outD2,card_outD3;

wire load_pcard1,load_pcard2,load_pcard3, load_dcard1,load_dcard2,load_dcard3;

state_machine SM(KEY3,KEY0,pscore,dscore,card_outP3,
	      load_pcard1,load_pcard2,load_pcard3,
	      load_dcard1,load_dcard2,load_dcard3,
	      LEDR[8],LEDR[9]);

//Deal cards
dealcard dealer (CLOCK50,KEY3,new_card);

// Regs to hold cards
reg4 PCard1 (new_card,load_pcard1,KEY3,KEY0,card_outP1);
reg4 PCard2 (new_card,load_pcard2,KEY3,KEY0,card_outP2);
reg4 PCard3 (new_card,load_pcard3,KEY3,KEY0,card_outP3);

reg4 DCard1 (new_card,load_dcard1,KEY3,KEY0,card_outD1);
reg4 DCard2 (new_card,load_dcard2,KEY3,KEY0,card_outD2);
reg4 DCard3 (new_card,load_dcard3,KEY3,KEY0,card_outD3);

//Display cards on seven segments
card7seg PCardOut1 (card_outP1, HEX0);
card7seg PCardOut2 (card_outP2, HEX1);
card7seg PCardOut3 (card_outP3, HEX2);

card7seg DCardOut1 (card_outD1, HEX3);
card7seg DCardOut2 (card_outD2, HEX4);
card7seg DCardOut3 (card_outD3, HEX5);

//Score hands
scorehand PlayerScore(card_outP1,card_outP2,card_outP3,pscore);
scorehand DealerScore(card_outD1,card_outD2,card_outD3,dscore);

//Display Scores
assign LEDR[0:3] = pscore;
assign LEDR[4:7] = dscore;

endmodule
