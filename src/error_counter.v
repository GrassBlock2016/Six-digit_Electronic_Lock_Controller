// 错误计数器，记录错误次数
module error_counter(
    input clk,
    input correct,
    output reg [1:0] error_count
);
    always @(posedge clk) begin
        if (correct) begin
            error_count <= 2'b00;
        end else if (error_count < 2'b11) begin
            error_count <= error_count + 1;
        end
    end
endmodule
