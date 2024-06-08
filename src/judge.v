// s���ڿ����жϣ�a1-6��b1-6�ֱ��������������Ѵ�����룬c���жϽ����������ȷ����1��
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
