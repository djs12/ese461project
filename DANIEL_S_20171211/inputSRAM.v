module inputSRAM(
clk,
we,
data,
q
);

input clk, we;
input [159:0] data;
output q;

reg [159:0] q;

//Declare RAM variable
reg [15:0] mem_i [9:0];
//mem_i is a column vector of pixels across the 
//input vectors

//Ram stores mem_i[0] with first line entry and mem[9] with last
 
always @ (posedge clk)
begin
  if(we) begin 
    mem_i[0] <= data[15:0];
    mem_i[1] <= data[31:15];
    mem_i[2] <= data[47:32];
    mem_i[3] <= data[63:47];
    mem_i[4] <= data[79:64];
    mem_i[5] <= data[95:80];
    mem_i[6] <= data[111:96];
    mem_i[7] <= data[127:112];
    mem_i[8] <= data[143:128];
    mem_i[9] <= data[159:144];
  end 

  q <= {mem_i[9],mem_i[8],mem_i[7],mem_i[6],mem_i[5],mem_i[4],mem_i[3],mem_i[2],mem_i[1],mem_i[0]};
end


endmodule

