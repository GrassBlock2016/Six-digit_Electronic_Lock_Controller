// �Ĵ���Ԫ��Ԫ��ʱ�������ش�������
// d:��������    q:���    clk:ʱ���ź�    clr:����
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