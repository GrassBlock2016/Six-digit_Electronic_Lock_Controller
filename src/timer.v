// ��ʱ����������˸��ʱ���׼
module timer(
    input clk,			// ����ʱ���ź�
    output reg tick		// ����Ż����ʱ���ź����ڵƵ���˸
);
    reg [23:0] count;	// ��߻���2��24�η����൱��������������Ż�ʱ���źŵ�ʱ��
    always @(posedge clk) begin
        count <= count + 1;
        tick <= (count == 0);
    end
endmodule
