module Top(
clk,
reset,
w1,
weight2_loadNextRow,
mem0,
mem1,
mem2,
mem3,
mem4,
mem5,
mem6,
mem7,
mem8,
mem9
);

/*
*************************************************************************
Inputs
*************************************************************************
*/

input clk;
input reset;
input [15:0] w1;
output weight2_loadNextRow;

output [159:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9;

/*
*************************************************************************
Wires and Connections
*************************************************************************
*/

//inputSRAM.v
//clk <- clk
wire [159:0] q_input;

//Layer1Calc.v
//clk <- clk
//globalReset <- reset
//MAC_reset <- MAC_reset
//pixels <- q_input
//weight <- w1
wire [159:0] column;

//controller.v
//clk <- clk
//reset <- reset
wire MAC_reset;		
wire reg_holder_in;	 		// write enable of reg holder
wire reg_holder_mux;	 	//0: load from MACs, 160 bits. 1: load from LUT, 16 bits, address
wire [3:0] reg_holder_addr;
wire LUT_mux; 		 		//0: load from reg_holder, 1: load from GSRAM
wire [3:0] weight2_addr;   	//0~9
//weight2_loadNextRow <- weight2_loadNextRow    
wire [3:0] GSRAM_addr_row; 	//0~9
wire [3:0] GSRAM_addr_col; 	//0~9
wire GSRAM_in; 
wire GSRAM_mux; 			// 0->going to the adder, 1->going to the LUT

//w2SRAM
//clk <- clk
//addr <- weight2_addr
wire [15:0] q_w2;

//RouteData
//clk <- clk
//M1Result <- column (from Layer1)
wire [15:0] sig_out; //SigFeedback <- sig_out
wire [15:0] rdata; //SramData <- rdata from the gSRAM
//RegLoadEn <- reg_holder_in
//RegLoadSel <- reg_holder_mux
//Addr <- reg_holder addr
//DataOutSel <- LUT_mux
wire [15:0] DataOut;
wire [15:0] DataToM2;

//Sigmoid.v
//clk <- clk
//sig_in <- DataOut
//sig_out <- sig_out


//gSRAM.v
//clk <- clk
//we <- GSRAM_in
//row <- GSRAM_addr_row
//col <- GSRAM_addr_col
wire [15:0] m2result; // The result performed on DataToM2: this is write data
//lutdata <- sig_out activation data at the very end
//inmuxsel <- GSRAM_mux
//rdata (created above in RouteData)


/*
*************************************************************************
Instantiation
*************************************************************************
*/

inputSRAM INPUTS(
.clk(clk),
.q(q_input)
);

Layer1Calc STAGE1(
.clk(clk),
.globalReset(reset),
.MAC_reset(MAC_reset),
.pixels(q_input),
.weight(w1),
.column(column)
);

controller CONTROL(
.clk(clk),
.reset(reset),
.MAC_reset(MAC_reset),
.reg_holder_in(reg_holder_in),
.reg_holder_mux(reg_holder_mux),
.reg_holder_addr(reg_holder_addr),
.LUT_mux(LUT_mux),
.weight2_addr(weight2_addr),
.weight2_loadNextRow(weight2_loadNextRow),
.GSRAM_addr_row(GSRAM_addr_row),
.GSRAM_addr_col(GSRAM_addr_col),
.GSRAM_in(GSRAM_in),
.GSRAM_mux(GSRAM_mux)
);

w2SRAM WEIGHT_2(
.clk(clk),
.addr(weight2_addr),
.q(q_w2)
);

RouteData ROUTE(
.clk(clk),
.M1Result(column),
.SigFeedback(sig_out),
.SramData(rdata),
.RegLoadEn(reg_holder_in),
.RegLoadSel(reg_holder_mux),
.Addr(reg_holder_addr),
.DataOutSel(LUT_mux),
.DataOut(DataOut),
.DataToM2(DataToM2)
);

Sigmoid SIG(
.clk(clk),
.sig_in(DataOut),
.sig_out(sig_out)
);

gSRAM GSRAM(
.clk(clk),
.we(GSRAM_in),
.row(GSRAM_addr_row),
.col(GSRAM_addr_col),
.m2result(m2result),
.lutdata(sig_out),
.inmuxsel(GSRAM_mux),
.rdata(rdata),
.mem0(mem0),
.mem1(mem1),
.mem2(mem2),
.mem3(mem3),
.mem4(mem4),
.mem5(mem5),
.mem6(mem6),
.mem7(mem7),
.mem8(mem8),
.mem9(mem9)
);


/*
*************************************************************************
STAGE 2
*************************************************************************
*/

//Multiply and add
wire [31:0] product;
assign product = q_w2 * DataToM2;
assign m2result = product[23:8] + rdata;




endmodule
