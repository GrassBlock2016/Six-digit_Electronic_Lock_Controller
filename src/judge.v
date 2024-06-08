// s用于开启判断，a1-6和b1-6分别是输入的密码和已存的密码，c是判断结果（密码正确返回1）
module judge(
    input s,
    input [3:0] a1, a2, a3, a4, a5, a6,
    input [3:0] b1, b2, b3, b4, b5, b6,
    output reg c
);

    always @(s) begin
        if (s) begin
            if (a1 == b1 && a2 == b2 && a3 == b3 && a4 == b4 && a5 == b5 && a6 == b6) begin
                c = 1'b1;
            end else begin
                c = 1'b0;
            end
        end else begin
            c = 1'b0;
        end
    end

endmodule
