#====================================================================================================
# Description:                 MakeFile
#                              
# Author:                      Dengxue Yan, Washington University in St. Louis
#                              
# Email:                       Dengxue.Yan@wustl.edu
#                             
# Version:                     1.00
#
# Rev History:  
#       <Author>        <Date>        <Hardware>     <Version>        <Description>
#     Dengxue Yan   01-19-2017 20:00      --            1.00             Create
#====================================================================================================
src = Top.v Top_tb.v inputSRAM.v Layer1Calc.v Mac.v controller.v w2SRAM.v gSRAM.v Sigmoid.v RouteData.v

vcs_flag = -full64 -PP +lint=all,noVCDE +v2k -timescale=1ns/10ps

all: simv

simv: $(src)
	vcs $(vcs_flag) $^

run: simv
	./simv +verbose=1

.PHONY: clean
clean : 
	rm -rf csrc
	rm -f simv
	rm -rf simv.daidir
	rm -f *.vcd
	rm -f ucli.key

