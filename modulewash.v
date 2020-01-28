`timescale 1ns/1ps
module modulewash(CLK, Start,T2d);
input CLK, Start;
output reg T2d;
reg Reverse;
reg [3:0] InputMotor;
reg [9:0] rCLK;
reg startMotor;
always @ (posedge CLK, Start)
begin
	if(!Start)
		begin
		rCLK<=10'd0;
		startMotor <= 0;
		T2d <= 0;
		Reverse <= 0;
		end
	else if(Start)
		if(rCLK<10'd600)
		begin
		rCLK <= rCLK + 1'b1;
		startMotor <= 1;
		
		if(rCLK<10'd100 || (rCLK>10'd200 && rCLK<10'd300) || (rCLK>10'd400 && rCLK<10'd500))
		Reverse <= 0;
		else
		Reverse <= 1;	
		
		
		end
		else
		begin
		rCLK<=10'd0;
		T2d<=1'b1;
		end
end


always @ (CLK, Start)
if(startMotor)
	if(!Reverse)
		case(InputMotor)
			4'd1: InputMotor <=4'd8;
			4'd8: InputMotor <=4'd4;
			4'd4: InputMotor <=4'd2;
			4'd2: InputMotor <=4'd1;

		endcase
	else
		case(InputMotor)

			4'd1: InputMotor <=4'd2;
			4'd2: InputMotor <=4'd4;
			4'd4: InputMotor <=4'd8;
			4'd8: InputMotor <=4'd1;
		endcase
else InputMotor <=4'd1;	
endmodule