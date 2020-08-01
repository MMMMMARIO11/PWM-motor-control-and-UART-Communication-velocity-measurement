`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/31 07:42:07
// Design Name: 
// Module Name: BCD
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


module	BCD(
input	rst_n	,
input	[15:0]data_i	,
output	[19:0]data_o		
);
//**************************************************************
//***define variable********************************************
reg[ 3:0] 				data_0	;
reg[ 9:0] 				data_1	;
reg[13:0] 				data_2	;
reg[18:0] 				data_3	;

reg[ 5:0]				data_a	;	
reg[ 5:0]				data_b	;	
reg[ 5:0]				data_c	;	
reg[ 5:0]				data_d	;	
reg[ 3:0]				data_e	;	

//**************************************************************
//---提取data_i[3:0]
always@(*)
	if(rst_n == 1'b0)
		data_0 <= 'd0;
	else
		data_0 <= data_i[3:0];

//**************************************************************
//---提取data_i[7:3]
always@(*)
	if(rst_n == 1'b0)
		data_1 <= 'd0;
    else
		case(data_i[7:4])
			4'h0: data_1 <= 10'h000;
			4'h1: data_1 <= 10'h016;
			4'h2: data_1 <= 10'h032;
			4'h3: data_1 <= 10'h048;
			4'h4: data_1 <= 10'h064;
			4'h5: data_1 <= 10'h080;
			4'h6: data_1 <= 10'h096;
			4'h7: data_1 <= 10'h112;
			4'h8: data_1 <= 10'h128;
			4'h9: data_1 <= 10'h144;
			4'ha: data_1 <= 10'h160;
			4'hb: data_1 <= 10'h176;
			4'hc: data_1 <= 10'h192;
			4'hd: data_1 <= 10'h208;
			4'he: data_1 <= 10'h224;
			4'hf: data_1 <= 10'h240;
			default: data_1 <= 10'h000;
		endcase

//**************************************************************
//---提取data_i[11:8]
always@(*)
	if(rst_n == 1'b0)
		data_2 <= 'd0;
    else
		case(data_i[11:8]) 
			4'h0: data_2 <= 14'h0000;
			4'h1: data_2 <= 14'h0256;			
			4'h2: data_2 <= 14'h0512;			
			4'h3: data_2 <= 14'h0768;			
			4'h4: data_2 <= 14'h1024;			
			4'h5: data_2 <= 14'h1280;			
			4'h6: data_2 <= 14'h1536;			
			4'h7: data_2 <= 14'h1792;			
			4'h8: data_2 <= 14'h2048;			
			4'h9: data_2 <= 14'h2304;			
			4'ha: data_2 <= 14'h2560;			
			4'hb: data_2 <= 14'h2816;			
			4'hc: data_2 <= 14'h3072;			
			4'hd: data_2 <= 14'h3328;			
			4'he: data_2 <= 14'h3584;			
			4'hf: data_2 <= 14'h3840;			
			default: data_2 <= 14'h0000;
		endcase
		
//**************************************************************
//---提取data_i[15:12]		
always@(*)				
	if(rst_n == 1'b0)
		data_3 <= 'd0;
    else
		case(data_i[15:12])
			4'h0: data_3 <= 19'h00000;
			4'h1: data_3 <= 19'h04096;			
			4'h2: data_3 <= 19'h08192;			
			4'h3: data_3 <= 19'h12288;			
			4'h4: data_3 <= 19'h16384;			
			4'h5: data_3 <= 19'h20480;			
			4'h6: data_3 <= 19'h24576;			
			4'h7: data_3 <= 19'h28672;			
			4'h8: data_3 <= 19'h32768;			
			4'h9: data_3 <= 19'h36864;			
			4'ha: data_3 <= 19'h40960;			
			4'hb: data_3 <= 19'h45056;			
			4'hc: data_3 <= 19'h49152;			
			4'hd: data_3 <= 19'h53248;			
			4'he: data_3 <= 19'h57344;				
			4'hf: data_3 <= 19'h61440;					  
			default: data_3 <= 19'h00000;
		endcase

always@(*)  
	if(rst_n == 1'b0)
		begin
			data_a <= 'd0;
		    data_b <= 'd0;
		    data_c <= 'd0;
		    data_d <= 'd0;
		    data_e <= 'd0;
		end
	else		
		begin 
			data_a <= addbcd4(data_0[3:0],data_1[3:0],data_2[3:0],  data_3[3:0]);
			data_b <= addbcd4(data_a[5:4],data_1[7:4],data_2[7:4],  data_3[7:4]);
			data_c <= addbcd4(data_b[5:4],data_1[9:8],data_2[11:8], data_3[11:8]);
			data_d <= addbcd4(data_c[5:4],4'h0,		  data_2[13:12],data_3[15:12]);
			data_e <= data_d[5:4] + data_3[18:16];
		end


assign data_o = {data_e,data_d[3:0],data_c[3:0],data_b[3:0],data_a[3:0]};

//**************************************************************
//---function(定义一个转换函数)
//四个四位二进制位相加最大值为:4'hf+4'hf+4'hf+4'hf=6'd3C		
function [5:0] addbcd4	; 
input	[3:0] 	add1	;
input	[3:0] 	add2	;
input	[3:0] 	add3	;
input	[3:0] 	add4	;
	begin
		addbcd4 = add1 + add2 + add3 + add4;
		if(addbcd4 > 6'h3b)
			addbcd4 = addbcd4 + 5'h24;	//大于十进制数59，结果加十进制36
		if(addbcd4 > 6'h31)
			addbcd4 = addbcd4 + 5'h1e;	//大于十进制数49，结果加十进制30
		if(addbcd4 > 6'h27)
			addbcd4 = addbcd4 + 5'h18;	//大于十进制数39，结果加十进制24
		if(addbcd4 > 6'h1d)
			addbcd4 = addbcd4 + 5'h12;	//大于十进制数29，结果加十进制18
		else if(addbcd4 > 6'h13)
			addbcd4 = addbcd4 + 4'hc;	//大于十进制数19，结果加十进制12
		else if(addbcd4 > 6'h09)
			addbcd4 = addbcd4 + 4'h6;	//大于十进制数9，结果加十进制6
	end
endfunction
endmodule
