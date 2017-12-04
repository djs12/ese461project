`timescale 1ns / 1ps

module controller(
    input clk,
    input reset,
    input [159:0] input_sram_out,
    input [15:0] weight1,
    input [15:0] LUT_out,
    output [15:0] LUT_in,
    input [15:0] GSRAM_out,
    output [3:0] GSRAM_addr_row,
    output [3:0] GSRAM_addr_col,
    output [15:0] GSRAM_in,
    output GSRAM_we,
    
    output reg MAC_layer1_mux, //0: add to partial sum. 1: add to 0 (clearing)
    
    output reg reg_holder_in, // write enable of reg holder
    output reg reg_holder_mux_in, //0: load from MACs, 160 bits. 1: load from LUT, 16 bits, address provided
    output reg reg_holder_out, // output enable of reg holder
    output reg reg_holder_mux_out, //0: output to LUT, 16 bits. 1: output to Multiplier, 16 bits. Address provided  
    output reg [3:0] reg_holder_addr
    
    );

reg [9:0] count_layer1_784D, count_layer1_784Q;
reg [7:0] count_layer1_200D, count_layer1_200Q;
reg [3:0] count_10D, count_10Q;

reg [2:0] currentState, nextState;

parameter IDLE=0, REG=1, REG_OUT_TO_LUT=2, REG_IN_TO_REG=3, REG_OUT_TO_MAC=4;

always @ * begin 
    //default values
    nextState = currentState;
    count_layer1_784D = count_layer1_784Q + 1;
    count_layer1_200D = count_layer1_200Q;
    count_10D = count_10Q;
    MAC_layer1_mux = 0;
    reg_holder_in = 0;
    reg_holder_mux_in = 0;
    reg_holder_out = 0;
    reg_holder_mux_out = 0;
    reg_holder_addr = 0;
    
    if (count_layer1_200Q == 200) begin //if work of layer 1 is done, block layer 1 (this is not power efficient, maybe other ways?)
        count_layer1_784D = 0;
    end

    case (currentState)
    IDLE: begin
        if (count_layer1_784Q == 783) begin //if one round has completed
            count_layer1_784D = 0;
            count_layer1_200D = count_layer1_200Q + 1;
            nextState = REG;
        end
    end
    
    REG: begin
        MAC_layer1_mux = 1;
        reg_holder_in = 1;
        reg_holder_mux_in = 0; //load from MACs
        count_10D = 0;
        nextState = REG_OUT_TO_LUT;
    end
    
    REG_OUT_TO_LUT: begin
        reg_holder_out = 1;
        reg_holder_mux_out = 0; //output to LUT
        reg_holder_addr = count_10Q;
        nextState = REG_IN_TO_REG;
    end
    
    REG_IN_TO_REG: begin
        reg_holder_in = 1;
        reg_holder_mux_in = 1; // load from LUT
        reg_holder_addr = count_10Q;
        if (count_10Q==9) begin
            count_10D = 0;
            nextState = REG_OUT_TO_MAC;
        end else begin
            count_10D = count_10Q + 1;
            nextState = REG_OUT_TO_LUT;
        end
    end
    
    REG_OUT_TO_MAC: begin
        reg_holder_out = 1;
        reg_holder_mux_out = 1;
        reg_holder_addr = count_10Q;
        count_10D = count_10Q + 1;
        if (count_10Q == 9)begin
            nextState = IDLE;
            count_10D = 0;
        end
    end
    
    
    endcase
    
end

always @ (posedge clk) begin
    if (reset) begin
        currentState <= IDLE;
        count_layer1_784Q <= 0;
        count_layer1_200Q <= 0;
        count_10Q <=0;
    end else begin
        currentState <= nextState;
        count_layer1_784Q <= count_layer1_784D;
        count_layer1_200Q <= count_layer1_200D;
        count_10Q <= count_10D;
    end
end
    
endmodule

