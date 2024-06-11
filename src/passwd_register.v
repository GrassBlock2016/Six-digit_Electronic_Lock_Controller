// 24位密码寄存器组
module passwd_register(d1,d2,y0,y1,y2,q1,q2,q3,q4,q5,q6,clr,clk);
	
	input clk,clr;
	input [3:0] d1,d2;
	input y0,y1,y2;
	output [3:0] q1,q2,q3,q4,q5,q6;
	
	wire [3:0] d1_checked, d2_checked;
	
	// 非法传入（E）检查
	assign d1_checked = (d1 == 4'b1110) ? 4'b0000 : d1;
	assign d2_checked = (d2 == 4'b1110) ? 4'b0000 : d2;
	
	// 高两位
	register r1(d1_checked[3:0],q1[3:0],clk&y0,clr);
	register r2(d2_checked[3:0],q2[3:0],clk&y0,clr);
	
	// 中两位
	register r3(d1_checked[3:0],q3[3:0],clk&y1,clr);
	register r4(d2_checked[3:0],q4[3:0],clk&y1,clr);
	
	// 低两位
	register r5(d1_checked[3:0],q5[3:0],clk&y2,clr);
	register r6(d2_checked[3:0],q6[3:0],clk&y2,clr);
	
endmodule