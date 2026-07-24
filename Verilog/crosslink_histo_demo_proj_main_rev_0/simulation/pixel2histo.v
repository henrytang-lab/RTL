module pixel2histo (
    input wire clk,
    input wire reset,
    input wire write_i,
    input wire [9:0] pixel,
    input wire [31:0] data_i,
    output wire [31:0] data_o
);

	ram_dq_ip ram_inst (
		.Clock(clk),
		.ClockEn(~reset), 
		.Reset(reset),
		.WE(write_i),
		.Address(pixel), 
		.Data(data_i), 
        .Q(data_o)             
	);

endmodule