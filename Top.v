
//module Layer1Calc(clk, reset, pixels[159:0], weight, column);
//inputSRAM S1(.data(data), /*.addr(addr), .we(we), .clk(clk), */.q(l1Inputs));
//Layer1Calc L1(clk, layer1Reset, l1Inputs, l1Weight, layer1Out);
//Sigmoid()

module Top(
clk,
reset,
weight1,
weight2_loadNextRow
);

/*
*************************************************************************
Inputs
*************************************************************************
*/
input clk;
input reset;
input [15:0] weight1;
output weight2_loadNextRow;


/*
*************************************************************************
Wires and Connections
*************************************************************************
*/

//Layer 2 multiplication result
wire [15:0] m2product;
wire [15:0] m2DataIn;

//Layer 1 connections
wire [159:0] pixels;
wire [159:0] column;


//Input Vector SRAM connections
wire [159:0] q_w1;

//Weight 2 row vector SRAM connections
wire [3:0] addr;
wire [15:0] q_w2;

//gSRAM connections
wire we;
wire [3:0] row;
wire [3:0] col;
//wire [15:0] wdata;
wire [15:0] m2result;
wire gSramMuxSel;
wire [15:0] rdata;

//sigmoid connections
wire [15:0] sig_in;
wire [15:0] sig_out;

//controller 
wire l1reset;
wire routeDataRegWrEn;
wire routeDataRegWrSel;
wire routeDataOutMuxSel;
wire [4:0] routeDataRegAddr;


/*
*************************************************************************
Instantiation of Modules
*************************************************************************
*/

Layer1Calc STAGE_1(
.clk(clk),
.reset(l1reset), //verify this is the correct reset
.pixels(pixels),
.weight(weight1),
.column(column)
);


controller CNTRL(
.clk(clk),
.reset(reset),
.MAC_reset(l1reset), //0: add to partial sum. 1: add to 0 (clearing)
.reg_holder_in(routeDataRegWrEn),
.reg_holder_mux(routeDataRegWrSel),
.reg_holder_addr(routeDataRegAddr),
.LUT_mux(routeDataOutMuxSel),
.weight2_addr(addr),
.weight2_loadNextRow(weight2_loadNextRow),
.GSRAM_addr_row(row),
.GSRAM_addr_col(col),
.GSRAM_in(we),
.GSRAM_mux(gSramMuxSel)
);


RouteData ROUTEDATA(
.clk(clk),
.M1Result(column),
.SigFeedback(sig_out),
.SramData(rdata),
.RegLoadEn(routeDataRegWrEn),
.RegLoadSel(routeDataRegWrSel),
.Addr(routeDataRegAddr),
.DataOutSel(routeDataOutMuxSel),
.DataOut(sig_in),
.DataToM2Mult(m2DataIn)
);


inputSRAM INPUTS(
.clk(clk),
.q(q_w1)
);


w2SRAM WEIGHT_2(
.clk(clk),
.addr(addr),
.q(q_w2)
);


gSRAM ANSWER(
.clk(clk),
.we(we),
.row(row),
.col(col),
//.wdata(wdata),
.m2result(m2result),
.lutdata(sig_out),
.inmuxsel(gSramMuxSel),
.rdata(rdata)
);


sigmoid SIGMOID(
.clk(clk),
.sig_in(sig_in),
.sig_out(sig_out)
);


always @ (q_w2, rdata, m2DataIn) begin
    m2product = q_w2 * m2DataIn;
    m2result = rdata + m2product[23:8];
end

endmodule


