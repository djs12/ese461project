module Mac(clk, pixel, weight, accum, result);

input clk;
input signed [15:0] pixel;
input signed [15:0] weight;
input signed [15:0] accum;
output reg signed [15:0] result;

reg signed [31:0]  product;
reg signed [15:0]  sum;

always @ (posedge clk)
begin
   result <= sum;
end

always @ (pixel, weight, accum) begin
    product = pixel * weight;
    sum = accum + product[23:8];
end

endmodule

