# A computational model employing the concept of Finite state machine that can be implemented using hardware or software and written using Verilog(C)


## MAIN
Inputs:	nRESET								Outputs:	WASH
        CLK										          RINSE
        START										        DRY
        MEDIUMIn								      	MEDIUMout
        LARGEIn									        LARGEout
        DIRTY
        WET ;


## Modulewash(Motor operation in washing stage)
Inputs:	Clk									Output:		T2d
Start	


## Modulerinse(Module operation in rinsing stage)
Inputs:	Clk									Output:		T2d
Start	

## Moduledry
Inputs:	Clk									Output:		T2d
Start	


## Functionality.
As the start button is pressed, assuming that the clothes have already been loaded, the washing machine commences the washing stage for 10 minutes. Then the machine rinses the clothes for another 10 minutes after the washing stage. This accounts for 1 cycle. If it detects that it is already clean thereafter, it will ensue the drying stage. If it is still dirty after the first cycle, then the machine would have to perform a second cycle. The motor and timer works during the washing and rinsing stage. There is a 300 seconds delay before the drying process completes after it detects that the clothes aren’t wet anymore.

The purpose of the motor is to move the clothes around in a well-coordinated spinning fashion inside the washing machine. To show the motor operation, we set it up in a way where it spins counter-clockwise fifty times for a hundred seconds then spins clockwise fifty times for another hundred up until the duration lasts for 600 seconds or 10 minutes much like how a washing phase of a washing machine would. In the rinsing process, it will only spin in one direction all the way until ten minutes has passed. In 100 seconds, the motor would have already spun 50 times. This would total to 300 spins in 10 minutes. 


Spinning process of a motor in one instance of a 360 degree loop:
# Bit presentation of the counter-clockwise spin.
There are four bits namely, north, south, east and west. West would be the most significant bit. North would be the least.

![alt text](https://i.ibb.co/ftHX9hk/1.png "Bit presentation of the counter-clockwise spin 1")

![alt text](https://i.ibb.co/vjJh4Fd/2.png "Bit presentation of the counter-clockwise spin 2")

# Bit presentation of the clockwise spin.

![alt text](https://i.ibb.co/ws5stK7/3.png "Bit presentation of the clockwise spin 1")

![alt text](https://i.ibb.co/JvtZtCw/4.png "Bit presentation of the clockwise spin 2")

The timer commences when the washing mode starts and counts all the way up to the end of the rinsing stage. Washing mode is programmed to be set running for 10 minutes or 600 seconds and another 10 minutes for the rinsing mode as well. Consequently, one cycle of washing and rinsing would last for 20 minutes or 1200 seconds.

# Block Diagram.
![alt text](https://i.ibb.co/fHgTbNN/block-diagram.png "Block diagram")
