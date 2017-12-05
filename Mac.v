module Mac(clk, reset, pixel, weight, accum, result);

input clk, reset;
input  signed [15:0] pixel;
input  signed [15:0] weight;
input  signed [15:0] accum;
output reg signed [15:0] result;

reg signed [31:0]  product;
reg signed [15:0]  sum;

always @ (posedge clk)
begin
   if(reset == 1) begin
      result <= 0;
   end
   else begin
      result <= sum;
   end
end

always @ (pixel, weight, accum) begin
    product = pixel * weight;
    sum = accum + product[23:8];
end

endmodule

