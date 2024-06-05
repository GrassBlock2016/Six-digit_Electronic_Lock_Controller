// 24Î»ÃÜÂë¼Ä´æÆ÷×é
module passwd_register(d,q,clr,clk);
	
	input clk,clr;
	input [23:0] d;
	output [23:0] q;
	
	register r1(d[3:0],q[3:0],clk,clr);
	register r2(d[7:4],q[7:4],clk,clr);
	register r3(d[11:8],q[11:8],clk,clr);
	register r4(d[15:12],q[15:12],clk,clr);
	register r5(d[19:16],q[19:16],clk,clr);
	register r6(d[23:20],q[23:20],clk,clr);
endmodule