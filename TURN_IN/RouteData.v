module RouteData(clk, Gate, M1Result, SigFeedback, SramData, RegLoadEn, RegLoadSel, Addr, DataOutSel, DataOut, DataToM2);

input clk, Gate, RegLoadEn, RegLoadSel, DataOutSel;
input [159:0] M1Result;
input [15:0] SigFeedback;
input [3:0] Addr;
input [15:0] SramData;
output reg [15:0] DataOut;
output reg [15:0]  DataToM2;

reg [159:0] regData;
wire clkGate;

assign clkGate = Gate & clk;

always @ (posedge clkGate)
begin
   if(RegLoadEn == 1 && RegLoadSel == 0) begin
     regData[15:0] <= M1Result[15:0];
     regData[31:16] <= M1Result[31:16];
     regData[47:32] <= M1Result[47:32];
     regData[63:48] <= M1Result[63:48];
     regData[79:64] <= M1Result[79:64];
     regData[95:80] <= M1Result[95:80];
     regData[111:96] <= M1Result[111:96];
     regData[127:112] <= M1Result[127:112];
     regData[143:128] <= M1Result[143:128];
     regData[159:144] <= M1Result[159:144];      
   end
   else if(RegLoadEn == 1 && RegLoadSel == 1) begin
     //load regData based on address
      case(Addr)
      4'b0000: begin regData[15:0] <= SigFeedback; end
      4'b0001: begin regData[31:16] <= SigFeedback; end
      4'b0010: begin regData[47:32] <= SigFeedback; end
      4'b0011: begin regData[63:48] <= SigFeedback; end
      4'b0100: begin regData[79:64] <= SigFeedback; end
      4'b0101: begin regData[95:80] <= SigFeedback; end
      4'b0110: begin regData[111:96] <= SigFeedback; end
      4'b0111: begin regData[127:112] <= SigFeedback; end
      4'b1000: begin regData[143:128] <= SigFeedback; end
      4'b1001: begin regData[159:144] <= SigFeedback; end
      endcase
   end
   else begin //if(RegLoadEn == 0) /*&& OutSel == 0*/) begin
     //output to LUT based on address
      case(Addr)
      4'b0000: begin DataToM2 <= regData[15:0]; end
      4'b0001: begin DataToM2 <= regData[31:16]; end
      4'b0010: begin DataToM2 <= regData[47:32]; end
      4'b0011: begin DataToM2 <= regData[63:48]; end
      4'b0100: begin DataToM2 <= regData[79:64]; end
      4'b0101: begin DataToM2 <= regData[95:80]; end
      4'b0110: begin DataToM2 <= regData[111:96]; end
      4'b0111: begin DataToM2 <= regData[127:112]; end
      4'b1000: begin DataToM2 <= regData[143:128]; end
      4'b1001: begin DataToM2 <= regData[159:144]; end
      endcase
   end
end

always @ (SramData, DataOutSel, DataToM2)
begin
   case(DataOutSel)
   1'b0: begin //selecting data from Intermediate Reg to LUT
         DataOut = DataToM2;
         end
   1'b1: begin //selecting data from GSRAM to LUT
         DataOut = SramData;
         end
   endcase
end
endmodule
