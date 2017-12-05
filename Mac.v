module Mac(clk, reset, pixel, weight, accum, result);

input clk, reset;
input  [15:0] pixel;
input  [15:0] weight;
input  [15:0] accum;
output reg [15:0] result;

reg [31:0] product;
reg [15:0] sum;

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

