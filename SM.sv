module SM(input clock, input [7:0] center_x, input [6:0] center_y, output reg [2:0] colour,output reg plot, output reg [7:0] xp, output reg [6:0] yp, output reg [2:0] turn);


parameter radius=25;
reg [10:0] current_state=0, next_state=1;
reg initx,inity,loady,loadx, xdone, ydone; 
reg [7:0] offset_x=radius;
reg [6:0] offset_y=0;
reg signed [8:0] crit=1-radius;

//SM
 always_comb
     case (current_state)  
    2'b00: {initx,inity,loady,loadx,plot,colour} <= 8'b11110000;
    2'b01: {initx,inity,loady,loadx,plot,colour} <= 8'b10110000;
    2'b10: {initx,inity,loady,loadx,plot,colour} <= 8'b00011000;
	3: {initx,inity,loady,loadx,plot,colour} <= 8'b00011000; //changed states 3 and 4 from 001
	4: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001; //second change was back to 001
	5: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	6: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	7: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	8: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	9: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	10: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	11: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	12: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
    default:{initx,inity,loady,loadx,plot,colour} <= 8'b00010000;
  endcase

  always_ff @(posedge(clock))
     current_state <= next_state;

  always_comb
     case (current_state)  
    0: next_state <= 2;
    1: next_state <= 2;
    2: if (xdone == 0) next_state <= 2;
        else if (ydone == 0) next_state <= 1;
         else next_state <= 3;
	//Check while condition
	3: if(turn!=1) next_state=3;
		else if(offset_y<=offset_x) next_state=4;
		else next_state=15;
	4: next_state=5;
	/*3: if(offset_y<=offset_x)
		next_state=4;
	   else
		next_state=15;
	//BEGIN WHILE LOOP
	//Draw pixels
	4: if(turn!=1) next_state=4;
		else next_state=5;*/
	5: next_state=6;
	6: next_state=7;
	7: next_state=8;
	8: next_state=9;
	9: next_state=10;
	10: next_state=11;
	11: next_state=12;
	12: next_state=3;
	15: next_state=3;
    default: next_state <= 0;
     endcase

//DATAPATH
 always_ff @(posedge(clock))
 begin
     if (loady == 1)
        if (inity == 1)
           yp = 0;
        else begin
           yp ++;
	end
     if (loadx == 1)
        if (initx == 1) begin
           xp = 0;
        end else
           xp ++;
     ydone <= 0;
     xdone <= 0;

	//PART 3
	if(current_state==15) begin
	turn=3'b100;
	offset_x=radius;
	offset_y=0;
	crit=1-radius;
	end else begin
	turn=1;
	end //changed here ^^


	if(current_state==4) begin
	xp=center_x+offset_x;
	yp=center_y+offset_y;
	end
	if(current_state==5) begin
	xp=center_x+offset_y;
	yp=center_y+offset_x;
	end
	if(current_state==6) begin
	xp=center_x-offset_x;
	yp=center_y+offset_y;
	end
	if(current_state==7) begin
	xp=center_x-offset_y;
	yp=center_y+offset_x;
	end
	if(current_state==8) begin
	xp=center_x+offset_x;
	yp=center_y-offset_y;
	end
	if(current_state==9) begin
	xp=center_x+offset_y;
	yp=center_y-offset_x;
	end
	if(current_state==10) begin
	xp=center_x-offset_x;
	yp=center_y-offset_y;
	end
	if(current_state==11) begin
	xp=center_x-offset_y;
	yp=center_y-offset_x;
	end
	if(current_state==12) begin
		offset_y=offset_y+1;
	    if(crit<=0)
		crit=crit+2*offset_y+1;
	    else begin
		offset_x=offset_x-1;
		crit = crit + 2 * (offset_y-offset_x) + 1;
	end

	//turn=1;
end
	

	//END PART 3 
     if (yp == 119)
        ydone <= 1;
     if (xp == 159)
        xdone <= 1;
 end
endmodule
