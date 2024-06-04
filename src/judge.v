// s用于开启判断（当发生变化就开始判断），a1-6和b1-6分别是输入的密码和已存的密码，c是判断结果（密码正确返回1）
module judge(s,a1,a2,a3,a4,a5,a6,b1,b2,b3,b4,b5,b6,c);

	input s;
	input [3:0] a1, a2, a3, a4, a5, a6, b1, b2, b3, b4, b5, b6;
	output reg c;
	
	always @(s) begin
		assign c <= 1'b1;
		if (s) begin
			if (a1[0] ^ b1[0] || a1[1] ^ b1[1] || a1[2] ^ b1[2] || a1[3] ^ b1[3]) begin
				c <= 1'b0;
			end else if (a2[0] ^ b2[0] || a2[1] ^ b2[1] || a2[2] ^ b2[2] || a2[3] ^ b2[3]) begin
        		c <= 1'b0;
			end else if (a3[0] ^ b3[0] || a3[1] ^ b3[1] || a3[2] ^ b3[2] || a3[3] ^ b3[3]) begin
				c <= 1'b0;
			end else if (a4[0] ^ b4[0] || a4[1] ^ b4[1] || a4[2] ^ b4[2] || a4[3] ^ b4[3]) begin
        		c <= 1'b0;
	      	end else if (a5[0] ^ b5[0] || a5[1] ^ b5[1] || a5[2] ^ b5[2] || a5[3] ^ b5[3]) begin	
        		c <= 1'b0;
	  	    end else if (a6[0] ^ b6[0] || a6[1] ^ b6[1] || a6[2] ^ b6[2] || a6[3] ^ b6[3]) begin
	   	 	    c <= 1'b0;
			end
		end
	end
	
endmodule