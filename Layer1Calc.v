module Layer1Calc(clk, reset, pixels[159:0], weight, column);

input clk, reset;
input  [15:0]  weight;
input  [159:0] pixels;
output [159:0] column;

reg [15:0] weightReg;

Mac M1(clk, reset, pixels[15:0], weightReg, column[15:0]);
Mac M2(clk, reset, pixels[31:16], weightReg, column[31:16]);
Mac M3(clk, reset, pixels[47:32], weightReg, column[47:32]);
Mac M4(clk, reset, pixels[63:48], weightReg, column[63:48]);
Mac M5(clk, reset, pixels[79:64], weightReg, column[79:64]);
Mac M6(clk, reset, pixels[95:80], weightReg, column[95:80]);
Mac M7(clk, reset, pixels[111:96], weightReg, column[111:96]);
Mac M8(clk, reset, pixels[127:112], weightReg, column[127:112]);
Mac M9(clk, reset, pixels[143:128], weightReg, column[143:128]);
Mac M10(clk, reset, pixels[159:144], weightReg, column[159:144]);

always @ (posedge clk)
begin
   weightReg <= weight;
end
endmodule
