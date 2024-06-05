// 24Î»ÃÜÂë¼Ä´æÆ÷×é
module passwd_register(d1,d2,d3,d4,d5,d6,q1,q2,q3,q4,q5,q6,clr,clk);
	
	input clk,clr;
	input [3:0] d1,d2,d3,d4,d5,d6;
	output [3:0] q1,q2,q3,q4,q5,q6;
	
	register r1(d1[3:0],q1[3:0],clk,clr);
	register r2(d2[3:0],q2[3:0],clk,clr);
	register r3(d3[3:0],q3[3:0],clk,clr);
	register r4(d4[3:0],q4[3:0],clk,clr);
	register r5(d5[3:0],q5[3:0],clk,clr);
	register r6(d6[3:0],q6[3:0],clk,clr);
	
endmodule