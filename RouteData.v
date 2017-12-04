module RouteData(clk, L1In, LutIn, DataSel, OutSel, RegIn, RegOut ,Addr);

input DataSel, OutSel, RegIn, RegOut;
input [15:0] LutIn;
input [3:0] Addr;
input [159:0] L1In;

reg [159:0] data;
reg [159:0] dataBuff;

always @ (posedge clk)
begin
   if(RegIn == 1 && DataSel == 0) begin
     dataBuff[15:0] <= data[15:0];
     dataBuff[31:16] <= data[31:16];
     dataBuff[47:32] <= data[47:32];
     dataBuff[63:48] <= data[63:48];
     dataBuff[79:64] <= data[79:64];
     dataBuff[95:80] <= data[95:80];
     dataBuff[111:96] <= data[111:96];
     dataBuff[127:112] <= data[127:112];
     dataBuff[143:128] <= data[143:128];
     dataBuff[159:144] <= data[159:144];      
   end
   else if(RegIn == 1 && DataSel == 1) begin
     //load dataBuff based on address
      case(Addr)
      4'b0000: dataBuff[15:0]
      4'b0001:
      4'b0010:
      4'b0011:
      4'b0100:
      4'b0101:
      4'b0110:
      4'b0111:
      4'b1000:
      4'b1001:
   end
   else if(RegOut == 1 /*&& OutSel == 0*/) begin
     //output to LUT based on address
      case(Addr)
      4'b0000: 
      4'b0001:
      4'b0010:
      4'b0011:
      4'b0100:
      4'b0101:
      4'b0110:
      4'b0111:
      4'b1000:
      4'b1001:
   end
   /*else if(RegOut == 1 && OutSel == 1) begin
      //output to MAC stage 2 based on address
      case(Addr)
      4'b0000:
      4'b0001:
      4'b0010:
      4'b0011:
      4'b0100:
      4'b0101:
      4'b0110:
      4'b0111:
      4'b1000:
      4'b1001:
   end*/
   else begin
      dataBuff[15:0] <= dataBuff[15:0];
      dataBuff[31:16] <= dataBuff[31:16];
      dataBuff[47:32] <= dataBuff[47:32];
      dataBuff[63:48] <= dataBuff[63:48];
      dataBuff[79:64] <= dataBuff[79:64];
      dataBuff[95:80] <= dataBuff[95:80];
      dataBuff[111:96] <= dataBuff[111:96];
      dataBuff[127:112] <= dataBuff[127:112];
      dataBuff[143:128] <= dataBuff[143:128];
      dataBuff[159:144] <= dataBuff[159:144];
   end
end

always @ (L1In, LutIn, DataSel)
begin
   case(DataSel)
   1'b0: begin //from mac
         data[15:0] = L1In[15:0];
         data[31:16] = L1In[31:16];
         data[47:32] = L1In[47:32];
         data[63:48] = L1In[63:48];
         data[79:64] = L1In[79:64];
         data[95:80] = L1In[95:80];
         data[111:96] = L1In[111:96];
         data[127:112] = L1In[127:112];
         data[143:128] = L1In[143:128];
         data[159:144] = L1In[159:144];
         end
   1'b1: begin //from LUT
         data[15:0] = LutIn;
         data[31:16] = LutIn;
         data[47:32] = LutIn;
         data[63:48] = LutIn;
         data[79:64] = LutIn;
         data[95:80] = LutIn;
         data[111:96]= LutIn;
         data[127:112] = LutIn;
         data[143:128] = LutIn;
         data[159:144] = LutIn;
         end
   endcase

   case(OutSel)
   1'b0: begin 
         data[15:0]  = L1In[15:0];
         data[31:16] = L1In[31:16];
         data[47:32] = L1In[47:32];
         data[63:48] = L1In[63:48];
         data[79:64] = L1In[79:64];
         data[95:80] = L1In[95:80];
         data[111:96] = L1In[111:96];
         data[127:112] = L1In[127:112];
         data[143:128] = L1In[143:128];
         data[159:144] = L1In[159:144];
         end
   1'b1: begin 
         data[15:0] = LutIn;
         data[31:16] = LutIn;
         data[47:32] = LutIn;
         data[63:48] = LutIn;
         data[79:64] = LutIn;
         data[95:80] = LutIn;
         data[111:96]= LutIn;
         data[127:112] = LutIn;
         data[143:128] = LutIn;
         data[159:144] = LutIn;
         end
end
endmodule
