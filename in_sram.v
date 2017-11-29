module in_sram(
clk,
row1,
row2,
row3,
row4,
row5,
row6,
row7,
row8,
row9,
row10,
out1,
out2,
out3,
out4,
out5,
out6,
out7,
out8,
out9,
out10,
n
);

input clk;
input n;
input [783:0] row1, row2, row3, row4, row5, row6, row7, row8, row9, row10;
output [783:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out10;

//16 bit elements(one pixel) in a 10x784 array
reg [15:0] in [9:0][783:0];

always @ (posedge clk)
begin
  
  //each row of 784, 16 bit pixels is assigned
  in[4'h0] <= row1;
  in[4'h1] <= row2;
  in[4'h2] <= row3;
  in[4'h3] <= row4;
  in[4'h4] <= row5;
  in[4'h5] <= row6;
  in[4'h6] <= row7;
  in[4'h7] <= row8;
  in[4'h8] <= row9;
  in[4'h9] <= row10;

  //output only the nth pixel in each vector
  out1 <= in[4'h0][n];
  out2 <= in[4'h1][n];
  out3 <= in[4'h2][n];
  out4 <= in[4'h3][n];
  out5 <= in[4'h4][n];
  out6 <= in[4'h5][n];
  out7 <= in[4'h6][n];
  out8 <= in[4'h7][n];
  out9 <= in[4'h8][n];
  out10 <= in[4'h9][n];

end

endmodule
