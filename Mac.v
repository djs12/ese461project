module Mac(clk, reset, pixel, weight, result);

input clk, load;
input  [15:0] pixel;
input  [15:0] weight;
output [15:0] result;

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

always @ (pixel, weight, result) begin
    product = pixel * weight;
    sum = result + product[23:8];
end

