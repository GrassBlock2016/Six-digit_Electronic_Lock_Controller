// 控制灯的闪烁
module led_flasher (
    input wire clk,       		// 时钟信号，1Hz
    input wire switch,    		// 开关信号
    output reg led,        		// LED输出
	output reg flash_end_flag 	// 闪烁结束的信号
);
    reg [3:0] second_count;  // 计时寄存器，计数10秒
    reg blinking;            // 标志寄存器，指示是否正在闪烁

    always @(posedge clk) begin
        if (switch) begin
            if (!blinking) begin
                // 开关被按下，初始化计数器和标志
                blinking <= 1;
                second_count <= 0;
            end else if (second_count < 10) begin
                // 计时进行中，LED闪烁
                second_count <= second_count + 1;
                led <= ~led;
            end else begin
                // 计时结束，停止闪烁
                blinking <= 0;
                led <= 0;
				flash_end_flag <= 1'b1;
            end
        end else begin
            // 开关未被按下，重置所有状态
            blinking <= 0;
            second_count <= 0;
            led <= 0;
        end
    end
endmodule
