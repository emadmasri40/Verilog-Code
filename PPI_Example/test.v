`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:58:49 11/23/2018 
// Design Name: 
// Module Name:    test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Port_Full(
    inout [7:0] Data_Bus,
    inout [7:0] Port,
    input [7:0] Control //select input 1 or output 0
	 
    );
	 reg [7:0] Out_Latch;
	 always @(Control)
	 Out_Latch <= Data_Bus;
	 genvar i;
	 generate 
		for (i=0;i<8;i=i+1)
			begin: interface 
			
				//Out_Latch[i] = (Co[i])? 0 : Data_Bus[i] ;
				assign Port[i]	 = (Control[i])? Port[i] : Out_Latch[i]   ;
				assign Data_Bus[i]= (Control[i])? Port[i] :Data_Bus[i] ;	
				end 
			
	 endgenerate 
	// initial
		//begin
			//Out_Latch = (Control)? 8'b0 : Data_Bus ;
		//end
	//assign port	 = (Control)? Port : Out_Latch   ;
	//assign Data_Bus= (Control)? port :Data_Bus ;
endmodule
///////////////////////////////////////////////////////////
/*module Port_Half(
    inout [3:0] Data_Bus,
    inout [3:0] Port,
    input Control //select input 1 or output 0
    );
	 reg [7:0] Out_Latch;
  initial
		begin
			Out_Latch = (Control)? 8'b0 : Data_Bus ;
		end
	assign port	 = (Control)? Port : Out_Latch   ;
	assign Data_Bus= (Control)? port :Data_Bus ;

endmodule
/////////////////////////////////////////////////
module Group(
 inout [7:0] Data_Bus,
 inout [7:0] Port,
 inout [3:0] Port_half,
 input [1:0] INC  // input control 
);

wire [1:0] OUTC;
assign OUTC=INC;
Port_Full PAB(Data_Bus,Port,OUTC[1]);
Port_Half PC(Data_Bus[3:0],Port_half,OUTC[0]);
endmodule 
////////////////////////////////////////////////
module PPI(
 inout [7:0] PortA,
 inout [7:0] PortB,
 inout [7:0] PortC,
 inout [7:0] PortD,
 input [1:0] A_C,
 input CS,
 input RD,
 input WR, 
 input RESET 
);

 wire [7:0] Data_Bus;
 reg [7:0] Control_Reg;
reg CA;
reg CB;
reg CC;
 Group A(Data_Bus,PortA,PortC[7:4],PortD[4:3]);
 Group B(Data_Bus,PortB,PortC[3:0],PortD[1:0]);
 Port_Full PA(Data_Bus , PortA ,CA );
always @(A_C,WR,RD,RESET)
	begin
		if(!RESET)
		 	begin
				if(!CS)
			case(A_C)
					0		  :  CA=(!RD)?0:((!WR)?1:);
					1		  : 
					2       :
					default : 
			  endcase 
			end 
		else 
		begin
			PortA=0;
			portB=0;
			portC=0;
			end
	end
	endmodule 
*/ 