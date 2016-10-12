module reg4 (
input wire [3:0] new_card,
input wire load_pcard, 
input wire resetb,
input wire slow_clock,
output reg [3:0] cardOut);



always @(posedge slow_clock)

if(load_pcard) 
	cardOut=new_card;
else if (resetb)
	cardOut=4'b0000; 
endmodule
