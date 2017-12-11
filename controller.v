`timescale 1ns / 1ps

module controller(
    input clk,
    input reset,
    
    output reg MAC_reset, //0: add to partial sum. 1: add to 0 (clearing)
    
    output reg reg_holder_in, // write enable of reg holder
    output reg reg_holder_mux, //0: load from MACs, 160 bits. 1: load from LUT, 16 bits, address provided
    output reg [3:0] reg_holder_addr,
    
    output reg LUT_mux, // 0: load from reg_holder, 1: load from GSRAM
    
    output reg [3:0] weight2_addr, //0~9
    output reg weight2_loadNextRow,
    
    output reg [3:0] GSRAM_addr_row, // 0~9
    output reg [3:0] GSRAM_addr_col, // 0~9
    output reg GSRAM_in, 
    output reg GSRAM_mux // 0->going to the adder, 1->going to the LUT
    );

reg [9:0] count_layer1_784D, count_layer1_784Q;
reg [7:0] count_layer1_200D, count_layer1_200Q;
reg [3:0] count_10D, count_10Q, count_10_2D, count_10_2Q;
reg [4:0] count_20D, count_20Q;

reg [2:0] currentState, nextState;

parameter IDLE=0, REG=1, REG_TO_LUT=2, LUT_TO_REG=3, REG_TO_MAC=4, GSRAM_TO_LUT=5, LUT_TO_GSRAM=6;

always @ * begin 
    //default values
    nextState = currentState;
    count_layer1_784D = count_layer1_784Q + 1;
    count_layer1_200D = count_layer1_200Q;
    count_10D = count_10Q;
    count_10_2D = count_10_2Q;
    count_20D = count_20Q;
    MAC_reset = 0;
    reg_holder_in = 0;
    reg_holder_mux = 0;
    reg_holder_addr = 0;
    LUT_mux = 0;
    weight2_addr = 0;
    weight2_loadNextRow = 0;
    GSRAM_addr_row = 0;
    GSRAM_addr_col = 0;
    GSRAM_in = 0; 
    GSRAM_mux = 0;
    
    if (count_layer1_200Q == 200) begin //if work of layer 1 is done, block layer 1 (this is not power efficient, maybe other ways?)
        count_layer1_784D = 0;
    end

    case (currentState)
    IDLE: begin
        if (count_layer1_784Q == 0) begin
            MAC_reset = 1;
        end
        else begin
            MAC_reset = 0;
        end

        if (count_layer1_784Q == 783) begin //if one round has completed
            count_layer1_784D = 0;
            count_layer1_200D = count_layer1_200Q + 1;
            nextState = REG;
        end
    end
    
    REG: begin
        MAC_reset = 1;
        reg_holder_in = 1;
        reg_holder_mux = 0; //load from MACs
        count_10D = 0;
        count_20D = 0;
        nextState = REG_TO_LUT;
    end
    
    REG_TO_LUT: begin
        LUT_mux = 0; // load from reg_holder
        reg_holder_addr = count_20Q[4:1];
        nextState = LUT_TO_REG;
    end
    
    LUT_TO_REG: begin
        reg_holder_in = count_20Q[0];
        reg_holder_mux = 1; // load from LUT
        reg_holder_addr = count_20Q[4:1];
        if (count_20Q==19) begin
            count_10D = 0;
            count_20D = 0;
            weight2_loadNextRow = 1;
            nextState = REG_TO_MAC;
        end else begin
            count_20D = count_20Q + 1;
            nextState = REG_TO_LUT;
        end
    end
    
    //assuming mult + add + store into 10x10 SRAM takes 1 clk cycle altogether
    REG_TO_MAC: begin
        GSRAM_addr_row = count_10Q;
        GSRAM_addr_col = count_10_2Q;
        reg_holder_addr = count_10Q;
        weight2_addr = count_10_2Q;
        if (count_10_2Q == 9 && count_10Q == 9) begin
            count_10D = 0;
            count_10_2D = 0;
            nextState = GSRAM_TO_LUT;
        end else begin
            count_10D = count_10Q + 1;
            GSRAM_in = 1;
            GSRAM_mux = 0; // load from adder
            if (count_10Q == 9) begin
                count_10D = 0;
                count_10_2D = count_10_2Q + 1;
            end
        end
    end
    
    GSRAM_TO_LUT: begin
        GSRAM_addr_row = count_10Q;
        GSRAM_addr_col = count_10_2Q;
        LUT_mux = 1; //load from GSRAM
        nextState = LUT_TO_GSRAM;
    end
        
    LUT_TO_GSRAM: begin
        GSRAM_in = 1;
        GSRAM_mux = 1; // load from GSRAM
        GSRAM_addr_row = count_10Q;
        GSRAM_addr_col = count_10_2Q;
        if (count_10_2Q == 9 && count_10Q == 9) begin
            count_10D = 0;
            count_10_2D = 0;
            nextState = IDLE;
        end else begin
            nextState = GSRAM_TO_LUT;
            if (count_10Q==9) begin
                count_10D = 0;
                count_10_2D = count_10_2Q + 1;
            end else begin
                count_10D = count_10Q + 1;
                nextState = GSRAM_TO_LUT;
            end
        end
    end
    
    default: begin end
    endcase
    
end

always @ (posedge clk) begin
    if (reset) begin
        currentState <= IDLE;
        count_layer1_784Q <= 0;
        count_layer1_200Q <= 0;
        count_10Q <= 0;
        count_20Q <= 0;
        count_10_2Q <= 0;
    end else begin
        currentState <= nextState;
        count_layer1_784Q <= count_layer1_784D;
        count_layer1_200Q <= count_layer1_200D;
        count_10Q <= count_10D;
        count_20Q <= count_20D;
        count_10_2Q <= count_10_2D;
    end
end
    
endmodule
