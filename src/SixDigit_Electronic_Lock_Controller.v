module SixDigit_Electronic_Lock_Controller(s,a1,a2,a3,a4,a5,a6,b1,b2,b3,b4,b5,b6,c);
	
	input s;
	input [3:0] a1, a2, a3, a4, a5, a6, b1, b2, b3, b4, b5, b6;
	output reg c;
	
	judge(s,a1,a2,a3,a4,a5,a6,b1,b2,b3,b4,b5,b6,c);
endmodule