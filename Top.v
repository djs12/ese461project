module Top(
clk,
q
);

input clk;
output [159:0] q;


inputSRAM S1(
.clk(clk),
.q(q)
);

endmodule
