`timescale 1ns/1ps
module moduledry(CLK, Start,T2d);
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
	else
		if(rCLK<10'd600)
		begin
		rCLK <= rCLK + 1'b1;
		startMotor <= 1;
		T2d<=1'b0;
		end else
		begin
		rCLK<=10'd0;
		T2d<=1'b1;
		end
end
endmodule