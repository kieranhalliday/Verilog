//PART 3 that works
module task2 (CLOCK_50, 
		 KEY,             
       VGA_R, VGA_G, VGA_B, 
       VGA_HS,             
       VGA_VS,             
       VGA_BLANK,           
       VGA_SYNC,            
       VGA_CLK);
  
input CLOCK_50;
input [3:0] KEY;
output [9:0] VGA_R, VGA_G, VGA_B; 
output VGA_HS;             
output VGA_VS;          
output VGA_BLANK;           
output VGA_SYNC;            
output VGA_CLK;

// Some constants that might be useful for you

parameter SCREEN_WIDTH = 160;
parameter SCREEN_HEIGHT = 120;

parameter BLACK = 3'b000;
parameter BLUE = 3'b001;
parameter GREEN = 3'b010;
parameter YELLOW = 3'b110;
parameter RED = 3'b100;
parameter WHITE = 3'b111;
//PART 3
parameter radius=20; //works with 30
reg center_x=40;
reg center_y=40;
//PART 3

// To VGA adapter
wire resetn;
wire [7:0] x;
wire [6:0] y;
reg  [2:0] colour;

//MY STUFF part 2

reg initx,inity,loady,loadx,plot; 
reg [7:0] xp;
reg [6:0] yp;

//PART 4
wire [2:0]colourB,colourR,colourW,colourY,colourG;
wire plotB,plotR,plotG,plotW,plotY;
wire [7:0] xpB,xpR,xpG,xpY,xpW;
wire [6:0] ypB,ypR,ypG,ypY,ypW;
reg [2:0] turnB,turnR,turnG,turnW,turnY, turnReal=BLUE;
  
// instantiate VGA adapter	
vga_adapter #( .RESOLUTION("160x120"))
    vga_u0 (.resetn(KEY[3]),
	         .clock(CLOCK_50),
			   .colour(colour),
			   .x(xp),
			   .y(yp),
			   .plot(plot),
			   .VGA_R(VGA_R),
			   .VGA_G(VGA_G),
			   .VGA_B(VGA_B),	
			   .VGA_HS(VGA_HS),
			   .VGA_VS(VGA_VS),
			   .VGA_BLANK(VGA_BLANK),
			   .VGA_SYNC(VGA_SYNC),
			   .VGA_CLK(VGA_CLK));


// Your code to fill the screen goes her
SM blue(CLOCK_50,40,40,colourB,plotB,xpB,ypB,turnB);
SMR red(CLOCK_50,80,40,colourR,plotR,xpR,ypR,turnR);
SMW white(CLOCK_50,120,40,colourW,plotW,xpW,ypW,turnW);
SMG green(CLOCK_50,60,80,colourG,plotG,xpG,ypG,turnG);
SMY yellow(CLOCK_50,100,80,colourY,plotY,xpY,ypY,turnY);

always @(posedge CLOCK_50) begin
	//turnReal=turn;
	if(turnReal==BLUE) begin
		colour=colourB;
 		plot=plotB;
		xp=xpB;
		yp=ypB;
		turnReal=turnB;
	end else if(turnReal==RED) begin
		colour=colourR;
		plot=plotR;
		xp=xpR;
		yp=ypR;
		turnReal=turnR;
	end else if(turnReal==WHITE) begin
		colour=colourW;
 		plot=plotW;
		xp=xpW;
		yp=ypW;
		turnReal=turnW;
	end else if(turnReal==YELLOW) begin
		colour=colourY;
		plot=plotY;
		xp=xpY;
		yp=ypY;
		turnReal=turnY;
	end else if(turnReal==GREEN) begin
		colour=colourG;
		plot=plotG;
		xp=xpG;
		yp=ypG;
		turnReal=turnG;
	end
end
/*always @(posedge CLOCK_50) begin
	if (turn==RED) begin
		  colour=colourR;
 		  plot=plotR;
		  xp=xpR;
		  yp=ypR;
		  turn1=3'b100;
	end else begin
		  colour=colourB;
 		  plot=plotB;
		  xp=xpB;
		  yp=ypB;
	end
end
*/

