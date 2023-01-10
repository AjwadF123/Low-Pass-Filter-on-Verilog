`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2022 06:57:50 PM
// Design Name: 
// Module Name: FIR_tb
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


module LPF_tb(
    );
      parameter N = 16;
      parameter M = 13;
      reg clk, reset;
      reg [N-1:0] data_in;
      wire[N-1:0] data_out;
      wire valid;
      wire [N-1:0] data_out_reg;
      
     LPF_parameterized uut 
      (.clk(clk),
      .reset(reset),
      .data_in(data_in),
      .data_out(data_out),
      .valid(valid),
      .data_out_reg(data_out_reg)
      );
      
      reg [7:0]Address;
      reg [N-1:0] RAMM [101:0];
  
      always # 5 clk = ~clk;
      
      integer i;
      
      initial begin
        reset =0;
        clk = 0;
        Address = 8'd0;
        reset = 1'b1;
        
        #100;      
      $readmemb("D:/Xilinx_projects/FIR/FIR.srcs/sources_1/new/signal2.data", RAMM);
      
      # 100;
      reset = 1'b0;
     
      
      end
   always @ (posedge clk) begin
   
       if (Address < 8'd101) begin
             data_in <= RAMM[Address];
             Address <= Address + 1;
       end
       else
            Address <= 8'd0;
   end
endmodule
