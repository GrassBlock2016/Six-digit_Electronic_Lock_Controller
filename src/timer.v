// 定时器，生成闪烁的时间基准
module timer(
    input clk,			// 输入时钟信号
    output reg tick		// 输出放缓后的时钟信号用于灯的闪烁
);
    reg [23:0] count;	// 这边会有2的24次方，相当于用这个倍数来放缓时钟信号的时间
    always @(posedge clk) begin
        count <= count + 1;
        tick <= (count == 0);
    end
endmodule
