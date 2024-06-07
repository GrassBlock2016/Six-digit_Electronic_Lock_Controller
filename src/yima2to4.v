// 24ÒëÂëÆ÷
module yima2to4(A0, A1, EN, Y0, Y1, Y2, Y3);
	input A0, A1, EN;
	output reg Y0, Y1, Y2, Y3;
	
	always @(*) begin
		if (EN) begin
			{Y3, Y2, Y1, Y0} = 4'b0000;
		end else begin
			case({A0, A1})
				2'b00: {Y3, Y2, Y1, Y0} = 4'b0001;
				2'b01: {Y3, Y2, Y1, Y0} = 4'b0010;
				2'b10: {Y3, Y2, Y1, Y0} = 4'b0100;
				2'b11: {Y3, Y2, Y1, Y0} = 4'b1000;
				default: {Y3, Y2, Y1, Y0} = 4'b0000;
			endcase
		end
	end
	
endmodule