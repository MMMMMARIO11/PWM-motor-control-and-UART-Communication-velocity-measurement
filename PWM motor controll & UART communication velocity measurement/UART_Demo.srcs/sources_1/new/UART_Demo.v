`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/11 14:19:51
// Design Name: 
// Module Name: UART_Demo
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


module UART_Demo(
    input clk_100MHz,
    input UART0_Rx,
    output UART0_Tx,
    output int1,
    output int2,
    input rst,
    input EncoderA_i,
    input EncoderB_i,
    input Key
    );
    //clock
    wire clk_100MHz_System;
    wire clk_10MHz;
    
    wire Tx_ACK;
    wire Rx_ACK;
    wire Tx_En;
    wire [7:0]Send_Buffer;
    wire [7:0]Rx_Data;
    wire [31:0]Speed_o;
    wire Dir_o;
    //Frequency divider
    clk_wiz_0 clk_10(.clk_out1(clk_100MHz_System),.clk_out2(clk_10MHz),.clk_in1(clk_100MHz));
    
    Driver_UART UART0(
        .clk_100MHz(clk_100MHz_System),
        .Rst(1),
        .En_Rx(1),
        .En_Tx(Tx_En),
        .Baud_Rate(115200),
        .Rx(UART0_Rx),
        .Tx_Data(Send_Buffer),
        .Tx(UART0_Tx),
        .Rx_Data(Rx_Data),
        .Rx_ACK(Rx_ACK),
        .Tx_ACK(Tx_ACK)
        );
    UART_Send UART_Send0(
        .clk_10MHz(clk_10MHz),
        .Tx_ACK(Tx_ACK),
        .Enable(1),
        .Dir_o(Dir_o),
        .Speed_o(Speed_o),
        .Tx_En(Tx_En),
        .Send_Buffer(Send_Buffer)
        );
        test test0(
        .clk_i(clk_100MHz_System),
        .rst_n(rst),
        .EncoderA_i(EncoderA_i),
        .EncoderB_i(EncoderB_i),
        .Speed_o(Speed_o),
        .Dir_o(Dir_o)
        );
 director director0(
 .clk(clk_100MHz_System),
 .key(Key),
 .int1(int1),
 .int2(int2)
);       
endmodule
