//Currently, async.
//Could be made synchronous if we want
//Names of input and output can be changed

module Sigmoid(clk, sig_in, sig_out);

input clk;
input  [15:0] sig_in;
output reg [15:0] sig_out;

reg  [15:0] lut_out;
reg  [15:0] lut_in;
reg sign_bit;

always @ (sig_in, lut_out, sign_bit)
begin
   case(sig_in[15]) 
   0: begin
       lut_in = sig_in;
      end
   1: begin
       lut_in = ~sig_in + 16'h0001;
      end
   endcase

   case(sign_bit) 
   0: begin
       sig_out = lut_out;
      end
   1: begin
       sig_out = 16'h0100 - lut_out;
      end
   endcase
end

always @ (posedge clk)
begin
   sign_bit <= sig_in[15];

   if(lut_in > 16'b0000011000000000)       begin lut_out <= 16'h0100; end //x > 6
   else if(lut_in >= 16'b0000010100110011) begin lut_out <= 16'b0000000011111111; end //x >= 5.2
   else if(lut_in >= 16'b0000010010110011) begin lut_out <= 16'b0000000011111110; end //x >= 4.7
   else if(lut_in >= 16'b0000010001001101) begin lut_out <= 16'b0000000011111101; end //x >= 4.3 
   else if(lut_in >= 16'b0000010000011010) begin lut_out <= 16'b0000000011111100; end //x >= 4.1
   else if(lut_in >= 16'b0000001111100110) begin lut_out <= 16'b0000000011111011; end //x >= 3.9
   else if(lut_in >= 16'b0000001110110011) begin lut_out <= 16'b0000000011111010; end //x >= 3.7
   else if(lut_in >= 16'b0000001110011010) begin lut_out <= 16'b0000000011111001; end //x >= 3.6
   else if(lut_in >= 16'b0000001101100110) begin lut_out <= 16'b0000000011111000; end //x >= 3.4
   else if(lut_in >= 16'b0000001101001101) begin lut_out <= 16'b0000000011110111; end //x >= 3.3
   else if(lut_in >= 16'b0000001100110011) begin lut_out <= 16'b0000000011110110; end //x >= 3.2
   else if(lut_in >= 16'b0000001100011010) begin lut_out <= 16'b0000000011110101; end //x >= 3.1
   else if(lut_in >= 16'b0000001100000000) begin lut_out <= 16'b0000000011110100; end //x >= 3.0
   else if(lut_in >= 16'b0000001011100110) begin lut_out <= 16'b0000000011110011; end //x >= 2.9
   else if(lut_in >= 16'b0000001011001101) begin lut_out <= 16'b0000000011110001; end //x >= 2.8
   else if(lut_in >= 16'b0000001010110011) begin lut_out <= 16'b0000000011110000; end //x >= 2.7
   else if(lut_in >= 16'b0000001010011010) begin lut_out <= 16'b0000000011101110; end //x >= 2.6
   else if(lut_in >= 16'b0000001010000000) begin lut_out <= 16'b0000000011101101; end //x >= 2.5
   else if(lut_in >= 16'b0000001001100110) begin lut_out <= 16'b0000000011101011; end //x >= 2.4
   else if(lut_in >= 16'b0000001001001101) begin lut_out <= 16'b0000000011101001; end //x >= 2.3
   else if(lut_in >= 16'b0000001000110011) begin lut_out <= 16'b0000000011100110; end //x >= 2.2
   else if(lut_in >= 16'b0000001000011010) begin lut_out <= 16'b0000000011100100; end //x >= 2.1
   else if(lut_in >= 16'b0000001000000000) begin lut_out <= 16'b0000000011100001; end //x >= 2.0
   else if(lut_in >= 16'b0000000111100110) begin lut_out <= 16'b0000000011011111; end //x >= 1.9
   else if(lut_in >= 16'b0000000111001101) begin lut_out <= 16'b0000000011011100; end //x >= 1.8
   else if(lut_in >= 16'b0000000110110011) begin lut_out <= 16'b0000000011011000; end //x >= 1.7
   else if(lut_in >= 16'b0000000110011010) begin lut_out <= 16'b0000000011010101; end //x >= 1.6
   else if(lut_in >= 16'b0000000110000000) begin lut_out <= 16'b0000000011010001; end //x >= 1.5
   else if(lut_in >= 16'b0000000101100110) begin lut_out <= 16'b0000000011001101; end //x >= 1.4
   else if(lut_in >= 16'b0000000101001101) begin lut_out <= 16'b0000000011001001; end //x >= 1.3
   else if(lut_in >= 16'b0000000100110011) begin lut_out <= 16'b0000000011000101; end //x >= 1.2
   else if(lut_in >= 16'b0000000100011010) begin lut_out <= 16'b0000000011000000; end //x >= 1.1
   else if(lut_in >= 16'b0000000100000000) begin lut_out <= 16'b0000000010111011; end //x >= 1.0
   else if(lut_in >= 16'b0000000011100110) begin lut_out <= 16'b0000000010110110; end //x >= 0.9
   else if(lut_in >= 16'b0000000011001101) begin lut_out <= 16'b0000000010110001; end //x >= 0.8
   else if(lut_in >= 16'b0000000010110011) begin lut_out <= 16'b0000000010101011; end //x >= 0.7
   else if(lut_in >= 16'b0000000010011010) begin lut_out <= 16'b0000000010100101; end //x >= 0.6
   else if(lut_in >= 16'b0000000010000000) begin lut_out <= 16'b0000000010011111; end //x >= 0.5
   else if(lut_in >= 16'b0000000001100110) begin lut_out <= 16'b0000000010011001; end //x >= 0.4
   else if(lut_in >= 16'b0000000001001101) begin lut_out <= 16'b0000000010010011; end //x >= 0.3
   else if(lut_in >= 16'b0000000000110011) begin lut_out <= 16'b0000000010001101; end //x >= 0.2
   else if(lut_in >= 16'b0000000000011010) begin lut_out <= 16'b0000000010000110; end //x >= 0.1
   else  begin lut_out <= 16'b0000000010000000; end //x >= 0.0 if(lut_in >= 16'b0000000000000000)
end

endmodule

/*
   if(x < -6)                   begin y = 16'h0000; end
   else if (x > 6)              begin y = 16'h0100; end
   else begin
      if(x < -5.1)              begin y = 16'h0001; end
      if(x >= -5.1 && x < -4.6) begin y = 16'h0002; end
      if(x >= -4.6 && x < -4.2) begin y = 16'h0003; end
      if(x >= -4.2 && x < -4.0) begin y = 16'h0004; end
      if(x >= -4.0 && x < -3.8) begin y = 16'h0005; end
      if(x >= -3.8 && x < -3.6) begin y = 16'h0006; end
      if(x >= -3.6 && x < -3.5) begin y = 16'h0007; end
      if(x >= -3.5 && x < -3.3) begin y = 16'h0008; end
      if(x >= -3.3 && x < -3.2) begin y = 16'h0009; end
      if(x >= -3.2 && x < -3.1) begin y = 16'h000A; end
      if(x >= -3.1 && x < -3.0) begin y = 16'h000B; end
      if(x >= -3.0 && x < -2.9) begin y = 16'h000C; end
      if(x >= -2.9 && x < -2.8) begin y = 16'h000D; end
      if(x >= -2.8 && x < -2.7) begin y = 16'h000F; end
      if(x >= -2.7 && x < -2.6) begin y = 16'h0010; end
      if(x >= -2.6 && x < -2.5) begin y = 16'h0012; end
      if(x >= -2.5 && x < -2.4) begin y = 16'h0013; end
      if(x >= -2.4 && x < -2.3) begin y = 16'h0015; end
      if(x >= -2.3 && x < -2.2) begin y = 16'h0017; end
      if(x >= -2.2 && x < -2.1) begin y = 16'h001A; end
      if(x >= -2.1 && x < -2.0) begin y = 16'h001C; end
      if(x >= -2.0 && x < -1.9) begin y = 16'h001F; end
      if(x >= -1.9 && x < -1.8) begin y = 16'h0021; end
      if(x >= -1.8 && x < -1.7) begin y = 16'h0024; end
      if(x >= -1.7 && x < -1.6) begin y = 16'h0028; end
      if(x >= -1.6 && x < -1.5) begin y = 16'h002B; end
      if(x >= -1.5 && x < -1.4) begin y = 16'h002F; end
      if(x >= -1.4 && x < -1.3) begin y = 16'h0033; end
      if(x >= -1.3 && x < -1.2) begin y = 16'h0037; end
      if(x >= -1.2 && x < -1.1) begin y = 16'h003B; end
      if(x >= -1.1 && x < -1.0) begin y = 16'h0040; end
      if(x >= -1.0 && x < -0.9) begin y = 16'h0045; end
      if(x >= -0.9 && x < -0.8) begin y = 16'h004A; end
      if(x >= -0.8 && x < -0.7) begin y = 16'h004F; end
      if(x >= -0.7 && x < -0.6) begin y = 16'h0055; end
      if(x >= -0.6 && x < -0.5) begin y = 16'h005B; end
      if(x >= -0.5 && x < -0.4) begin y = 16'h0061; end
      if(x >= -0.4 && x < -0.3) begin y = 16'h0067; end
      if(x >= -0.3 && x < -0.2) begin y = 16'h006D; end
      if(x >= -0.2 && x < -0.1) begin y = 16'h0073; end
      if(x >= -0.1 && x < 0.0)  begin y = 16'h007A; end
      if(x >= 0.0 && x < 0.1)   begin y = 16'h0080; end
      if(x >= 0.1 && x < 0.2)   begin y = 16'h0086; end
      if(x >= 0.2 && x < 0.3)   begin y = 16'h008D; end
      if(x >= 0.3 && x < 0.4)   begin y = 16'h0093; end
      if(x >= 0.4 && x < 0.5)   begin y = 16'h0099; end
      if(x >= 0.5 && x < 0.6)   begin y = 16'h009F; end
      if(x >= 0.6 && x < 0.7)   begin y = 16'h00A5; end
      if(x >= 0.7 && x < 0.8)   begin y = 16'h00AB; end
      if(x >= 0.8 && x < 0.9)   begin y = 16'h00B1; end
      if(x >= 0.9 && x < 1.0)   begin y = 16'h00B6; end
      if(x >= 1.0 && x < 1.1)   begin y = 16'h00BB; end
      if(x >= 1.1 && x < 1.2)   begin y = 16'h00C0; end
      if(x >= 1.2 && x < 1.3)   begin y = 16'h00C5; end
      if(x >= 1.3 && x < 1.4)   begin y = 16'h00C9; end
      if(x >= 1.4 && x < 1.5)   begin y = 16'h00CD; end
      if(x >= 1.5 && x < 1.6)   begin y = 16'h00D1; end
      if(x >= 1.6 && x < 1.7)   begin y = 16'h00D5; end
      if(x >= 1.7 && x < 1.8)   begin y = 16'h00D8; end
      if(x >= 1.8 && x < 1.9)   begin y = 16'h00DC; end
      if(x >= 1.9 && x < 2.0)   begin y = 16'h00DF; end
      if(x >= 2.0 && x < 2.1)   begin y = 16'h00E1; end
      if(x >= 2.1 && x < 2.2)   begin y = 16'h00E4; end
      if(x >= 2.2 && x < 2.3)   begin y = 16'h00E6; end
      if(x >= 2.3 && x < 2.4)   begin y = 16'h00E9; end
      if(x >= 2.4 && x < 2.5)   begin y = 16'h00EB; end
      if(x >= 2.5 && x < 2.6)   begin y = 16'h00ED; end
      if(x >= 2.6 && x < 2.7)   begin y = 16'h00EE; end
      if(x >= 2.7 && x < 2.8)   begin y = 16'h00F0; end
      if(x >= 2.8 && x < 2.9)   begin y = 16'h00F1; end
      if(x >= 2.9 && x < 3.0)   begin y = 16'h00F3; end
      if(x >= 3.0 && x < 3.1)   begin y = 16'h00F4; end
      if(x >= 3.1 && x < 3.2)   begin y = 16'h00F5; end
      if(x >= 3.2 && x < 3.3)   begin y = 16'h00F6; end
      if(x >= 3.3 && x < 3.4)   begin y = 16'h00F7; end
      if(x >= 3.4 && x < 3.6)   begin y = 16'h00F8; end
      if(x >= 3.6 && x < 3.7)   begin y = 16'h00F9; end
      if(x >= 3.7 && x < 3.9)   begin y = 16'h00FA; end
      if(x >= 3.9 && x < 4.1)   begin y = 16'h00FB; end
      if(x >= 4.1 && x < 4.3)   begin y = 16'h00FC; end
      if(x >= 4.3 && x < 4.7)   begin y = 16'h00FD; end
      if(x >= 4.7 && x < 5.2)   begin y = 16'h00FE; end
      if(x >= 5.2)              begin y = 16'h00FF; end
   end
end
*/