endmodule
/*
//PART 3 that works
module task2 (CLOCK_50, 
		 KEY,             
       VGA_R, VGA_G, VGA_B, 
       VGA_HS,             
       VGA_VS,             
       VGA_BLANK,           
       VGA_SYNC,            
       VGA_CLK);
  
input CLOCK_50;
input [3:0] KEY;
output [9:0] VGA_R, VGA_G, VGA_B; 
output VGA_HS;             
output VGA_VS;          
output VGA_BLANK;           
output VGA_SYNC;            
output VGA_CLK;

// Some constants that might be useful for you

parameter SCREEN_WIDTH = 160;
parameter SCREEN_HEIGHT = 120;

parameter BLACK = 3'b000;
parameter BLUE = 3'b001;
parameter GREEN = 3'b010;
parameter YELLOW = 3'b110;
parameter RED = 3'b100;
parameter WHITE = 3'b111;
//PART 3
parameter radius=20;
parameter center_x=40;
parameter center_y=40;
//PART 3

// To VGA adapter
wire resetn;
wire [7:0] x;
wire [6:0] y;
reg  [2:0] colour=0;

//MY STUFF part 2
reg [10:0] current_state=0, next_state=1;
reg initx,inity,loady,loadx,plot,xdone,ydone; 
reg [6:0] yp;
reg [7:0] xp;

//PART 3
reg [7:0] offset_x=radius;
reg [6:0] offset_y=0;
reg signed [8:0] crit=1-radius;
  
// instantiate VGA adapter	
vga_adapter #( .RESOLUTION("160x120"))
    vga_u0 (.resetn(KEY[3]),
	         .clock(CLOCK_50),
			   .colour(colour),
			   .x(xp),
			   .y(yp),
			   .plot(plot),
			   .VGA_R(VGA_R),
			   .VGA_G(VGA_G),
			   .VGA_B(VGA_B),	
			   .VGA_HS(VGA_HS),
			   .VGA_VS(VGA_VS),
			   .VGA_BLANK(VGA_BLANK),
			   .VGA_SYNC(VGA_SYNC),
			   .VGA_CLK(VGA_CLK));


// Your code to fill the screen goes her
//SM
 always_comb
     case (current_state)  
    2'b00: {initx,inity,loady,loadx,plot,colour} <= 8'b11110000;
    2'b01: {initx,inity,loady,loadx,plot,colour} <= 8'b10110000;
    2'b10: {initx,inity,loady,loadx,plot,colour} <= 8'b00011000;
	3: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
	4: {initx,inity,loady,loadx,plot,colour} <= 8'b00011001;
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
  always_ff @(posedge(CLOCK_50))
     current_state <= next_state;
  always_comb
     case (current_state)  
    0: next_state <= 2;
    1: next_state <= 2;
    2: if (xdone == 0) next_state <= 2;
        else if (ydone == 0) next_state <= 1;
         else next_state <= 3;
	//Check while condition
	3: if(offset_y<=offset_x)
		next_state=4;
	   else
		next_state=15;
	//BEGIN WHILE LOOP
	//Draw pixels
	4: next_state=5;
	5: next_state=6;
	6: next_state=7;
	7: next_state=8;
	8: next_state=9;
	9: next_state=10;
	10: next_state=11;
	11: next_state=12;
	12: next_state=3;
	15: next_state=15;
    default: next_state <= 0;
     endcase

//DATAPATH
 always_ff @(posedge(CLOCK_50))
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
	end
	//END PART 3 
     if (yp == 119)
        ydone <= 1;
     if (xp == 159)
        xdone <= 1;
 end
endmodule

*/
//PART 2 that works
/* module task2 (CLOCK_50, 
		 KEY,             
       VGA_R, VGA_G, VGA_B, 
       VGA_HS,             
       VGA_VS,             
       VGA_BLANK,           
       VGA_SYNC,            
       VGA_CLK);
  
input CLOCK_50;
input [3:0] KEY;
output [9:0] VGA_R, VGA_G, VGA_B; 
output VGA_HS;             
output VGA_VS;          
output VGA_BLANK;           
output VGA_SYNC;            
output VGA_CLK;

// Some constants that might be useful for you

parameter SCREEN_WIDTH = 160;
parameter SCREEN_HEIGHT = 120;

parameter BLACK = 3'b000;
parameter BLUE = 3'b001;
parameter GREEN = 3'b010;
parameter YELLOW = 3'b110;
parameter RED = 3'b100;
parameter WHITE = 3'b111;

  // To VGA adapter
  
wire resetn;
wire [7:0] x;
wire [6:0] y;
reg  [2:0] colour=0;

//MY STUFF part 2
reg [1:0] current_state=0, next_state=1;
reg initx,inity,loady,loadx,plot,xdone,ydone; 
reg [6:0] yp;
reg [7:0] xp;
  
// instantiate VGA adapter	
vga_adapter #( .RESOLUTION("160x120"))
    vga_u0 (.resetn(KEY[3]),
	         .clock(CLOCK_50),
			   .colour(colour),
			   .x(xp),
			   .y(yp),
			   .plot(plot),
			   .VGA_R(VGA_R),
			   .VGA_G(VGA_G),
			   .VGA_B(VGA_B),	
			   .VGA_HS(VGA_HS),
			   .VGA_VS(VGA_VS),
			   .VGA_BLANK(VGA_BLANK),
			   .VGA_SYNC(VGA_SYNC),
			   .VGA_CLK(VGA_CLK));


// Your code to fill the screen goes her
//SM
 always_comb
     case (current_state)  
    2'b00: {initx,inity,loady,loadx,plot} <= 5'b11110;
    2'b01: {initx,inity,loady,loadx,plot} <= 5'b10110;
    2'b10: {initx,inity,loady,loadx,plot} <= 5'b00011;
    default: {initx,inity,loady,loadx,plot} <= 5'b00010;
  endcase
  always_ff @(posedge(CLOCK_50))
     current_state <= next_state;
  always_comb
     case (current_state)  
    2'b00: next_state <= 2'b10;
    2'b01: next_state <= 2'b10;
    2'b10: if (xdone == 0) next_state <= 2'b10;
        else if (ydone == 0) next_state <= 2'b01;
         else next_state <= 2'b11;
            default: next_state <= 2'b11;
     endcase

//DATAPATH
 always_ff @(posedge(CLOCK_50))
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
     if (yp == 119)
        ydone <= 1;
     if (xp == 159)
        xdone <= 1;
 end
endmodule

*/

