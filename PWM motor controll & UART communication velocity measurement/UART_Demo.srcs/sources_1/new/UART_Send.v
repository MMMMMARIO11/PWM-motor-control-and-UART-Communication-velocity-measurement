`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/24 20:21:12
// Design Name: 
// Module Name: UART_Send
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

//This is a routine for UART to send data, send temperature data, gyroscope data, magnetic field data.
module UART_Send(
    input clk_10MHz,
    input Tx_ACK,
    input Enable,
    input [15:0]Speed_o,
    input Dir_o,
    output reg Tx_En=0,
    output reg[7:0]Send_Buffer=0
    );
    //Defining the sending status

    //Defining the sending status

    reg [3:0]State_Speed_Cnt=0;
    //Trigger pulse
    reg [1:0]Pulse_Init_Flag=0;
    //Give the rising edge of the sender
    always@(posedge clk_10MHz or posedge Tx_ACK)
        begin
            if(Tx_ACK)
                begin
                    Tx_En<=~Tx_En;
                    Pulse_Init_Flag<=2;
                end
            else if(Pulse_Init_Flag==0)
                begin
                    Tx_En<=0;
                    Pulse_Init_Flag<=1;
                end
            else if(Pulse_Init_Flag[0])
                begin
                    Tx_En<=1;
                    Pulse_Init_Flag<=0;
                end
            else
                Tx_En<=0;    
        end
    //send data


wire [19:0]data_o;
    
BCD BCD0(
.rst_n(1),
.data_i(Speed_o),
.data_o(data_o)
);
reg [7:0]data1;
reg [7:0]data2;
reg [7:0]data3;
reg [7:0]data4;
reg [7:0]data5;
always@(*)
begin
data1<={4'b0000,data_o[3:0]}+8'b00110000;
end
always@(*)
begin
data2<={4'b0000,data_o[7:4]}+8'b00110000;
end
always@(*)
begin
data3<={4'b0000,data_o[11:8]}+8'b00110000;
end
always@(*)
begin
data4<={4'b0000,data_o[15:12]}+8'b00110000;
end
always@(*)
begin
data5<={4'b0000,data_o[19:16]}+8'b00110000;
end
reg [7:0]dir;
always@(*)
case(Dir_o)
0:dir<="P";
1:dir<="N";
endcase
    always@(posedge Tx_ACK)
        begin
                 case(State_Speed_Cnt)
                 0:begin Send_Buffer<=" ";State_Speed_Cnt<=State_Speed_Cnt+1;end
                1:begin Send_Buffer<=" ";State_Speed_Cnt<=State_Speed_Cnt+1;end
                2:begin Send_Buffer<="v";State_Speed_Cnt<=State_Speed_Cnt+1;end
                3:begin Send_Buffer<="=";State_Speed_Cnt<=State_Speed_Cnt+1;end
                4:begin Send_Buffer<=data5;State_Speed_Cnt<=State_Speed_Cnt+1;end
                5:begin Send_Buffer<=data4;State_Speed_Cnt<=State_Speed_Cnt+1;end
                6:begin Send_Buffer<=data3;State_Speed_Cnt<=State_Speed_Cnt+1;end
                7:begin Send_Buffer<=data2;State_Speed_Cnt<=State_Speed_Cnt+1;end//注意初始位是0
                8:begin Send_Buffer<=data1;State_Speed_Cnt<=State_Speed_Cnt+1;end
                9:begin Send_Buffer<="r";State_Speed_Cnt<=State_Speed_Cnt+1;end
                10:begin Send_Buffer<="/";State_Speed_Cnt<=State_Speed_Cnt+1;end
                11:begin Send_Buffer<="m";State_Speed_Cnt<=State_Speed_Cnt+1;end
                12:begin Send_Buffer<="i";State_Speed_Cnt<=State_Speed_Cnt+1;end
                13:begin Send_Buffer<="n";State_Speed_Cnt<=State_Speed_Cnt+1;end
                14:begin Send_Buffer<=";";State_Speed_Cnt<=State_Speed_Cnt+1;end
                15:begin Send_Buffer<=dir;State_Speed_Cnt<=State_Speed_Cnt+1;end
                16:begin Send_Buffer<=" ";State_Speed_Cnt<=0;end
                
                endcase
       end
endmodule
