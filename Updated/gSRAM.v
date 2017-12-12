module gSRAM(
clk,
we,
row,
col,
//wdata, //write data
m2result,
lutdata,
inmuxsel,
rdata  //read data
);

input clk, we, inmuxsel;
input [3:0] row, col;
//input [15:0] wdata;
input [15:0] lutdata;
input [15:0] m2result;
output [15:0] rdata;

reg [15:0] rdata;
reg [15:0] wdata;

//2D array 10 by 10 composed of 16 bit elements
//Row major order
reg [15:0] mem [9:0][9:0];


integer r;
integer c;

//initialize gSRAM to be all zero
initial
begin

  for (r=0; r < 10; r=r+1) begin
    for (c=0; c < 10; c=c+1) begin
      mem[r][c] = 0;
    end
  end

end

always @ (m2result, lutdata, inmuxsel)
begin
   case(inmuxsel)
   1'b0: begin wdata = m2result; end
   1'b1: begin wdata = lutdata; end
   endcase
end

always @ (posedge clk)
begin
  
  if(we == 1'b1) begin
    mem[row][col] <= wdata;
  end

  rdata <= mem[row][col];
end




endmodule


