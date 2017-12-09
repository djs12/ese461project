`timescale 1ns / 10ps

module Top_tb();

reg clk;
reg reset;
reg [15:0] w1;
reg [4:0] count2; //Refresh weight2 count
reg [63:0] count; //Refresh input vector count


Top DUT(
.clk(clk),
.reset(reset),
.weight1(w1),
.ans(ans)
);

initial
begin
$dumpfile("Top.vcd");
$dumpvars(0, Top_tb);

//Initial values
clk = 0;
count = 0;
count2 = 0;
reset = 1;
#100
reset = 0;//drop reset and start simulation

#90000//finish after a long time
$finish;
end

always @ (posedge clk)
begin
count <= count + 1;
case(count)

endcase
end

always
  #10 clk = !clk;

always @ (posedge weight2_loadNextRow)
begin
count2 <= count2 + 1;
case(count2)


endcase
end

endmodule

