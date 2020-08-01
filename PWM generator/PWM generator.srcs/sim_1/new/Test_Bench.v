`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/26 21:30:13
// Design Name: 
// Module Name: Test_Bench
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



module Test_Bench();
   reg clk_100MHz;
   wire PWM;
   wire int1,int2;
   PWM_Demo test(
               .PWM(PWM),
               .int1(int1),
               .int2(int2),
               .clk_100MHz(clk_100MHz));
   
   initial begin
       clk_100MHz = 0;
       forever begin
       #10 clk_100MHz=~clk_100MHz;
       end
   end
endmodule