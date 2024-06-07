module SixDigit_Electronic_Lock_Controller(
    input m,              // mode���л�ģʽ��0Ϊ�������룬1Ϊ��������
    input [3:0] inA, inB, // ����
    input clk, clr,       // ʱ���ź�
    output [3:0] out1, out2, out3, out4, out5, out6, // ���
    output reg res,        // �ȽϽ��
    input a0, a1            // �ߡ��С���λ�������ж�ѡ��
);

    // �ڲ��ź�
    wire [3:0] passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6;
    wire [3:0] in1, in2, in3, in4, in5, in6;
    wire y0, y1, y2, y3;      // ��λ���롢��λ���롢��λ���롢�ж�ѡ��
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;

    // �����ֵ
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;

    // 24������ʵ����
    yima2to4 yima(a0, a1, 1, y0, y1, y2, y3);

    // ��������Ĵ���ʵ����
    passwd_register set_password(
        in1, in2, !m & y0, !m & y1, !m & y2,
        passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,
        clr & (~m), clk
    );

    // ��������Ĵ���ʵ����
	//passwd_register cin_password(
    //    in1, in2, m & y0, m & y1, m & y2,
    //    passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,
    //    clr & (m), clk
    //);

    // �Ƚ�ģ��ʵ����
    judge judge_1(y3, in1, in2, in3, in4, in5, in6, passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6, res);

    // ģʽѡ��������ֵ�Ŀ����߼�
    always @(posedge clk) begin
        case ({y2, y1, y0})
            3'b001: {in1, in2} <= {inA, inB};
            3'b010: {in3, in4} <= {inA, inB};
            3'b100: {in5, in6} <= {inA, inB};
        endcase

        if (m == 0) begin
            // ģʽ0����������
            out1_reg <= in1;
            out2_reg <= in2;
            out3_reg <= in3;
            out4_reg <= in4;
            out5_reg <= in5;
            out6_reg <= in6;
            // ������ź�clr����ʱ�������Ĵ���
            if (clr) begin
                out1_reg <= 4'b0000;
                out2_reg <= 4'b0000;
                out3_reg <= 4'b0000;
                out4_reg <= 4'b0000;
                out5_reg <= 4'b0000;
                out6_reg <= 4'b0000;
            end
        end else begin
            // ģʽ1���������벢�����ж�
            out1_reg <= passwd_out1;
            out2_reg <= passwd_out2;
            out3_reg <= passwd_out3;
            out4_reg <= passwd_out4;
            out5_reg <= passwd_out5;
            out6_reg <= passwd_out6;
        end
    end

endmodule
