// 寄存器元单元，时钟上升沿打入数据
// d:输入数据    q:输出    clk:时钟信号    clr:重置
module register(d,q,clk,clr);
	input[3:0] d;
	output[3:0] q;
	input clk,clr;
	reg[3:0] q;
	always@(posedge clk or posedge clr)
		begin
			if(clr) 
				q=0;
			else 
				q=d;
		end
endmodule