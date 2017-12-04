module Top(
clk,
reset,
weight1

);

/*
*************************************************************************
Inputs
*************************************************************************
*/
input clk;
input reset;
input [15:0] weight1;


/*
*************************************************************************
Wires and Connections
*************************************************************************
*/

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
wire [15:0] wdata;
wire [15:0] rdata;

//sigmoid connections
wire [15:0] sig_in;
wire [15:0] sig_out;


/*
*************************************************************************
Instantiation of Modules
*************************************************************************
*/

Layer1Calc STAGE_1(
.clk(clk),
.reset(reset),
.pixels(pixels),
.weight(weight1),
.column(column)
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
.wdata(wdata),
.rdata(rdata)
);

sigmoid SIGMOID(
.clk(clk),
.sig_in(sig_in),
.sig_out(sig_out)
);



endmodule
