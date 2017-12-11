module w2SRAM(
clk,
addr,
q
);

input clk;
input [3:0] addr;
output q;

reg [15:0] q;

//Declare RAM variable
reg [15:0] mem_w2 [9:0];
//mem_w2 is a single row vector of pixels

always @ (posedge clk)
begin
  q <= mem_w2[addr];
end

endmodule
