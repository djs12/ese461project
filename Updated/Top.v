module Top(
clk,
reset,
inputSramWe,
pixels,
weight1,
w2SramWeOffChip,
weight2,
weight2AddrOffChip,
weight2_loadNextRow,
rdata
);

/*
module Top(
clk,
reset,
pixels,
weight1,
weight2,
weight2_loadNextRow
);
*/

/*
*************************************************************************
Inputs
*************************************************************************
*/
input clk;
input reset;
input inputSramWe;
input w2SramWeOffChip;
input [89:0] pixels;
input [8:0] weight1;
input [15:0] weight2;
input [3:0] weight2AddrOffChip;
//input [15:0] weight2;
output signed [15:0] rdata;
output weight2_loadNextRow;


/*
*************************************************************************
Wires and Connections
*************************************************************************
*/
//Layer 2 multiplication result
reg signed [31:0]  m2product;
wire signed [15:0]  m2DataIn;

//Layer 1 connections
wire [159:0] m1Inputs;
wire [159:0] column;

//Weight 2 row vector SRAM connections
wire [3:0] addr;
reg [3:0] w2Addr;
wire signed [15:0] q_w2;

//gSRAM connections
wire we;
wire [3:0] row;
wire [3:0] col;
//wire [15:0] wdata;
reg signed [15:0] m2result;
wire gSramMuxSel;
//wire [15:0] rdata;

//sigmoid connections
wire [15:0] sig_in;
wire [15:0] sig_out;

//controller 
wire l1reset;
wire routeDataRegWrEn;
wire routeDataRegWrSel;
wire routeDataOutMuxSel;
wire [3:0] routeDataRegAddr;

/*
*************************************************************************
Instantiation of Modules
*************************************************************************
*/

Layer1Calc STAGE_1(
.clk(clk),
.reset(l1reset), //verify this is the correct reset
.pixels(m1Inputs),
.weight(weight1),
.column(column)
);

inputSRAM INPUTSRAM(
.clk(clk),
.we(inputSramWe),
.data(pixels),
.q(m1Inputs)
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
.DataToM2(m2DataIn)
);

w2SRAM WEIGHT_2(
.clk(clk),
.we(w2SramWeOffChip),
.data(weight2),
.addr(w2Addr),
.q(q_w2)
);

gSRAM ANSWER(
.clk(clk),
.we(we),
.row(row),
.col(col),
.m2result(m2result),
.lutdata(sig_out),
.inmuxsel(gSramMuxSel),
.rdata(rdata)
);

Sigmoid SIGMOID(
.clk(clk),
.sig_in(sig_in),
.sig_out(sig_out)
);

always @ (q_w2, rdata, m2DataIn, addr, w2SramWeOffChip, weight2AddrOffChip) begin
    m2product = q_w2 * m2DataIn;
    m2result = rdata + m2product[23:8];
   
    case(w2SramWeOffChip)
    0: begin w2Addr = addr; end
    1: begin w2Addr =  weight2AddrOffChip; end
    endcase
    
end
endmodule


