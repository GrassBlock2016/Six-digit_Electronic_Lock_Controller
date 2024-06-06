module reset (

    input reset_switch,   // ���ÿ���

    output reg [3:0] out1, out2, out3, out4, out5, out6,  // �������
	
input clk            // ʱ���ź�

);

    

	always @(posedge clk or posedge reset_switch) begin
		if (reset_switch) begin
            // �����ÿ��ر�����ʱ���������������Ϊ 0000
			out1 <= 4'b0000;
          
			out2 <= 4'b0000;
			out3 <= 4'b0000;
			out4 <= 4'b0000;
			out5 <= 4'b0000;
			out6 <= 4'b0000;
		end
	end

	
endmodule