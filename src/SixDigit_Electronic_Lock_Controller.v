module SixDigit_Electronic_Lock_Controller(
    input m,              // mode，切换模式，0为设置密码，1为输入密码
    input [3:0] in1, in2, in3, in4, in5, in6, // 输入
    input clk, clr,       // 时钟信号
    output [3:0] out1, out2, out3, out4, out5, out6, // 输出
    output reg res,        // 比较结果
    input a0,a1            // 高、中、低位输入与判断选择
);

    // 内部信号
    wire [3:0] passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6;
	wire y0,y1,y2,y3;      // 高位输入、中位输入、低位输入、判断选择
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;
    reg judge_enable;

    // 输出赋值
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;
    
    // 24译码器实例化
	yima2to4 yima(a0,a1,1,y0,y1,y2,y3);

    // 设置密码寄存器实例化
    passwd_register set_password(in1,in2,!m&y0,!m&y1,!m&y2,passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,clr & (~m),clk);

    // 比较模块实例化
    judge judge_1(a0 & a1,in1,in2,in3,in4,in5,in6,passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,res);

    // 模式选择和输出赋值的控制逻辑
    always @(posedge clk) begin
		if (m == 0) begin
	        // 模式0：设置密码
	        out1_reg <= in1;
	        out2_reg <= in2;
	        out3_reg <= in3;
	        out4_reg <= in4;
	        out5_reg <= in5;
	        out6_reg <= in6;
			if (clr) begin
				out1_reg <= 4'b0000;
				out2_reg <= 4'b0000;
				out3_reg <= 4'b0000;
				out4_reg <= 4'b0000;
				out5_reg <= 4'b0000;
				out6_reg <= 4'b0000;
			end
	    end else begin
	        // 模式1：输入密码并进行判断
	        judge_enable <= a0 & a1;
	        out1_reg <= passwd_out1;
	        out2_reg <= passwd_out2;
	        out3_reg <= passwd_out3;
	        out4_reg <= passwd_out4;
	        out5_reg <= passwd_out5;
	        out6_reg <= passwd_out6;
		end
	end

endmodule
