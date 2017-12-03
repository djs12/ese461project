module Top
(
	input [15:0] data,
	input [9:0] addr,
	input we, 
	input clk,
	output [15:0] q
);

//module Layer1Calc(clk, reset, pixels[159:0], weight, column);
inputSRAM S1(.data(data), /*.addr(addr), .we(we), .clk(clk), */.q(l1Inputs));
Layer1Calc L1(clk, layer1Reset, l1Inputs, l1Weight, layer1Out);
Sigmoid()

	
endmodule

