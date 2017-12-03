`timescale 1ns / 10ps

module Top_tb();

reg clk;
wire [159:0] q;

Top DUT(
.clk(clk),
.q(q)
);

initial
begin
$dumpfile("Top.vcd");
$dumpvars(0, Top_tb);

$readmemb("vector1.txt", DUT.S1.mem_i);

$monitor("q for vector1 is = %b", q);

clk = 0;

#100
$readmemb("vector2.txt", DUT.S1.mem_i);
$monitor("q for vector2 is = %b", q);

#100
$readmemb("vector3.txt", DUT.S1.mem_i);
$monitor("q for vector 3 is = %b", q);

#100

$finish;
end


always
  #10 clk = !clk;


endmodule
