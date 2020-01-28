## A computation model employing the concept of Finite state machine that can be implemented using hardware or software and written using Verilog(C)


#MAIN
#Inputs:	nRESET								Outputs:	WASH
        CLK										          RINSE
        START										        DRY
        MEDIUMIn								      	MEDIUMout
        LARGEIn									        LARGEout
        DIRTY
        WET ;


Modulewash(Motor operation in washing stage)
Inputs:	Clk									Output:		T2d
Start	


Modulerinse(Module operation in rinsing stage)
Inputs:	Clk									Output:		T2d
Start	

Moduledry
Inputs:	Clk									Output:		T2d
Start	


#Functionality.
As the start button is pressed, assuming that the clothes have already been loaded, the washing machine commences the washing stage for 10 minutes. Then the machine rinses the clothes for another 10 minutes after the washing stage. This accounts for 1 cycle. If it detects that it is already clean thereafter, it will ensue the drying stage. If it is still dirty after the first cycle, then the machine would have to perform a second cycle. The motor and timer works during the washing and rinsing stage. There is a 300 seconds delay before the drying process completes after it detects that the clothes aren’t wet anymore.

The purpose of the motor is to move the clothes around in a well-coordinated spinning fashion inside the washing machine. To show the motor operation, we set it up in a way where it spins counter-clockwise fifty times for a hundred seconds then spins clockwise fifty times for another hundred up until the duration lasts for 600 seconds or 10 minutes much like how a washing phase of a washing machine would. In the rinsing process, it will only spin in one direction all the way until ten minutes has passed. In 100 seconds, the motor would have already spun 50 times. This would total to 300 spins in 10 minutes. 


Spinning process of a motor in one instance of a 360 degree loop:
Bit presentation of the counter-clockwise spin.
There are four bits namely, north, south, east and west. West would be the most significant bit. North would be the least.
*At initial position,	
Binary value=0 0 0 1
Decimal value=1

*Next,
Binary value=1 0 0 0
Decimal value=8

*Next,
Binary value=0 1 0 0
Decimal value=4

*Next,
Binary value=0 0 1 0
Decimal value=2

*Then back to starting position.
Binary value=0 0 0 1
Decimal value=1

