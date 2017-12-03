module gSRAM(
clk,
we,
row,
col,
wdata, //write data
rdata  //read data
);

input clk, we;
input [3:0] row, col;
input [15:0] wdata;
output [15:0] rdata;

reg [15:0] rdata;

//2D array 10 by 10 composed of 16 bit elements
//Row major order
reg [15:0] mem [9:0][9:0];


//initialize gSRAM to be all zero
initial
begin

  for (int r=0; r < 10; r=r+1) begin
    for (int c=0; c < 10; c=c+1) begin
      mem[r][c] = 0;
    end
  end

end

always @ (posedge clk)
begin
  
  if(we == 1'b1) begin
    mem[row][col] <= wdata;
  end

  else begin
    rdata <= mem[row][col];
  end

end




endmodule

