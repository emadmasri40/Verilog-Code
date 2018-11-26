`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:07:02 10/07/2018 
// Design Name: 
// Module Name:    decoter 
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
module decoter(
    input [3:0] number,
    output  a,
    output  b,
    output  c,
    output  d,
    output  e,
    output  f,
    output  g
    );
reg [6:0] deco;

	always @(number)
	begin 
		case (number)
		 0: deco=7'b0111111;
		 1: deco=7'b0000110;
		 2: deco=7'b1011011;
		 3: deco=7'b1001111;
		 4: deco=7'b1100110;
		 5: deco=7'b1101101;
		 6: deco=7'b1111101;
		 7: deco=7'b0000111;
		 8: deco=7'b1111111;
		 9: deco=7'b1101111;  
		endcase 
	end 
	 
	 
	assign 	a =deco[0];
	assign	b =deco[1];
	assign	c =deco[2];
	assign	d =deco[3];
	assign	e =deco[4];
	assign	f =deco[5];
	assign	g =deco[6];
		
endmodule

/*module counter (
        
       input CK,
       input Up_Dow,
       input Enable,
       input Reset,
       input Cr,
		 output reg carry_out,
		 output a,
		 output b,
		 output c,
		 output d,
		 output e,
		 output f,
		 output g
		// output reg [3:0] number 

    );
	 reg  [3:0] number ;
	decoter A(number,a,b,c,d,e,f,g);	
 initial 
	begin
	    carry_out <=0;
			number =0;
	end 
  always @ ( posedge CK &Reset&Enable&Up_Dow ,Cr )
	begin
			if(Reset==0)
				number <=0;
			if(Cr==1)
				number <=4'd 0;
			if(Enable==1&&Up_Dow==1&&Reset==1)
			  begin
					number = number+1;
					if(number==10)
						begin 
						number =0;
						carry_out <=1;
						end 
				end
				
				if(Enable==1&&Up_Dow==0&&Reset==1)
				begin
					number =number-1;
					if(number==0)
					begin 
						number =9;
						carry_out <=1;
					end 	
				end
	end 
endmodule
module tb1();
reg R,E,C,U;
reg ck;
wire a,b,c,d,e,f,g,dd;
wire [3:0] n;
integer i;
initial
	begin
	 $monitor (" a=%b, b=%b, c=%b, d=%b, e=%b, f=%b, g=%b ",a,b,c,d,e,f,g);
	ck=0;
	 R=0;
	E=1;
	U=1;
#10
R=1;
E=1;
U=1;
#10	
R=1;
E=1;
U=0;
	end 


 
always 
begin
#5
 ck=~ck;
  end
counter A(ck,U,E,R,C,dd,a,b,c,d,e,f,g);



endmodule */