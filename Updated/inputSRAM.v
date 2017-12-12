module inputSRAM(
clk,
we,
data,
q
);

input clk, we;
input [89:0] data;
output q;

reg [159:0] q;

//Declare RAM variable
reg [8:0] mem_i [9:0];
//mem_i is a column vector of pixels across the 
//input vectors

//Ram stores mem_i[0] with first line entry and mem[9] with last
 
always @ (posedge clk)
begin
  if(we) begin 
    mem_i[0] <= data[8:0];
    mem_i[1] <= data[17:9];
    mem_i[2] <= data[26:18];
    mem_i[3] <= data[35:27];
    mem_i[4] <= data[44:36];
    mem_i[5] <= data[53:45];
    mem_i[6] <= data[62:54];
    mem_i[7] <= data[71:63];
    mem_i[8] <= data[80:72];
    mem_i[9] <= data[89:81];
  end 

  q <= {7'b0000000, mem_i[9], 7'b0000000, mem_i[8], 7'b0000000, mem_i[7], 7'b0000000, mem_i[6], 7'b0000000, mem_i[5], 7'b0000000, mem_i[4], 7'b0000000, mem_i[3], 7'b0000000, mem_i[2], 7'b0000000, mem_i[1],7'b0000000, mem_i[0]};
end


endmodule

