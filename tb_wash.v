`timescale 1s/1ps
module tb_Complex;
reg  nRESET, CLK, START, MEDIUMIn, LARGEIn, DIRTY, WET;
wire MEDIUMOut, LARGEOut, WASH, RINSE, DRY;
wash uut(nRESET, CLK, START, MEDIUMIn, LARGEIn, DIRTY, WET, MEDIUMOut, LARGEOut, WASH, RINSE, DRY);

initial CLK=1'b0;
always #0.5 CLK=~CLK;

initial begin
$dumpfile("wash.vpd");
$dumpvars;

//$monitor("CLK: %b  nRESET: %b   START=%b   RED: %b YELLOW: %b  GREEN: %b", CLOCK, nRESET, START,RED,YELLOW,GREEN);


//Medium in test case after 1 rinse it is clean; 10 minutes of dry

#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1; WET=1;   
#2  DIRTY=0;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0;    //drying
#300 WET=0; 
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;    //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#1000




//Medium in test case after 1 rinse it is clean; 2 cycles of dry
#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1; WET=1;   
#2  DIRTY=0;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0;    //drying
#300 WET=1; 
#300 
#300  WET=0;
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;      //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#1000




//Large in test case after 1 rinse it is clean; 10 minutes of dry
#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=0; LARGEIn=1; DIRTY=1; WET=1;   
#2  DIRTY=0;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0;    //drying
#300 WET=0; 
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;    //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#1000


//test case after 2 rinses it is clean or 2 cycles; 20 minutes of dry
#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1; WET=1;   
#2  DIRTY=1;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1;    //DIRTY
#300 DIRTY=0; //CLEAN
#900;
#300 WET=1; 
#300 
#300  WET=0;
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;      //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#1000

//test case after 2 rinses it is clean or 2 cycles; 10 minutes of dry
#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1; WET=1;   
#2  DIRTY=1;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1;    //DIRTY
#300 DIRTY=0; //CLEAN
#900;
#300 WET=0; 
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;      //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#1000

//test case after 2 rinses it is clean or 2 cycles; 10 minutes of dry
#3  nRESET=0; START=0;
#1  nRESET=1;
#1  START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1; WET=1;   
#2  DIRTY=1;
#600 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;    //washing
#1 START=1; MEDIUMIn=1; LARGEIn=0; WET=1;   //rinsing
#600 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=0; WET=1;    //clean
#1 START=1; MEDIUMIn=1; LARGEIn=0; DIRTY=1;    //DIRTY
#300 DIRTY=1; 
#900;
#1198; 
#300 WET=0; 
#300 START=1; MEDIUMIn=0; LARGEIn=0; DIRTY=0;      //dry
#1 nRESET=0;START=0; MEDIUMIn=0; LARGEIn=0; DIRTY=0; WET=0;   //end
#4000







$finish;
end
endmodule
