// EEM16 - Logic Design
// 2018_04_04
// Design Assignment #1
// dassign1.v

module inv(y,a);
   output y;
   input a;

   assign y=~(a);
endmodule

module nand2(y,a,b);
   output y;
   input a,b;
   wire d;
   assign d=a&b ;
   assign y=~(d);
endmodule

module nor2(y,a,b);
   output y;
   input a,b;
   wire d;
   assign d=a|b ;
   assign y=~(d);
endmodule

module dassign1_1 (pdec0,pdec3,pdec12,pdec15,nando,addr);
   output pdec0,pdec3,pdec12,pdec15;
   output [3:0] nando; //the output of the 4 nand gates that you should be using
   
   input [5:0] addr;

   //
   // vvv - Declare your wires here - vvv
   //
   wire a = addr[5];
   wire b = addr[4];
   wire c = addr[3];
   wire d = addr[2];
   wire notA;
   wire notB;
   wire notC;
   wire notD;
   wire ABnd;
   wire CDnd;
   wire ABd;
   wire CDd;

   //
   // vvv - Your structural verilog code here - vvv
   //
   inv ay(notA, a);
   inv be(notB, b);
   inv se(notC, c);
   inv di(notD, d);
  
   nand2 une(ABnd, notA, notB); 
   nand2 too(CDnd, notC, notD);
   nand2 tre(ABd, a, b);
   nand2 fer(CDd, c, d);
   
   nor2 un(pdec0, ABnd, CDnd); //pdec[0]
   nor2 to(pdec3, ABnd, CDd);  //pdec[3]
   nor2 te(pdec12, ABd, CDnd); //pdec[12]
   nor2 fr(pdec15, ABd, CDd);  //pdec[15]
  
   assign nando[0] = ABnd;
   assign nando[1] = CDnd;
   assign nando[2] = ABd;
   assign nando[3] = CDd;
endmodule


module dassign1_2 (y1, y2, a,b,c,d);
   output y1, y2;
   input a,b,c,d;

   //
   // vvv - Declare your wires here - vvv
   //
   wire notA;
   wire notB;
   wire notD;
   wire CDnor;
   wire BDnor;
   wire nAnBnor;
   wire t1nor;
   wire t2nand;

   //
   // vvv - Your structural verilog code here - vvv
   //
   inv ay(notA, a);
   inv be(notB, b);
   inv de(notD, d);
  
   nor2 un(CDnor, c, notD);
   nor2 to(BDnor, b, d);
   nor2 te(t1nor, CDnor, BDnor);
   nor2 fr(nAnBnor, notA, notB);

   nand2 une(t2nand, nAnBnor, c);
   nand2 too(y1, t1nor, t2nand);
   
  
   //
   // vvv - Your declarative verilog code here - vvv
   //
   
  assign y2 = (a & b & c) | (~(c) & d) | (~(b) & ~(d)) ;
   
endmodule // dassign1_2


module mux21(y, i0, i1, sel);
   output y;
   input  i0, i1,sel;

   //sel = 1 choose a, otherwise b)
   assign y = (sel) ? i1 : i0;
endmodule // mux21

module dassign1_3 (pos, pos3, ascii);
   input [6:0] ascii;
   output [4:0] pos;
   output 	pos3;


   //
   // vvv - Declare your reg and wires here - vvv
   //
   reg [4:0] 	pos;
   wire 	pos3;
   
   //
   // vvv - Your procedural verilog (case) code here - vvv
   //
  
   always @(ascii) begin
     
     case (ascii)
       7'b0100000: begin // space
         pos = 5'b00000; 
       end
       7'b1100001: begin // a 
         pos = 5'b00001;
       end
       7'b1100010: begin // b
         pos = 5'b00010;
       end
       7'b1100011: begin // c
         pos = 5'b00011;
       end
       7'b1100100: begin // d
         pos = 5'b00100;
       end
       7'b1100101: begin // e
         pos = 5'b00101;
       end
       7'b1100110: begin // f
         pos = 5'b00110;
       end
       7'b1100111: begin // g
         pos = 5'b00111;
       end
       7'b1101000: begin // h
         pos = 5'b01000;
       end
       7'b1101001: begin // i
         pos = 5'b01001;
       end
       7'b1101010: begin // j
         pos = 5'b01010;
       end
       7'b1101011: begin // k
         pos = 5'b01011;
       end
       7'b1101100: begin // l
         pos = 5'b01100;
       end
       7'b1101101: begin // m
         pos = 5'b01101;
       end
       7'b1101110: begin // n
         pos = 5'b01110;
       end
       7'b1101111: begin // o
         pos = 5'b01111;
       end
       7'b1110000: begin // p
         pos = 5'b10000;
       end
       7'b1110001: begin // q
         pos = 5'b10001;
       end
       7'b1110010: begin // r
         pos = 5'b10010;
       end
       7'b1110011: begin // s
         pos = 5'b10011;
       end
       7'b1110100: begin // t
         pos = 5'b10100;
       end
       7'b1110101: begin // u
         pos = 5'b10101;
       end
       7'b1110110: begin // v
         pos = 5'b10110;
       end
       7'b1110111: begin // w
         pos = 5'b10111;
       end
       7'b1111000: begin // x
         pos = 5'b11000;
       end
       7'b1111001: begin // y
         pos = 5'b11001;
       end
       7'b1111010: begin // z
         pos = 5'b11010;
       end
       // 7'b0000000: begin // nc
         // pos = 5'b11011;
       // end
       // 7'b0000000: begin // nc
         // pos = 5'b11100;
       // end
       7'b0101100: begin // ,
         pos = 5'b11101;
       end
       7'b0101110: begin // .
         pos = 5'b11110;
       end
       7'b0111111: begin // ?
         pos = 5'b11111;
       end
       default: begin
         pos = 5'b00000;
       end
     endcase

   end
   
   //
   // vvv - Your structural verilog code here for pos3 - vvv
   //
  assign pos3 = pos[3];
endmodule // dassign1_3

