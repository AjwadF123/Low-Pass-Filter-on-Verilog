`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2022 02:41:44 PM
// Design Name: 
// Module Name: moving_average
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LPF_parameterized(clk, reset, data_in, data_out,valid,data_out_reg
    );
    parameter N = 16; //No. of bits
    parameter M= 13; //No. of coefficients
    parameter Y = 4; //No. of bits for counting coefficients
    input clk, reset;
    reg [N-1:0] coefficients [0:M-1];
    input [N-1:0] data_in;
    output reg[N-1:0] data_out;
    reg [4:0] count;
    output valid;
    wire [N-1:0]sum;
    reg [N-1:0]sum_reg;
    output reg [N-1:0] data_out_reg;
    
 // COEFFICIENTS
    initial begin
     $readmemb("D:/Xilinx_projects/FIR/coefficients_hpf.data", coefficients);
    end

  
    // DELAYED SIGNALS;
    reg [N-1:0] x[0:M-1];
    
    reg [Y-1:0]count_for_delay;
   
   // INITIAL data_in Values
   integer j;
   initial begin 
        sum_reg <= 16'd0;
        count_for_delay <= 4'd1;
        for (j =0; j<M; j=j+1) begin
            x[j] <= 16'd0;
        end
        
        
    end
  
  always @ (posedge clk) begin
    if (!reset)
        x[0] <= data_in;
    else begin
        x[0] <= 16'd0;
        sum_reg <= 16'd0;
    end
  end
  
  always @ (posedge clk) begin
    if (!reset) begin
        for (j = 1; j<M; j=j+1) begin
            x[j] <= x[j-1];
        end
    
    end
   
   end //always
 
    // MAC
    reg [N-1:0]mul[0:M-1];
    wire [N-1:0]mul0,mul1,mul2,mul3,mul4,mul5,mul6,mul7,mul8,mul9,mul10,mul11,mul12;
  //  integer j;
    
    always @ (*) begin
    
        for (j =0; j< 13; j=j+1) begin
            mul[j] <= x[j] * coefficients[j]; 
        end
    
    end
    
    
    assign mul0 = x[0] * coefficients[0];
    assign mul1 = x[1] *coefficients[1];
    assign mul2 = x[2] *coefficients[2];
    assign mul3 = x[3] * coefficients[3];
    assign mul4 = x[4] * coefficients[4];
    assign mul5 = x[5] *coefficients[5];
    assign mul6 = x[6] *coefficients[6];
    assign mul7 = x[7] * coefficients[7];
    assign mul8 = x[8] * coefficients[8];
    assign mul9 = x[9] *coefficients[9];
    assign mul10 = x[10] *coefficients[10];
    assign mul11= x[11] * coefficients[11];
    assign mul12= x[12] * coefficients[12];
    
    
  
    
   assign sum = mul0+mul1+mul2+mul3+ mul4 +mul5+mul6+mul7+mul8 +mul9 +mul10  +mul11 +mul12;
  // integer f;
  always @(*) begin
        sum_reg = 0;
    for (j=0; j<M; j=j+1) begin
        sum_reg =  sum_reg + mul[j];
    end
    
   end
   
   // FINAL SUM
   always @ (posedge clk) begin
        
        data_out <= sum;
        data_out_reg <= sum_reg;
   
   end
    
  assign valid = 1'b1;//(count==5'd4)? 1'b1: 1'b0;
    
endmodule
