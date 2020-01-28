`timescale 1s/1ps

module wash(nRESET, CLK, START, MEDIUMIn, LARGEIn, DIRTY, WET, MEDIUMOut, LARGEOut, WASH, RINSE, DRY);
input nRESET, CLK, START, MEDIUMIn, LARGEIn, DIRTY, WET ;
output reg MEDIUMOut, LARGEOut, WASH, RINSE, DRY;

parameter A = 3'b000; 
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter F = 3'b100;
parameter G = 3'b101;
parameter H = 3'b110;
parameter J = 3'b111;

reg T2DONE,T2DONEr,T2DONEd,T1DONE,T1START;
reg [11:0] Clock60;
reg [1:0] CYCLEDRYCLK;
wire wT2DONE,rT2DONE,dT2DONE;
reg [2:0] cstate, nstate;
reg [11:0] T1Time, T2Time;

always @ (negedge CLK, nRESET)
begin
	if(!nRESET)
	begin
	cstate <= A;
	T2DONE<=0;
	CYCLEDRYCLK<=0;
	Clock60<=0;
	end
	else
	cstate <= nstate;	
end



always @ (*) //NEXT STATE ASSIGNMENT
	begin
	if(!START) nstate <= A;
	else
		case(cstate)
		
		A: 
				casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONE})
				
					7'b0xxxxxx: begin nstate <= A; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00000; end
					7'b1101x00: begin nstate <=B; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b10000;  end //check if medium in and dirty
					7'b1011x00: begin nstate <=B; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b01000;  end //check if Large in and dirty
					
				
				endcase
			
		B:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONE})
				7'b1xx1x00:  begin nstate <= C; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY,T1START} = 7'b001001; end //start wash
		    endcase
			
		C:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONE})
				7'b1xxxx01:  begin nstate <= D; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00010; end //start rinse
				
			endcase
			
		D:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONEr})
				7'b1xx0x01:  begin nstate <= F; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY,T1START} = 7'b000010; end //clean then start dry
				7'b1xx1x01:  begin nstate <= C; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00100; end //dirty
				7'b1xx1x11:  begin nstate <= F; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00001; end //t1done
				
			endcase 
			
			
		F:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONEd})
				7'b1xxx1x1:  begin nstate <= G; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00001; end
				7'b1xxx0x1:  begin nstate <= H; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00000; end
			endcase
			
		G:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONEd})
				7'b1xxx0x1:  begin nstate <= H; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00000; end
				7'b1xxx1x1:  begin nstate <= J; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00001; end
			endcase
			
		H:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONE})
				7'b1xxxxxx:  begin nstate <= A; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00000; end
			
			endcase 
			
		J:  casex({START,MEDIUMIn,LARGEIn,DIRTY,WET,T1DONE,T2DONE})
				7'b1xxxxx1:  begin nstate <= H; {MEDIUMOut, LARGEOut, WASH, RINSE, DRY} = 7'b00000; end
			
			endcase 
			
		endcase	
	end
	
	
	
always @ (wT2DONE)
if(wT2DONE)
T2DONE <=1;	
always @ (negedge CLK)
if(T2DONE)
T2DONE <=0;


always @ (rT2DONE)
if(rT2DONE)
T2DONEr <=1;	
always @ (negedge CLK)
if(T2DONEr)
T2DONEr <=0;

always @ (dT2DONE)
if(dT2DONE)
T2DONEd <=1;	
always @ (negedge CLK)
if(T2DONEd)	T2DONEd <=0;


modulewash modulewashIT(CLK, WASH,wT2DONE);
modulerinse modulerinseIT(CLK, RINSE,rT2DONE);
moduledry moduledryIT(CLK, DRY,dT2DONE);


always @ (posedge CLK)
begin
	if(T1START)
	if(Clock60<12'd3600) begin
		Clock60 <= Clock60 + 1'b1;
		T1DONE<=0; 
		
		if(Clock60==12'd3599) T1DONE<=1; 
		
		end
	else
		begin
		Clock60<=12'd0;	
		end
	
end
endmodule