module scorehand(
input wire [3:0] card1,
input wire [3:0] card2,
input wire [3:0] card3,
output reg [3:0] score);


always @(*)
	score = (card1+card2+card3) % 10;

endmodule
