// �Ĵ���Ԫ��Ԫ��ʱ�������ش�������
// d:��������    q:���    clk:ʱ���ź�    clr:����
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