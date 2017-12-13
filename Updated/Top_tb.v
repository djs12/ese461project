`timescale 1ns / 1ps

module Top_tb();

reg  clk;
reg  reset;
reg inputSramWe;
reg w2SramWe;
reg [89:0] pixels;
wire [15:0] product;
reg [8:0] weight1;
reg [15:0] weight2;
reg [15:0] inputs1 [0:783];
reg [15:0] inputs2 [0:783];
reg [15:0] inputs3 [0:783];
reg [15:0] inputs4 [0:783];
reg [15:0] inputs5 [0:783];
reg [15:0] inputs6 [0:783];
reg [15:0] inputs7 [0:783];
reg [15:0] inputs8 [0:783];
reg [15:0] inputs9 [0:783];
reg [15:0] inputs10 [0:783];
/*reg [8:0] inputs11 [0:783];
reg [8:0] inputs22 [0:783];
reg [8:0] inputs33 [0:783];
reg [8:0] inputs44 [0:783];
reg [8:0] inputs55 [0:783];
reg [8:0] inputs66 [0:783];
reg [8:0] inputs77 [0:783];
reg [8:0] inputs88 [0:783];
reg [8:0] inputs99 [0:783];
reg [8:0] inputs1010 [0:783];*/
reg [89:0] inputs [0:783];
reg [15:0] weights1 [156799:0];

parameter VECTORSIZE = 784;
integer weightFile1;
integer weightFile2;
integer pixelFile1, pixelFile2, pixelFile3, pixelFile4, pixelFile5;
integer pixelFile6, pixelFile7, pixelFile8, pixelFile9, pixelFile10;
integer pixelRow;
integer pixelCol;
integer i, j;
integer fscanRet;
integer delay;
integer weightRow;
integer pos;
//below are offsets into the weight2.txt file
integer w2vec0offset, w2vec1offset, w2vec2offset, w2vec3offset, w2vec4offset;
integer w2vec5offset, w2vec6offset, w2vec7offset, w2vec8offset, w2vec9offset;
integer w2FileOffset;
reg [3:0] w2SramAddr;


Top DUT(.clk(clk), .reset(reset), .inputSramWe(inputSramWe), .pixels(pixels), .weight1(weight1), .w2SramWeOffChip(w2SramWe), .weight2(weight2), .weight2AddrOffChip(w2SramAddr), .rdata(product));

initial
begin
  $dumpfile("Top.vcd");
  $dumpvars(0, Top_tb);
     
  weightFile1 = $fopen("./TextFiles/weight1.txt", "r");
  weightFile2 = $fopen("./TextFiles/weight2.txt", "r");
  pixelFile1 = $fopen("./TextFiles/test_image1.txt", "r");
  pixelFile2 = $fopen("./TextFiles/test_image2.txt", "r");
  pixelFile3 = $fopen("./TextFiles/test_image3.txt", "r");
  pixelFile4 = $fopen("./TextFiles/test_image4.txt", "r");
  pixelFile5 = $fopen("./TextFiles/test_image5.txt", "r");
  pixelFile6 = $fopen("./TextFiles/test_image6.txt", "r");
  pixelFile7 = $fopen("./TextFiles/test_image7.txt", "r");
  pixelFile8 = $fopen("./TextFiles/test_image8.txt", "r");
  pixelFile9 = $fopen("./TextFiles/test_image9.txt", "r");
  pixelFile10 = $fopen("./TextFiles/test_image10.txt", "r");
  
  pixelRow = 0;
  pixelCol = 0;
  while(pixelRow < VECTORSIZE) begin
    fscanRet = $fscanf(pixelFile1, "%b", inputs1[pixelRow]);
    fscanRet = $fscanf(pixelFile2, "%b", inputs2[pixelRow]);
    fscanRet = $fscanf(pixelFile3, "%b", inputs3[pixelRow]);
    fscanRet = $fscanf(pixelFile4, "%b", inputs4[pixelRow]);
    fscanRet = $fscanf(pixelFile5, "%b", inputs5[pixelRow]);
    fscanRet = $fscanf(pixelFile6, "%b", inputs6[pixelRow]);
    fscanRet = $fscanf(pixelFile7, "%b", inputs7[pixelRow]);
    fscanRet = $fscanf(pixelFile8, "%b", inputs8[pixelRow]);
    fscanRet = $fscanf(pixelFile9, "%b", inputs9[pixelRow]);
    fscanRet = $fscanf(pixelFile10, "%b", inputs10[pixelRow]);

    //inputs11 = [8:0] inputs1[pixelRow]


    inputs[pixelRow] = { inputs10[pixelRow][8:0],inputs9[pixelRow][8:0],inputs8[pixelRow][8:0],inputs7[pixelRow][8:0],inputs6[pixelRow][8:0],inputs5[pixelRow][8:0],inputs4[pixelRow][8:0],inputs3[pixelRow][8:0],inputs2[pixelRow][8:0],inputs1[pixelRow][8:0] };
    //$display("%d. %b", pixelRow + 1, inputs1[pixelRow]);

    pixelRow = pixelRow + 1;
  end

  i = 0;
  while(i < 156800) begin
    fscanRet = $fscanf(weightFile1, "%b", weights1[i]);
    i = i + 1;
  end

  $fclose(pixelFile1);
  $fclose(pixelFile2);
  $fclose(pixelFile3);
  $fclose(pixelFile4);
  $fclose(pixelFile5);
  $fclose(pixelFile6);
  $fclose(pixelFile7);
  $fclose(pixelFile8);
  $fclose(pixelFile9);
  $fclose(pixelFile10);

  w2vec0offset = 0;
  w2vec1offset = 17*200;
  w2vec2offset = w2vec1offset + 17*200;
  w2vec3offset = w2vec2offset + 17*200;
  w2vec4offset = w2vec3offset + 17*200;
  w2vec5offset = w2vec4offset + 17*200;
  w2vec6offset = w2vec5offset + 17*200;
  w2vec7offset = w2vec6offset + 17*200;
  w2vec8offset = w2vec7offset + 17*200;
  w2vec9offset = w2vec8offset + 17*200;

  w2SramAddr = 4'b0000;
  w2SramWe = 0;
  weightRow = 0;
  delay = 0;
  clk = 0;
  reset = 0;
  //pixels[159:0] = inputs[0];
  //weight = weights1[0];
  inputSramWe = 1;
  for(i = 0; i < 200; i = i + 1) begin
    for(j = 0; j < 784; j = j + 1) begin
      pixels[89:0] = inputs[j];
      //writeW2(weightRow, i, j);
      if(i > 0) begin
         w2SramAddr = j;
         if(j == 0) begin
            w2SramWe = 1;
            w2FileOffset = w2vec0offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 1) begin
            w2SramWe = 1;
            w2FileOffset = w2vec1offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 2) begin
            w2SramWe = 1;
            w2FileOffset = w2vec2offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 3) begin
            w2SramWe = 1;
            w2FileOffset = w2vec3offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 4) begin
            w2SramWe = 1;
            w2FileOffset = w2vec4offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 5) begin
            w2SramWe = 1;
            w2FileOffset = w2vec5offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 6) begin
            w2SramWe = 1;
            w2FileOffset = w2vec6offset + (i-1)*17;
              fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 7) begin
            w2SramWe = 1;
            w2FileOffset = w2vec7offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 8) begin
            w2SramWe = 1;
            w2FileOffset = w2vec8offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j == 9) begin
            w2SramWe = 1;
            w2FileOffset = w2vec9offset + (i-1)*17;
            fscanRet = $fseek(weightFile2, w2FileOffset, 0);
            fscanRet = $fscanf(weightFile2, "%b", weight2); 
         end;
         if(j > 9) begin
            w2SramAddr = 0;
            w2SramWe = 0;
         end;
      end
     
#20

      weight1 = weights1[784*i + j][8:0];
      delay = delay + 20;
      if(delay  == 20) begin
         reset = 1;
      end else if(delay == 40) begin
         reset = 0;
      end
    end
  end


  //need to finish the rest of stage 2
  //and the final activation
  for(j = 0; j < 10; j = j + 1) begin
    w2SramAddr = j;
    if(j == 0) begin
      w2SramWe = 1;
      w2FileOffset = w2vec0offset + 199*17;
      fscanRet = $fseek(weightFile2, w2FileOffset, 0);
      fscanRet = $fscanf(weightFile2, "%b", weight2); 
    end
    else if(j == 1) begin
      w2SramWe = 1;
      w2FileOffset = w2vec1offset + 199*17;
      fscanRet = $fseek(weightFile2, w2FileOffset, 0);
      fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 2) begin
       w2SramWe = 1;
       w2FileOffset = w2vec2offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 3) begin
       w2SramWe = 1;
       w2FileOffset = w2vec3offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 4) begin
       w2SramWe = 1;
       w2FileOffset = w2vec4offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 5) begin
       w2SramWe = 1;
       w2FileOffset = w2vec5offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 6) begin
       w2SramWe = 1;
       w2FileOffset = w2vec6offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 7) begin
       w2SramWe = 1;
       w2FileOffset = w2vec7offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 8) begin
       w2SramWe = 1;
       w2FileOffset = w2vec8offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else if(j == 9) begin
       w2SramWe = 1;
       w2FileOffset = w2vec9offset + 199*17;
       fscanRet = $fseek(weightFile2, w2FileOffset, 0);
       fscanRet = $fscanf(weightFile2, "%b", weight2); 
     end
     else begin
       w2SramAddr = 0;
       w2SramWe = 0;
     end
#20;
  end

#15560
  $finish;
end

always 
  #10 clk = !clk;
endmodule
