`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 13:15:32
// Design Name: 
// Module Name: PWM_Key
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


module director(
input clk,				//系统时钟(100MHz)
input  key,				//按键输入(KEY1~KEY3)
output int1,
output int2				//PWM波输出
 );
//reg [6:0] duty=60;    //PWM占空比控制输出
reg dout1,dout2,dout3,buff;	    	//消抖寄存器
reg motor_dir=1;				//电机正反转
//reg [31:0]Freq=100000;  //初始化电机频率=100000
//reg Rst=1;
wire key_edge;				//按键消抖输出	
integer cnt_100Hz;
reg clk_100Hz;
	always @(posedge clk)
	begin
			cnt_100Hz <= cnt_100Hz + 1'b1;
				if(cnt_100Hz== 249999)
					begin
						cnt_100Hz <= 32'b0;
						clk_100Hz <= ~clk_100Hz;
			        end
    end
	always @(posedge clk_100Hz)
			begin
            dout1 <= key;
            dout2 <= dout1;
            dout3 <= dout2;
            end    
 always @(posedge clk)
begin
buff <= dout1 | dout2 | dout3;
end
assign key_edge = ~(dout1 | dout2 | dout3) & buff;

always @(posedge clk)			//按键3，控制电动机正/反转
begin
if(key_edge)	
motor_dir <= ~motor_dir;
end
assign int1 = motor_dir;
assign int2 = ~motor_dir;

        
endmodule

           
            

