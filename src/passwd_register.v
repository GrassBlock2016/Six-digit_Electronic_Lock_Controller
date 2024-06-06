// 24λ����Ĵ�����
module passwd_register(d1,d2,y0,y1,y2,q1,q2,q3,q4,q5,q6,clr,clk);
	
	input clk,clr;
	input [3:0] d1,d2;
	input y0,y1,y2;
	output [3:0] q1,q2,q3,q4,q5,q6;
	
	// ����λ
	register r1(d1[3:0],q1[3:0],clk&y0,clr);
	register r2(d2[3:0],q2[3:0],clk&y0,clr);
	
	// ����λ
	register r3(d1[3:0],q3[3:0],clk&y1,clr);
	register r4(d2[3:0],q4[3:0],clk&y1,clr);
	
	// ����λ
	register r5(d1[3:0],q5[3:0],clk&y2,clr);
	register r6(d2[3:0],q6[3:0],clk&y2,clr);
	
endmodule