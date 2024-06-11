module SixDigit_Electronic_Lock_Controller(
    input m,              // mode，切换模式，0为设置密码，1为输入密码
    input [3:0] inA, inB, // 输入
    input clk, clr, true_clk,       // 手动时钟信号，清空，自动时钟信号
    output [3:0] out1, out2, out3, out4, out5, out6, // 输出
    output res,        // 比较结果
    input a0, a1,            // 高、中、低位输入与判断选择
	output led,       // LED输出
	output [3:0] s1,s2,s3,s4,s5,s6,    // debug用，先勿删
	output [3:0] c1,c2,c3,c4,c5,c6    // debug用，先勿删
);

    // 内部信号
    wire [3:0] set_out1, set_out2, set_out3, set_out4, set_out5, set_out6;
    wire [3:0] cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6;
    wire [3:0] in1, in2, in3, in4, in5, in6, checked_inA, checked_inB;
    wire y0, y1, y2, y3;      // 高位输入、中位输入、低位输入、判断选择
	wire [1:0] error_count;
	wire tick;
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;
	reg start_flashing;
	wire mode;				// 引入错误检测修正后的mode
	
	assign mode = m & res;	// 如果检测结果不正确禁止切换模式

    // 输出赋值
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;

	// 以下为debug用，先勿删
	assign s1=set_out1;
	assign s2=set_out2;
	assign s3=set_out3;
	assign s4=set_out4;
	assign s5=set_out5;
	assign s6=set_out6;
	assign c1=cin_out1;
	assign c2=cin_out2;
	assign c3=cin_out3;
	assign c4=cin_out4;
	assign c5=cin_out5;
	assign c6=cin_out6;

    // 24译码器实例化
    yima2to4 yima(a0, a1, 0, y0, y1, y2, y3);

    // 设置密码寄存器实例化
    passwd_register set_password(
        inA, inB, !m & y0, !m & y1, !m & y2,
        set_out1, set_out2, set_out3, set_out4, set_out5, set_out6,
        clr & (~m), clk
    );

    // 输入密码寄存器实例化
	passwd_register cin_password(
        inA, inB, m & y0, m & y1, m & y2,
        cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6,
        clr & (m), clk
    );

    // 比较模块实例化
    judge jg(y3, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set_out1, set_out2, set_out3, set_out4, set_out5, set_out6, res);
	
	// 错误计数器模块实例化
	error_counter error_cnt(y3, res, error_count);
	
	// 定时器模块实例化
	timer tm(true_clk, tick);
	
	// LED闪烁控制状态机模块实例化
	led_flasher led_fls(tick, start_flashing, led);	
	
    // 模式选择和输出赋值的控制逻辑
    always @(posedge clk) begin
		// 如果输入非进制数则显示E(error)
		if (inA > 4'd9) begin
		    {checked_inA, checked_inB} <= 8'b1110_1110;
		end else if (inB > 4'd9) begin
			{checked_inA, checked_inB} <= 8'b1110_1110;
		end

        case ({y2, y1, y0})
            3'b001: {out1_reg, out2_reg} <= {checked_inA, checked_inB};
            3'b010: {out3_reg, out4_reg} <= {checked_inA, checked_inB};
            3'b100: {out5_reg, out6_reg} <= {checked_inA, checked_inB};
        endcase

		if (~(m) & clr) begin
			out1_reg <= 4'b0000;
            out2_reg <= 4'b0000;
            out3_reg <= 4'b0000;
            out4_reg <= 4'b0000;
            out5_reg <= 4'b0000;
            out6_reg <= 4'b0000;
		end
		
		// 禁止错误状态下切换模式
		if (m & !res) begin
		    out1_reg <= 4'b1110;
			out2_reg <= 4'b1110;
			out3_reg <= 4'b1110;
			out4_reg <= 4'b1110;
			out5_reg <= 4'b1110;
			out6_reg <= 4'b1110;
		end
		
		// 错误统计
		if (error_count == 2'b11) begin
		    start_flashing <= 1;
		end else begin
			start_flashing <= 0;
		end
    end

endmodule
