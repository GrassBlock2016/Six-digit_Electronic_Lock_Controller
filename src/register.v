// 寄存器元单元，时钟上升沿打入数据
// d:输入数据    q:输出    clk:时钟信号    clr:重置
module register(d,q,clk,clr);
	input[3:0] d;
	output reg [3:0] q;
	input clk,clr;
	always@(posedge clk or posedge clr)
		begin
			if(clr) 
				q <= 4'b0000;
			else if (d != 4'b1110)
				q <= d;
		end
endmodule