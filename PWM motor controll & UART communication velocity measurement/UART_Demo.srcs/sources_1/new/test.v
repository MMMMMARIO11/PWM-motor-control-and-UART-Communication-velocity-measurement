`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 07:38:16
// Design Name: 
// Module Name: test
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


module test(
input clk_i,
input rst_n,
input EncoderA_i,//编码器为500线
input EncoderB_i,
output [15:0] Speed_o,
output Dir_o

    );
    reg [18:0] clk_cnt;//Fpga频率计数
    reg [15:0] speed=0;
    reg dir=0;//0 正方向 1反方向
    reg stop;
    always@(posedge clk_i) begin
        if(rst_n==0) begin 
            clk_cnt<=0;
         end
         else begin
            if(clk_cnt==19'd50_0000) begin //100Mhz时钟计时5ms
                 clk_cnt<=0;
                 stop<=1;
             end
            else begin 
                clk_cnt<=clk_cnt+1'd1;
                stop<=0;
            end           
         end
     end
    reg[18:0] A_cnt;
    always@(posedge EncoderA_i) begin
        if(EncoderB_i==1'b1)
                dir<=1;
            else
                dir<=0;
    end
     always@(posedge EncoderA_i or negedge rst_n or posedge stop) begin

        if(rst_n==0)
            A_cnt<=0;
        else begin
            if(stop==1) begin
                A_cnt<=0;
            end
            else 
                A_cnt<=A_cnt+1;
         end
      end

     always@(*)begin
        if(clk_cnt==19'd49_9999)begin
            speed<=24*A_cnt;//Speed 单位为 r/min,24是5ms测速周期
                            //的单位换算系数
         end
         else speed<=speed;
         end

     assign Speed_o = speed;
     assign Dir_o = dir;



endmodule
