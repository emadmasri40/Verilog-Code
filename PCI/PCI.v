`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2018 09:41:03 AM
// Design Name: tishbhmot antotk
// Module Name: tishbhmot antotk
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
module PCI_ARBITER( 
	        input start,
			input REQ_A,
			input REQ_B,
			input REQ_C,
			input FRAME,
			input IRDY,
			input clk,
			input RESET,
			output GNT_A,
			output GNT_B,
			output GNT_C
    );
		reg [2:0] GNT_REG;
		reg [2:0] GNT_REG2;
		assign GNT_A = GNT_REG2[0];
		assign GNT_B = GNT_REG2[1];
		assign GNT_C = GNT_REG2[2];
		reg [1:0]counter_frame;
		reg counter_irdy;
		reg enable_frame;
		reg enable_irdy;
		reg [1:0]pointer;
		reg [1:0] mem [0:2] ;
		always @ (REQ_A , REQ_B , REQ_C)
			begin 
			if (start)
			  begin
				if (REQ_A==0 && mem[0]!=2'b00 && mem[1]!=2'b00 && mem[2]!=2'b00)
					begin 
						mem[pointer] = 2'b00;
						pointer = pointer + 1;
					end
					
				else if (REQ_B==0 && mem[0]!=2'b01 && mem[1]!=2'b01 && mem[2]!=2'b01)
					begin 
						mem[pointer] = 2'b01;
						pointer = pointer + 1;
					end
					
					
				else if (REQ_C==0 && mem[0]!=2'b10 && mem[1]!=2'b10 && mem[2]!=2'b10)
					begin 
						mem[pointer] = 2'b10;
						pointer = pointer + 1;
					end
			   end
			end
			
			always @ (posedge clk) 
			begin 
			  if (start)
			     begin
				if (!RESET || !FRAME  )
					GNT_REG=3'b111;
				else
					begin
						if (IRDY && FRAME)
						begin 
							if (mem[0]==2'b00)
								begin
									GNT_REG <= 3'b110;
									mem[0]=mem[1];
									mem[1]=mem[2];
									pointer = pointer-1;
									//enable_frame=0;
									//enable_irdy=0;
								end
						else if (mem[0]==2'b01)
								begin
									GNT_REG <= 3'b101;
									mem[0]=mem[1];
									mem[1]=mem[2];
									pointer = pointer-1;
									//enable_frame=0;
									//enable_irdy=0;
								end
						else if (mem[0]==2'b10)
								begin
									GNT_REG <= 3'b011;
									mem[0]=mem[1];
									mem[1]=mem[2];
									pointer = pointer-1;
									//enable_frame=0;
									//enable_irdy=0;
						  end		
						end
					end
				end
				else if(start==0)
				begin 
				 if (!RESET || !FRAME)
                                           GNT_REG=3'b111;
                                       else
                                           begin
                                               if (IRDY && FRAME )
                                               begin 
                                                   if ((GNT_REG==3'b111 || GNT_REG==3'b011 || GNT_REG==3'b101) && REQ_A==0)
                                                   GNT_REG <= 3'b110;
                                               else if ((GNT_REG==3'b111 || GNT_REG==3'b011 )  && REQ_B==0)
                                                   GNT_REG <= 3'b101;
                                               else if (GNT_REG==3'b111 && REQ_C==0)
                                                   GNT_REG <= 3'b011;
                                           end
                                       end
                                   
				end
				//if (!FRAME)
				 //   GNT_REG<= 3'b111;
			end
			always @ (negedge clk) 
				GNT_REG2 <= GNT_REG;
   
		initial 
			begin 
				GNT_REG=3'b111;
			//	counter_frame = 0;
			//	counter_irdy =0;
				pointer = 0;
				mem[0]=3;
			    mem[1]=3;
				mem[2]=3;
			end
		/*always @(posedge clk)
			begin 
				if (FRAME && IRDY)
					begin
						counter_frame = counter_frame+1;
						if (counter_frame == 2)
							begin 
								enable_frame=1;
								counter_frame=0;
							end
				   end
				else 
					enable_frame=0; 
					
				if (enable_frame == 1) 
				 begin 
					counter_irdy = counter_irdy+1;
						if (counter_irdy == 1)
						begin 
							counter_irdy=0 ;
							enable_irdy= 1 ;
						end 
					end
				else 
					enable_irdy =0;
			end
		*/
		endmodule

    module DEVICE(
    inout tri1 FRAME,
    inout [3:0] CBE,
    inout [31:0] AD,
    input [3:0] FORCE_CBE,
    input [31:0] FORCE_AD,
    input FORCE_REQ,
    input [31:0] ID,
    inout  IRDY,
    inout tri1 TRDY,
    input RST,
    inout DEVSEL,
    input CLK,
    input GNT,
    input [2:0] No_Data,
    output reg REQ 
    );
    
    reg [31:0] Memory [7:0];
    
    reg device_type;
    reg Master;
    reg slave;
    
    reg Take_Bus;
    reg return;
    reg DEV_TR;
    
    reg FRAME_reg;
    reg IRDY_reg;
    reg TRDY_reg;
    reg DEVSEL_reg;
    reg REQ_reg;
    
    reg [31:0] Address_reg;
    reg [31:0] Data_reg;
    
    reg [3:0] control;
    reg [3:0] B_E;
    reg [31:0] Out_Data; //the data which will save in slave memory after considering CBE
    
    
    reg [3:0] slave_control;
    reg slave_data;
    
    reg [1:0] count_trans ;
    reg       end_trans;
    reg [3:0] count_mem   ;
    
    reg master;
     
    assign FRAME = (device_type )? FRAME_reg : 1'bz ; // we need to let it = 1
    assign IRDY  = (device_type)? IRDY_reg  : 1'bz ;
 
    assign AD    = (device_type)?((Take_Bus)? Address_reg   :((control)? ((end_trans)? 32'bz : Data_reg) : 32'bz) ) :((slave && (!TRDY))? ((slave_control)? 32'bz :slave_data) : 32'bz ) ;
    assign CBE   = (device_type)?((Take_Bus)? control       :((control)? ((end_trans)? 4'bz :B_E) : 4'bz) ) : 4'bz ;
    
    assign  TRDY   = (slave)? TRDY_reg   : 1'bz ;
    assign  DEVSEL = (slave)? DEVSEL_reg : 1'bz;
    
    
    
    always @(posedge CLK)
        begin
         if(!RST)
            begin
                count_mem <= -1 ; /// /// // /
                FRAME_reg <= 1 ;
                IRDY_reg  <= 1 ;
                REQ_reg   <= 1 ;
                REQ       <= 1 ;
                slave     <= 0 ;
                DEV_TR    <= 0 ;
                end_trans <= 0 ;
                device_type <=1 ;
                master <=0 ; 
            end
         
         
         if(!GNT && RST && FRAME)
            begin
                device_type <=1; // master
                
            end    
            else if (GNT && RST && !master )
                device_type <=0; //may be salve
                
          // master  
            
         if(device_type)  
            begin
                if(FRAME && IRDY)
                   begin
                    Take_Bus  <=1;
                    return    <=1 ;
                   end
                   
                if( (!FRAME) && IRDY)
                    begin
                        return <= 0;
                    end
                    
                    
            end
            
            
        //slave    
            
        else  
            begin
              if((!device_type) && (ID == AD ))
                    begin
                     slave_control<= CBE;
                     slave  <= 1;
                    end
              if(FRAME && !TRDY)
                    end_trans <= 1;
            end
            
       end
      
      
      
      
        
    always @(negedge CLK)
        begin
        
      if(!FORCE_REQ)
            REQ <= 0;  
        
        // Master
      if (device_type)
        begin
        
           if(Take_Bus) // master && i take the bus 
             begin
                Take_Bus     <= return;
                FRAME_reg    <= 0 ;
                REQ          <= 1 ;
                Address_reg  <= FORCE_AD;
                control      <= FORCE_CBE;
                count_trans  <= No_Data;
             end
      
           
           if(return == 0)
                begin
                    IRDY_reg    <= 0 ;
                end
                
          if(FRAME && !TRDY)
                begin 
                  end_trans <= 1;
                  IRDY_reg  <= 1;
                end
                  
            // master operation    
           if(!DEVSEL && !TRDY && control)
                begin  
                  if(count_trans != 0)
                    begin
                        Data_reg <= FORCE_AD  ;
                        B_E      <= FORCE_CBE ;
                        count_trans <= count_trans - 1;
                         
                        if((count_trans == 1) || (No_Data==1) )
                               FRAME_reg <= 1 ;
                                         
                    end
                end
                               
           if( !DEVSEL && !TRDY && !control)
                begin
                   if(count_trans != 0)
                       begin
                            Memory[count_mem] <= AD ;
                            count_mem   <= count_mem + 1 ;
                            count_trans <= count_trans - 1;
                            
                            if((count_trans == 1) || (No_Data == 1) )
                                  FRAME_reg <= 1 ;                          
                       end

                end
          end      
        // Slave
        else 
          begin
               if(slave)
                   begin
                    if(!end_trans)
                            begin
                                DEVSEL_reg <= 0;
                                TRDY_reg   <= 0; 
                            end
                        else
                            begin
                                DEVSEL_reg <= 1;
                                TRDY_reg   <= 1; 
                            end
                            
                    // slave operation         
                   if(!DEVSEL && !TRDY && slave_control)  //write
                        begin
      
                                        case(CBE)
                                        1: Out_Data = {24'b x ,AD[7:0]} ;
                                        2: Out_Data = {16'b x ,AD[15:8],8'b x } ;
                                        3: Out_Data = {16'b x ,AD[15:0]} ;
                                        4: Out_Data = {8'b x ,AD[23:16],24'b x } ;
                                        5: Out_Data = {8'b x ,AD[23:16],8'b x,AD[7:0]} ;
                                        6: Out_Data = {8'b x ,AD[23:8],8'b x } ;
                                        7: Out_Data = {8'b x ,AD[23:0]} ;
                                        8: Out_Data = {AD[31:24],24'b x } ;
                                        9: Out_Data = {AD[31:24],16'b x,AD[7:0]} ;
                                        10:Out_Data = {AD[31:24],8'b x,AD[15:8],8'b x} ;
                                        11:Out_Data = {AD[31:24],8'b x,AD[15:0]} ;
                                        12:Out_Data = {AD[31:16],16'b x} ;
                                        13:Out_Data = {AD[31:16],8'b x,AD[7:0]} ;
                                        14:Out_Data = {AD[31:8],8'b x} ;
                                        15:Out_Data = AD ;                                            
               
                                        endcase
          // Out_Data = AD ;
                                        Memory[count_mem] <= Out_Data ;
                                        count_mem   <= count_mem + 1 ;


                        end 
                   if(!DEVSEL && !TRDY && !slave_control) //read              
                       begin
                            slave_data <= FORCE_AD ;                             
                       end
                      
             end
          end
            
                        
   end
    
    
    
endmodule


module tb();


    wire FRAME;
    wire [3:0] CBE;
    wire [31:0] AD;
    reg [3:0] FORCE_CBE_A;
    reg [3:0] FORCE_CBE_B;
    reg [3:0] FORCE_CBE_C;
    reg [31:0] FORCE_AD_A;
    reg [31:0] FORCE_AD_B;
    reg [31:0] FORCE_AD_C;
    reg FORCE_REQ_A;
    reg FORCE_REQ_B;
    reg FORCE_REQ_C;
    reg [31:0] ID_A;
    reg [31:0] ID_B;
    reg [31:0] ID_C;
    wire IRDY;
    wire TRDY;
    reg RST;
    wire DEVSEL;
    reg CLK;
    reg GNT_A_reg;
    reg GNT_B_reg;
    reg GNT_C_reg;
    wire GNT_A;
    wire GNT_B;
    wire GNT_C;
    reg [2:0] No_Data_A;
    reg [2:0] No_Data_B;
    reg [2:0] No_Data_C;
    wire REQ_A;
    wire REQ_B;
    wire REQ_C;
    
    
    reg start;
   DEVICE A (FRAME,CBE,AD,FORCE_CBE_A,FORCE_AD_A,FORCE_REQ_A,ID_A,IRDY,TRDY, RST,DEVSEL, CLK, GNT_A_reg,No_Data_A, REQ_A);
   DEVICE B (FRAME,CBE,AD,FORCE_CBE_B,FORCE_AD_B,FORCE_REQ_B,ID_B,IRDY,TRDY, RST,DEVSEL, CLK, GNT_B_reg,No_Data_B, REQ_B);
   DEVICE C (FRAME,CBE,AD,FORCE_CBE_C,FORCE_AD_C,FORCE_REQ_C,ID_C,IRDY,TRDY, RST,DEVSEL, CLK, GNT_C_reg,No_Data_C, REQ_C);
    PCI_ARBITER tb ( start,REQ_A,REQ_B, REQ_C,FRAME,IRDY,CLK,RST,GNT_A,GNT_B,GNT_C);
        
    

    always
        begin
           #1 CLK = ~CLK ;
           
    
           
           GNT_A_reg <= GNT_A;
           GNT_B_reg <= GNT_B;
           GNT_C_reg <= GNT_C;
           
           
        end
    
    initial
        begin

           // CLK =0;
           // ID_A  = 0;
           // ID_B  = 1;
           // GNT_A = 1;
           // GNT_B = 1;
            start=0;
               CLK =0;
               ID_A  = 0;
               ID_B  = 1;
               ID_C  = 2;
               
        
            $monitor (" RST= %b  FRAME= %b  CBE= %b  AD= %b  IRDY= %b  TRDY= %b  DEVSEL= %b  GNT= %b  No_Data= %b   REQ= %b ", RST , FRAME , CBE , AD  ,IRDY , TRDY , DEVSEL , GNT_A , No_Data_A , REQ_A );
             
              RST = 0 ;
             #2
               RST = 1 ;
               FORCE_REQ_A = 0 ;
               //REQ_A_reg=0;
             #1
               No_Data_A   = 3 ;
              // No_Data_B   = 3 ;
          //     GNT_A = 0 ;
               
             #1
              // FORCE_AD_A  = 32'd1 ;
              // FORCE_AD_B  = 0 ;
              // FORCE_CBE_A = 1 ;
             //  FORCE_REQ_A = 1 ;
              FORCE_AD_A  = 32'd1 ;
              FORCE_CBE_A = 1 ;
                         //  FORCE_REQ_A = 1 ;

             
             #6
               //FORCE_AD_A  = 32'd15 ;
               //FORCE_CBE_A = 3 ;
                FORCE_AD_A  = 32'hAAAAAAAA ;
                FORCE_CBE_A = 15 ;
       
                             
            /*  #10
            //  GNT_A=1;
              RST = 0 ;
              #2
               RST = 1 ;
                FORCE_REQ_A = 1 ;
                FORCE_REQ_B = 0 ;
              #1
                No_Data_A   = 3 ;
                No_Data_B   = 3 ;
              // GNT_B = 0 ;
                #1
               FORCE_AD_B  = 32'd0 ;
               FORCE_CBE_B = 1 ;
               FORCE_REQ_B = 1 ;
                                           
                #6
                 FORCE_AD_B  = 32'hBBBBBBBB ;
                  FORCE_CBE_B = 15 ;
             */
                 
                //  #6
              //                GNT_A=1;
                //              GNT_B=1;
                          //    RST = 0 ;
                            //  #6
                            //   RST = 1 ;
                             //   FORCE_REQ_C = 0 ;
                            //  #1
                             //   No_Data_A   = 3 ;
                              //  No_Data_C   = 3 ;
                  //             GNT_C = 0 ;
                              //  #1
                             //  FORCE_AD_C  = 32'd0 ;
                              // FORCE_CBE_C = 1 ;
                              // FORCE_REQ_C = 1 ;
                                                           
                              //  #6
                               //  FORCE_AD_C  = 32'hCCCC_CCCC ;
                                //  FORCE_CBE_C = 3 ;
                                          
        end
    

endmodule