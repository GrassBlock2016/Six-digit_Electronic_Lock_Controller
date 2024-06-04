// s用于开启判断（当发生变化就开始判断），a1-6和b1-6分别是输入的密码和已存的密码，c是判断结果（密码正确返回1）
module judge(s,[3:0]a1,[3:0]a2,[3:0]a3,[3:0]a4,[3:0]a5,[3:0]a6,[3:0]b1,[3:0]b2,[3:0]b3,[3:0]b4,[3:0]b5,[3:0]b6,c);

	input s;
	input [3:0] a1, a2, a3, a4, a5, a6, b1, b2, b3, b4, b5, b6;
	output reg c;
	
	always @(s) begin
		assign c <= 1'b0;
		for (int i = 0; i < 6; i++) begin
				if (a1[i] != b1[i] || a2[i] != b2[i] || a3[i] != b3[i] || a4[i] != b4[i] || a5[i] != b5[i] || a6[i] != b6[i]) begin
					c <= 1'b0;
					break;
	
			end
		end
		if (c) begin
			c <= 1'b1;
		end
	end
	
endmodule