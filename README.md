# automatic-washing-machine-control-system using 


MAIN
Inputs:	nRESET								Outputs:	WASH
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
