module SixDigit_Electronic_Lock_Controller(
    input m,              // mode���л�ģʽ��0Ϊ�������룬1Ϊ��������
    input [3:0] inA, inB, // ����
    input clk, clr, true_clk,       // �ֶ�ʱ���źţ���գ��Զ�ʱ���ź�
    output [3:0] out1, out2, out3, out4, out5, out6, // ���
    output res,        // �ȽϽ��
    input a0, a1,            // �ߡ��С���λ�������ж�ѡ��
	output led,       // LED���
	input ps0,ps1,     // ������ѡ��
	output [3:0] s11,s12,s13,s14,s15,s16,    // debug�ã�����ɾ
	output [3:0] s21,s22,s23,s24,s25,s26,    // debug�ã�����ɾ
	output [3:0] s31,s32,s33,s34,s35,s36,    // debug�ã�����ɾ
	output [3:0] s41,s42,s43,s44,s45,s46,    // debug�ã�����ɾ
	output [3:0] c1,c2,c3,c4,c5,c6    // debug�ã�����ɾ
);

    // �ڲ��ź�
	wire [3:0] set1_out1, set1_out2, set1_out3, set1_out4, set1_out5, set1_out6;
    wire [3:0] set2_out1, set2_out2, set2_out3, set2_out4, set2_out5, set2_out6;
    wire [3:0] set3_out1, set3_out2, set3_out3, set3_out4, set3_out5, set3_out6;
    wire [3:0] set4_out1, set4_out2, set4_out3, set4_out4, set4_out5, set4_out6;
    wire [3:0] cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6;
    wire [3:0] in1, in2, in3, in4, in5, in6, checked_inA, checked_inB;
    wire y0, y1, y2, y3;      // ��λ���롢��λ���롢��λ���롢�ж�ѡ��
    wire p0, p1, p2, p3;	  // ����1������2������3������4
	wire res1,res2,res3,res4; // ÿ������ıȽϽ��
	wire [1:0] error_count;
	wire tick;
    reg [3:0] out1_reg, out2_reg, out3_reg, out4_reg, out5_reg, out6_reg;
	reg start_flashing;
	wire mode;				// ����������������mode
	
	assign mode = m & res;	// ������������ȷ��ֹ�л�ģʽ
	assign res = (res1|res2|res3|res4) & m;
	// �������ǽ���������ʾE(error)
	assign checked_inA = (inA > 4'b1001) ? 4'b1110 : inA;
	assign checked_inB = (inB > 4'b1001) ? 4'b1110 : inB;

    // �����ֵ
    assign out1 = out1_reg;
    assign out2 = out2_reg;
    assign out3 = out3_reg;
    assign out4 = out4_reg;
    assign out5 = out5_reg;
    assign out6 = out6_reg;

	// ����Ϊdebug�ã�����ɾ
	assign s11=set1_out1;
	assign s12=set1_out2;
	assign s13=set1_out3;
	assign s14=set1_out4;
	assign s15=set1_out5;
	assign s16=set1_out6;
	assign s21=set2_out1;
	assign s22=set2_out2;
	assign s23=set2_out3;
	assign s24=set2_out4;
	assign s25=set2_out5;
	assign s26=set2_out6;
	assign s31=set3_out1;
	assign s32=set3_out2;
	assign s33=set3_out3;
	assign s34=set3_out4;
	assign s35=set3_out5;
	assign s36=set3_out6;
	assign s41=set4_out1;
	assign s42=set4_out2;
	assign s43=set4_out3;
	assign s44=set4_out4;
	assign s45=set4_out5;
	assign s46=set4_out6;
	assign c1=cin_out1;
	assign c2=cin_out2;
	assign c3=cin_out3;
	assign c4=cin_out4;
	assign c5=cin_out5;
	assign c6=cin_out6;

    // ģʽѡ��24������ʵ����
    yima2to4 yima_mode(a0, a1, 0, y0, y1, y2, y3);

    // ������ѡ��24������ʵ����
    yima2to4 yima_passwd(ps0, ps1, 0, p0, p1, p2, p3);

    // ��������Ĵ���ʵ����
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

    // ��������Ĵ���ʵ����
	passwd_register cin_password(
        checked_inA, checked_inB, m & y0, m & y1, m & y2,
        cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6,
        clr & (m), clk
    );

    // �Ƚ�ģ��ʵ����
    judge jg1(y3, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set1_out1, set1_out2, set1_out3, set1_out4, set1_out5, set1_out6, res1);
	judge jg2(y3, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set2_out1, set2_out2, set2_out3, set2_out4, set2_out5, set2_out6, res2);
	judge jg3(y3, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set3_out1, set3_out2, set3_out3, set3_out4, set3_out5, set3_out6, res3);
	judge jg4(y3, cin_out1, cin_out2, cin_out3, cin_out4, cin_out5, cin_out6, set4_out1, set4_out2, set4_out3, set4_out4, set4_out5, set4_out6, res4);
	
	// ���������ģ��ʵ����
	error_counter error_cnt(y3, res, error_count);
	
	// ��ʱ��ģ��ʵ����
	timer tm(true_clk, tick);
	
	// LED��˸����״̬��ģ��ʵ����
	led_flasher led_fls(tick, start_flashing, led);	
	
    // ģʽѡ��������ֵ�Ŀ����߼�
    always @(posedge clk) begin
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
		
		// ��ֹ����״̬���л�ģʽ
		//if (!m & !res) begin
		//    out1_reg <= 4'b1110;
		//	out2_reg <= 4'b1110;
		//	out3_reg <= 4'b1110;
		//	out4_reg <= 4'b1110;
		//	out5_reg <= 4'b1110;
		//	out6_reg <= 4'b1110;
		//end
		
		// ����ͳ��
		if (error_count == 2'b11) begin
		    start_flashing <= 1;
		end else begin
			start_flashing <= 0;
		end
    end

endmodule
