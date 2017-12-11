module gSRAM(
clk,
we,
row,
col,
//wdata, //write data
m2result,
lutdata,
inmuxsel,
rdata,  //read data
mem0,//final answer data
mem1,
mem2,
mem3,
mem4,
mem5,
mem6,
mem7,
mem8,
mem9
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

output reg [159:0] mem0, mem1, mem2, mem3, mem4, mem5, mem6, mem7, mem8, mem9;


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

  else begin
    rdata <= mem[row][col];
  end


  	//Output final answer logic
  	mem0 <= {mem[0][0],mem[0][1],mem[0][2],mem[0][3],mem[0][4],mem[0][5],mem[0][6],mem[0][7],mem[0][8],mem[0][9]};
	mem1 <= {mem[1][0],mem[1][1],mem[1][2],mem[1][3],mem[1][4],mem[1][5],mem[1][6],mem[1][7],mem[1][8],mem[1][9]};
	mem2 <= {mem[2][0],mem[2][1],mem[2][2],mem[2][3],mem[2][4],mem[2][5],mem[2][6],mem[2][7],mem[2][8],mem[2][9]};
	mem3 <= {mem[3][0],mem[3][1],mem[3][2],mem[3][3],mem[3][4],mem[3][5],mem[3][6],mem[3][7],mem[3][8],mem[3][9]};
	mem4 <= {mem[4][0],mem[4][1],mem[4][2],mem[4][3],mem[4][4],mem[4][5],mem[4][6],mem[4][7],mem[4][8],mem[4][9]};
	mem5 <= {mem[5][0],mem[5][1],mem[5][2],mem[5][3],mem[5][4],mem[5][5],mem[5][6],mem[5][7],mem[5][8],mem[5][9]};
	mem6 <= {mem[6][0],mem[6][1],mem[6][2],mem[6][3],mem[6][4],mem[6][5],mem[6][6],mem[6][7],mem[6][8],mem[6][9]};
	mem7 <= {mem[7][0],mem[7][1],mem[7][2],mem[7][3],mem[7][4],mem[7][5],mem[7][6],mem[7][7],mem[7][8],mem[7][9]};
	mem8 <= {mem[8][0],mem[8][1],mem[8][2],mem[8][3],mem[8][4],mem[8][5],mem[8][6],mem[8][7],mem[8][8],mem[8][9]};
	mem9 <= {mem[9][0],mem[9][1],mem[9][2],mem[9][3],mem[9][4],mem[9][5],mem[9][6],mem[9][7],mem[9][8],mem[9][9]};
	

end



endmodule



