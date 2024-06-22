module SixDigit_Electronic_Lock_Controller(
    input m,              // mode，切换模式，0为设置密码，1为输入密码
    input [3:0] inA, inB, // 输入
    input clk, clr, true_clk,       // 手动时钟信号，清空，自动时钟信号
    input a0, a1,      // 高、中、低位输入与判断选择
	input ps0,ps1,    // 多密码选择
	input hide,
    output [3:0] out1, out2, out3, out4, out5, out6, // 输出
    output res,        // 比较结果
	output led,       // LED输出
	output [1:0] eo		// 错误计数器的输出
);

    // 内部信号
	wire [3:0] set1_out1, set1_out2, set1_out3, set1_out4, set1_out5, set1_out6;
    wire [3:0] set2_out1, set2_out2, set2_out3, set2_out4, set2_out5, set2_out6;
    wire [3:0] set3_out1, set3_out2, set3_out3, set3_out4, set3_out5, set3_out6;
    wire [3:0] set4_out1, set4_out2, set4_out3, set4_out4, set4_out5, set4_out6;
    wire [3:0] cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6;
    wire [3:0] in1, in2, in3, in4, in5, in6, checked_inA, checked_inB;
    wire y0, y1, y2, y3;      // 高位输入、中位输入、低位输入、判断选择
    wire p0, p1, p2, p3;	  // 密码1、密码2、密码3、密码4
	wire res1,res2,res3,res4; // 每个密码的比较结果
	wire [1:0] error_count;
	wire res_tmp;
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;
	reg start_flashing;
	reg res_reg;
	
	assign res_tmp = (res1|res2|res3|res4) & m;
	
	// 如果输入非进制数则显示E(error)
	assign checked_inA = (inA > 4'b1001) ? 4'b1110 : inA;
	assign checked_inB = (inB > 4'b1001) ? 4'b1110 : inB;

    // 输出赋值
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;
	assign res = res_reg;
	assign eo = error_count;

    // 模式选择24译码器实例化
    yima2to4 yima_mode(a0, a1, 0, y0, y1, y2, y3);

    // 多密码选择24译码器实例化
    yima2to4 yima_passwd(ps0, ps1, 0, p0, p1, p2, p3);

    // 设置密码寄存器实例化
    passwd_register set_password1(
        checked_inA, checked_inB, (!m&p0) & y0, (!m&p0) & y1, (!m&p0) & y2,
        set1_out1, set1_out2, set1_out3, set1_out4, set1_out5, set1_out6,
        clr & (!m&p0), clk
    );

	passwd_register set_password2(
        checked_inA, checked_inB, (!m&p1) & y0, (!m&p1)& y1, (!m&p1) & y2,
        set2_out1, set2_out2, set2_out3, set2_out4, set2_out5, set2_out6,
        clr & (!m&p1), clk
    );

	passwd_register set_password3(
        checked_inA, checked_inB, (!m&p2) & y0, (!m&p2) & y1, (!m&p2) & y2,
        set3_out1, set3_out2, set3_out3, set3_out4, set3_out5, set3_out6,
        clr & (!m&p2), clk
    );

	// (!m) & y0
	passwd_register set_password4(
        checked_inA, checked_inB, (!m&p3) & y0, (!m&p3) & y1, (!m&p3) & y2,
        set4_out1, set4_out2, set4_out3, set4_out4, set4_out5, set4_out6,
        clr & (!m&p3), clk
    );

    // 输入密码寄存器实例化
	passwd_register cin_password(
        checked_inA, checked_inB, m & y0, m & y1, m & y2,
        cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6,
        clr & (m), clk
    );

    // 比较模块实例化
    judge jg1(y3&m, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set1_out1, set1_out2, set1_out3, set1_out4, set1_out5, set1_out6, res1);
	judge jg2(y3&m, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set2_out1, set2_out2, set2_out3, set2_out4, set2_out5, set2_out6, res2);
	judge jg3(y3&m, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set3_out1, set3_out2, set3_out3, set3_out4, set3_out5, set3_out6, res3);
	judge jg4(y3&m, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set4_out1, set4_out2, set4_out3, set4_out4, set4_out5, set4_out6, res4);
	
	// 错误计数器模块实例化
	error_counter error_cnt(y3&m, clk, res_tmp, error_count);
	
	// LED闪烁控制状态机模块实例化
	led_flasher led_fls(true_clk, start_flashing, led);
	
	always @(posedge true_clk) begin
	// 错误统计
		if (error_count == 2'b11) begin
			start_flashing <= 1;
		end else begin
		    start_flashing <= 0;
		end
	end
	
    // 模式选择和输出赋值的手动控制逻辑
    always @(posedge clr or posedge clk) begin
		if (clr) begin
			out1_reg <= 4'b0000;
            out2_reg <= 4'b0000;
            out3_reg <= 4'b0000;
            out4_reg <= 4'b0000;
            out5_reg <= 4'b0000;
            out6_reg <= 4'b0000;
		end
///////////////////////////////////////
			else begin
				if (hide) begin
					out1_reg <= 4'b1110;
					out2_reg <= 4'b1110;
					out3_reg <= 4'b1110;
					out4_reg <= 4'b1110;
					out5_reg <= 4'b1110;
					out6_reg <= 4'b1110;
				end
///////////////////////////////////////
        	case ({y2, y1, y0})
           		3'b001: {out1_reg, out2_reg} <= {checked_inA, checked_inB};
           		3'b010: {out3_reg, out4_reg} <= {checked_inA, checked_inB};
           		3'b100: {out5_reg, out6_reg} <= {checked_inA, checked_inB};
        	endcase

			if (y3) begin
				res_reg <= res_tmp;
			end
    	end
	end
endmodule
