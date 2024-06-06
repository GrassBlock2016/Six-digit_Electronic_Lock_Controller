module SixDigit_Electronic_Lock_Controller(
    input j,              // judge�������ж�
    input m,              // mode���л�ģʽ��0Ϊ�������룬1Ϊ��������
    input [3:0] in1, in2, in3, in4, in5, in6, // ����
    input clk, clr,       // ʱ���ź�
    output [3:0] out1, out2, out3, out4, out5, out6, // ���
    output reg res,        // �ȽϽ��
    input a0,a1            // �ߡ��С���λ�������ж�ѡ��
);

    // �ڲ��ź�
    wire [3:0] passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6;
	wire [3:0] reset_out1, reset_out2, reset_out3, reset_out4, reset_out5, reset_out6;
	wire y0,y1,y2,y3;      // ��λ���롢��λ���롢��λ���롢�ж�ѡ��
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;
    reg judge_enable;

    // �����ֵ
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;
    
    // 24������ʵ����
	yima2to4 yima(a0,a1,1,y0,y1,y2,y3);

    // ��������Ĵ���ʵ����
    passwd_register set_password(in1,in2,!m&y0,!m&y1,!m&y2,passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,clr,clk);

    // ��������Ĵ���ʵ����
    // passwd_register cin_password(in1,in2,m&y0,m&y1,m&y2,passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,clr,clk);

    // �Ƚ�ģ��ʵ����
    judge judge_1(j,in1,in2,in3,in4,in5,in6,passwd_out1, passwd_out2, passwd_out3, passwd_out4, passwd_out5, passwd_out6,res);

    // ģʽѡ��������ֵ�Ŀ����߼�
    always @(posedge clk or posedge clr) begin
        if (clr) begin
            out1_reg <= reset_out1;
            out2_reg <= reset_out2;
            out3_reg <= reset_out3;
            out4_reg <= reset_out4;
            out5_reg <= reset_out5;
            out6_reg <= reset_out6;
        end else begin
            if (m == 0) begin
                // ģʽ0����������
                out1_reg <= in1;
                out2_reg <= in2;
                out3_reg <= in3;
                out4_reg <= in4;
                out5_reg <= in5;
                out6_reg <= in6;
            end else begin
                // ģʽ1���������벢�����ж�
                judge_enable <= j;
                out1_reg <= passwd_out1;
                out2_reg <= passwd_out2;
                out3_reg <= passwd_out3;
                out4_reg <= passwd_out4;
                out5_reg <= passwd_out5;
                out6_reg <= passwd_out6;
            end
        end
    end

endmodule
