module Layer1Calc(clk, globalReset, MAC_reset, pixels, weight, column);

input clk, globalReset, MAC_reset;
input [15:0]  weight;
input [159:0] pixels;
output [159:0] column;

reg [159:0] add_in;

wire reset;
or myOR(reset,globalReset,MAC_reset);

Mac M1(clk, pixels[15:0], weight, add_in[15:0], column[15:0]);
Mac M2(clk, pixels[31:16], weight, add_in[31:16], column[31:16]);
Mac M3(clk, pixels[47:32], weight, add_in[47:32], column[47:32]);
Mac M4(clk, pixels[63:48], weight, add_in[63:48], column[63:48]);
Mac M5(clk, pixels[79:64], weight, add_in[79:64], column[79:64]);
Mac M6(clk, pixels[95:80], weight, add_in[95:80], column[95:80]);
Mac M7(clk, pixels[111:96], weight, add_in[111:96], column[111:96]);
Mac M8(clk, pixels[127:112], weight, add_in[127:112], column[127:112]);
Mac M9(clk, pixels[143:128], weight, add_in[143:128], column[143:128]);
Mac M10(clk, pixels[159:144], weight, add_in[159:144], column[159:144]);

always @ (reset, column)
begin
   case(reset)
   0: begin
      add_in[15:0] = column[15:0];
      add_in[31:16] = column[31:16];
      add_in[47:32] = column[47:32];
      add_in[63:48] = column[63:48];
      add_in[79:64] = column[79:64];
      add_in[95:80] = column[95:80];
      add_in[111:96] = column[111:96];
      add_in[127:112] = column[127:112];
      add_in[143:128] = column[143:128];
      add_in[159:144] = column[159:144];
      end
   1: begin
      add_in[15:0] = 0;
      add_in[31:16] = 0;
      add_in[47:32] = 0;
      add_in[63:48] = 0;
      add_in[79:64] = 0;
      add_in[95:80] = 0;
      add_in[111:96] = 0;
      add_in[127:112] = 0;
      add_in[143:128] = 0;
      add_in[159:144] = 0;
      end
   endcase
end

endmodule   


