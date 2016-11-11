module ksa( CLOCK_50, LEDR);

input CLOCK_50;
output reg [9:0] LEDR;

wire donea,doneb,donec,doned;

top ka(CLOCK_50,8'b00000000,8'b0,8'b0,8'b00010000,donea,doneb,donec,doned);
top kb(CLOCK_50,8'b00010000,8'b0,8'b0,8'b00100000,doneb,donea,donec,doned);
top kc(CLOCK_50,8'b00100000,8'b0,8'b0,8'b00110000,donec,donea,doneb,doned);
top kd(CLOCK_50,8'b00110000,8'b0,8'b0,8'b00111111,doned,donea,doneb,donec);

assign LEDR[9:2] = 8'b0;

always @(posedge CLOCK_50) begin


	if(donea == 1'b1 || doneb == 1'b1 || donec == 1'b1 || doned== 1'b1) begin
		LEDR[0]=1'b1;
		LEDR[1]=1'b0;
	end else begin
		LEDR[0]=1'b0;
		LEDR[1]=1'b1;
	end

end
endmodule
 