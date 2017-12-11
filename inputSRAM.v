module inputSRAM(
clk,
q
);

input clk;
output q;

reg [159:0] q;

//Declare RAM variable
reg [15:0] mem_i [9:0];
//mem_i is a column vector of pixels across the 
//input vectors

//Ram stores mem_i[0] with first line entry and mem[9] with last
 
always @ (posedge clk)
begin
  q <= {mem_i[9],mem_i[8],mem_i[7],mem_i[6],mem_i[5],mem_i[4],mem_i[3],mem_i[2],mem_i[1],mem_i[0]};
end


endmodule


