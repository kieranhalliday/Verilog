module state_machine(
input resetb,
input slowclock,
input [3:0] pscore,
input [3:0] dscore,
input [3:0] pcard3,
output reg load_pcard1,
output reg load_pcard2,
output reg load_pcard3,
output reg load_dcard1,
output reg load_dcard2,
output reg load_dcard3,
output reg player_win_light,
output reg dealer_win_light
);

reg [4:0] state=0;

always @(posedge slowclock)

	case(state)
//Deal the cards
	0: {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,
	    player_win_light,dealer_win_light,state}=13'b1000000000001;
	1: {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,
	    player_win_light,dealer_win_light,state}=13'b0001000000010;
	2: {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,
	    player_win_light,dealer_win_light,state}=13'b0100000000011;
	3: {load_pcard1,load_pcard2,load_pcard3,load_dcard1,load_dcard2,load_dcard3,
	    player_win_light,dealer_win_light,state}=13'b0000100000000;// Change next state to 4
	//FOR now use the two lights to show state
//Check for "natural" next
	default: load_pcard1=0;

endcase
endmodule
