#######################################################
#                                                     
#  Encounter Command Logging File                     
#  Created on Tue Dec 12 18:26:49 2017                
#                                                     
#######################################################

#@(#)CDS: Encounter v14.23-s044_1 (64bit) 03/20/2015 11:30 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute v14.23-s028 NR150319-1745/14_23-UB (database version 2.30, 255.6.1) {superthreading v1.25}
#@(#)CDS: CeltIC v14.23-s013_1 (64bit) 03/09/2015 04:15:07 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 14.23-s010 (64bit) 03/20/2015 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 14.23-s014_1 (64bit) Mar  9 2015 03:15:25 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v14.23-s032
#@(#)CDS: IQRC/TQRC 14.1.6-s260 (64bit) Mon Mar  2 11:26:49 PST 2015 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
win
set init_gnd_net gnd!
set init_lef_file /project/linuxlab/cadence/vendors/VTVT/vtvt_tsmc180/vtvt_tsmc180_lef/vtvt_tsmc180.lef
set init_verilog ../RTL_Synthesis_Report/Top.syn.v
set init_mmmc_file Default.view
set init_pwr_net vdd!
init_design
windowSelect 1.111 0.252 -1.142 0.211
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomOut
zoomIn
zoomOut
zoomIn
windowSelect 754.130 -437.156 -24.973 -708.621
windowToggleSelect 447.375 198.072 -318.155 -135.830
zoomOut
deselectAll
zoomSelected
zoomIn
zoomOut
fit
getIoFlowFlag
setIoFlowFlag 0
floorPlan -site CoreSite -r 0.998481762637 0.699976 10.0 10.0 10.0 10.0
uiSetTool select
getIoFlowFlag
fit
clearGlobalNets
globalNetConnect vdd! -type pgpin -pin vdd! -inst * -module {}
globalNetConnect gnd! -type pgpin -pin gnd! -inst * -module {}
clearGlobalNets
globalNetConnect vdd! -type pgpin -pin vdd! -inst * -module {}
globalNetConnect gnd! -type pgpin -pin gnd! -inst * -module {}
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.0
set sprCreateIeRingSpacing 1.0
set sprCreateIeRingOffset 1.0
set sprCreateIeRingThreshold 1.0
set sprCreateIeRingJogDistance 1.0
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -stacked_via_top_layer metal6 -type core_rings -jog_distance 0.81 -threshold 0.81 -nets {gnd! vdd!} -follow core -stacked_via_bottom_layer metal1 -layer {bottom metal1 top metal1 right metal2 left metal2} -width 0.45 -spacing 0.45 -offset 0.81
getPinAssignMode -pinEditInBatch -quiet
setPinAssignMode -pinEditInBatch true
editPin -fixOverlap 1 -layer 1 -pin {}
setPinAssignMode -pinEditInBatch false
sroute -connect { blockPin padPin padRing corePin floatingStripe } -layerChangeRange { metal1 metal6 } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { metal1 metal6 } -nets { gnd! vdd! } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { metal1 metal6 }
zoomIn
zoomOut
zoomSelected
windowSelect 1236.920 1037.979 1094.655 987.994
zoomIn
deselectAll
zoomOut
setPlaceMode -fp false
placeDesign
createClockTreeSpec -bufferList {buf_1 buf_2 buf_4 cd_12 cd_16 cd_8 inv_1 inv_2 inv_4} -file Clock.ctstch
specifyClockTree -clkfile Clock.ctstch
setCTSMode -routeGuide true -routeClkNet true
clockDesign -outDir Clock_reports
setOptMode -simplifyNetlist false
clearClockDomains
optDesign -postCTS -outDir Clock_reports/PostCTS
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail
getFillerMode -quiet
addFiller -cell filler -prefix FILLER
setVerifyGeometryMode -area { 0 0 0 0 } -minWidth true -minSpacing true -minArea true -sameNet true -short true -overlap true -offRGrid false -offMGrid true -mergedMGridCheck true -minHole true -implantCheck true -minimumCut true -minStep true -viaEnclosure true -antenna false -insuffMetalOverlap true -pinInBlkg false -diffCellViol true -sameCellViol false -padFillerCellsOverlap true -routingBlkgPinOverlap true -routingCellBlkgOverlap true -regRoutingOnly false -stackedViasOnRegNet false -wireExt true -useNonDefaultSpacing false -maxWidth true -maxNonPrefLength -1 -error 1000
verifyGeometry
setVerifyGeometryMode -area { 0 0 0 0 }
verify_drc -report Top.drc.rpt -limit 1000
verifyConnectivity -type all -error 1000 -warning 50
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix Top_preCTS -outDir timingReports
saveFPlan Project.fp
savePlace Project.place.gz
saveNetlist Project.v
global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.8
defOut -floorplan -netlist -routing Project.def
set dbgLefDefOutVersion 5.8
global dbgLefDefOutVersion
set dbgLefDefOutVersion 5.8
defOut -floorplan -netlist -routing Project.def
set dbgLefDefOutVersion 5.8
selectInst {ANSWER/mem_reg[5][2][5]}
selectWire 666.4950 672.1650 676.4850 672.4350 3 n10062
zoomIn
zoomIn
zoomOut
zoomOut
deselectAll
selectInst {INPUTSRAM/mem_i_reg[1][4]}
deselectAll
selectWire 674.5950 570.9150 700.7850 571.1850 3 FE_OFN68_n9855
deselectAll
selectInst {ANSWER/mem_reg[0][0][13]}
deselectAll
selectInst U12946
deselectAll
selectInst U4664
deselectAll
selectWire 557.9550 972.6750 654.6150 972.9450 3 {rdata[0]}
group
ungroup
deselectAll
zoomIn
selectObject IO_Pin {pixels[66]}
deselectAll
selectObject IO_Pin {pixels[11]}
deselectAll
windowSelect 660.694 -21.632 961.281 -23.909
selectInst U10701
deselectAll
selectWire 10.5300 984.7800 1225.5300 986.7600 1 vdd!
