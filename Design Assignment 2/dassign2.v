// EEM16 - Logic Design
// 2018_04_13
// Design Assignment #2
// dassign2.v

//
// modules provided for your use
//
module inv(y,a);
   output y;
   input  a;

   assign y=~(a);
endmodule

module and2(y,a,b);
   output y;
   input  a,b;

   assign y=a&b ;
endmodule

module or2(y,a,b);
   output y;
   input  a,b;

   assign y=a|b ;
endmodule

module xor2(y,a,b);
   output y;
   input  a,b;

   assign y=a^b ;
endmodule

module mux21(y, i0, i1, sel);
   output y;
   input  i0, i1,sel;

   //sel = 1 choose i1, otherwise i0)
   assign y = (sel) ? i1 : i0;
endmodule // mux21

//
// Blocks for you to design begins here
//
module sbs(d, bout, x, y, bin);
   output d, bout;
   input  x, y, bin;
  
    
   // d Logic
  
   wire exor;

   xor2 un(exor, x, y);
   xor2 to(d, bin, exor);
   
   // bout Logic
  
   wire xinv;
  
   wire and1;
   wire and2;
   wire and3;
  
   wire ortmp;
  
   inv won(xinv, x);
  
   and2 one(and1, xinv, bin);
   and2 two(and2, xinv, y);
   and2 tre(and3, y, bin);
  
   or2 o(ortmp, and1, and2);
   or2 t(bout, ortmp, and3);
  
endmodule 

module subtract8(d, bout, x, y);
   output [7:0] d;
   output 	bout;
   input [7:0] 	x, y;

   wire 	bin;
   wire [7:0] 	b;

   assign bin = 1'b0;
   assign bout = b[7];
  
   // 
   // Implement the 8-bit subtract function here
   // 
  
   sbs sbs0(d[0], b[0], x[0], y[0], bin);
   sbs sbs1(d[1], b[1], x[1], y[1], b[0]);
   sbs sbs2(d[2], b[2], x[2], y[2], b[1]);
   sbs sbs3(d[3], b[3], x[3], y[3], b[2]);
   sbs sbs4(d[4], b[4], x[4], y[4], b[3]);
   sbs sbs5(d[5], b[5], x[5], y[5], b[4]);
   sbs sbs6(d[6], b[6], x[6], y[6], b[5]);
   sbs sbs7(d[7], b[7], x[7], y[7], b[6]);
  
   assign bout = b[7];

endmodule

module dassign2_1 (q, rout, rin, din);
   output q;
   output [7:0] rout;
   input [7:0] 	rin, din;
   //
   // Instantiate the subtract module
   // 
   wire 	bout;
   wire [7:0] 	dout;

   subtract8 sub8(dout, bout, rin, din);         

   //
   // Implement the rest of the SCS function here
   //
  
   inv outinv(q, bout);
   mux21 mux_1(rout[0], rin[0], dout[0], q);
   mux21 mux_2(rout[1], rin[1], dout[1], q);
   mux21 mux_3(rout[2], rin[2], dout[2], q);
   mux21 mux_4(rout[3], rin[3], dout[3], q);
   mux21 mux_5(rout[4], rin[4], dout[4], q);
   mux21 mux_6(rout[5], rin[5], dout[5], q);
   mux21 mux_7(rout[6], rin[6], dout[6], q);
   mux21 mux_8(rout[7], rin[7], dout[7], q);

endmodule

module dassign2_2 (motor_drv, done, forw, rev, reset, drv_clk);
   output [3:0] motor_drv;
   output 	done;
   input 	forw, rev, reset, drv_clk;

   //
   // Parameters declaration for State Bits (An example)
   //
   parameter STATE_BITS = 2;
   parameter S0_ST = 2'b00;
   parameter S1_ST = 2'b01;
   parameter S2_ST = 2'b10;
   parameter S3_ST = 2'b11;

   reg [STATE_BITS-1:0] state, nx_state;
   reg 			done;
   reg [3:0] 		motor_drv;

   //
   // Storage elements for the state bits (You should not change)
   //
   always @(posedge drv_clk) begin
      state <= nx_state;
   end

   always @(state or forw or rev or reset) begin
     if (reset) begin
       state = S0_ST;
       motor_drv = 4'b0000;
     end
     
     // Foward Motor Input
     
     else if(forw) begin
       
       case(state)
         
         S0_ST:begin
           nx_state = S1_ST;
           motor_drv = 4'b0001;
         end
         
         S1_ST:begin
           nx_state = S2_ST;
           motor_drv = 4'b0010;
         end
         
         S2_ST:begin
           nx_state = S3_ST;
           motor_drv = 4'b0100;
         end
         
         S3_ST:begin
           nx_state = S0_ST;
           motor_drv = 4'b1000;
         end
         
       endcase
       
     end
     
     // Reverse Motor Input
     
     else if(rev) begin
       
       case(state)
         
         S0_ST:begin
           nx_state = S3_ST;
           motor_drv = 4'b0001;
         end
         
         S1_ST:begin
           nx_state = S0_ST;
           motor_drv = 4'b0010;
         end
         
         S2_ST:begin
           nx_state = S1_ST;
           motor_drv = 4'b0100;
         end
         
         S3_ST:begin
           nx_state = S2_ST;
           motor_drv = 4'b1000;
         end
         
       endcase
       
     end
     
     // Reset Input
     
     else begin
       
       nx_state = state;
       motor_drv = 4'b0000; 
       
     end
     
     done = (motor_drv == 4'b0001);
       
   end // always @ (state or forw or rev or reset)
endmodule // dassign2_2


