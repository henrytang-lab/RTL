`timescale 1 ps / 1 ps

module mipidphy2cmos
(
	input			reset_n_i,
	inout 			rx_clk_p_i,
	inout 			rx_clk_n_i,
	inout 			rx_d0_p_i,
	inout 			rx_d0_n_i,
	inout 			rx_d1_p_i,
	inout 			rx_d1_n_i,
	output [15:0]	pd0_o,
	output 			fv_o,
	output 			lv_o,
	output 			rx_clk_byte_fr_o,
	input 			clk_pixel_i,
	input 			pll_lock_i,
	
	output rx_payload_en,
	output [15:0] tp_data
);

assign tp_data = 32'h00800080;
//-----------------------------------------------------------------------------
//	Parameters Declarations
//-----------------------------------------------------------------------------
parameter RX_LANE_COUNT = 2;
parameter RX_PD_BUS_WIDTH = 8;	
parameter TX_PD_BUS_WIDTH = 24;
parameter RX_GEAR = 8;	// DPHY Rx Clock Gear
parameter RX_CLK_MODE = "HS_ONLY";
parameter NUM_TX_CH = 2;
parameter TX_GEAR = 14;// DPHY Tx Clock Gear

//-----------------------------------------------------------------------------
//	Wire and Register declarations
//-----------------------------------------------------------------------------
wire [5:0] ref_dt = 6'h1E;

wire rx_clk_byte_fr , rx_clk_byte_hs, rx_clk_lp_ctrl, rx_reset_lp_n;
wire clk_pixel_pll ;
reg rx_reset_byte_fr_n_meta, rx_reset_byte_fr_n_sync;

wire rx_sp_en, rx_lp_en, rx_lp_av_en;
wire [RX_LANE_COUNT*RX_GEAR-1:0]	rx_payload;
wire [5:0]	rx_dt;
wire [15:0]	rx_wc;
wire clk_pixel;

wire [RX_PD_BUS_WIDTH*NUM_TX_CH*TX_GEAR/7-1:0]	pd;

wire [TX_PD_BUS_WIDTH-1:0] tx0_pix_data;
wire [TX_PD_BUS_WIDTH-1:0] tx1_pix_data;
wire [TX_PD_BUS_WIDTH-1:0] tx2_pix_data;
wire [TX_PD_BUS_WIDTH-1:0] tx3_pix_data;

wire int_rst_n;
wire [7:0]	sr_delay;
wire [1:0]	bayer_pattern;
wire [7:0]	hfp, hs_length;
wire [5:0]	vfp, vs_length;
wire [5:0]	left_trim;
wire [11:0]	h_tx_pel;
wire [5:0]	top_trim;
wire [11:0]	v_tx_line;

wire	tx_vsync, tx_hsync, tx_de;
wire	tx_vsync_pol, tx_hsync_pol, tx_de_pol;

wire pll_eclk;
wire tx_eclk = pll_eclk;

///// Debug signals /////
wire rx_hs_d_en, rx_hs_sync, rx_term_clk_en;
wire [1:0] rx_lp_hs_state_clk, rx_lp_hs_state_d;
wire [1:0] p_odd, read_cycle;
wire [3:0] write_cycle;
wire mem_we, mem_re;
wire [2:0] mem_radr;


wire refclk;


assign rx_clk_byte_fr = rx_clk_byte_hs;
assign rx_clk_lp_ctrl = 1'b1;
assign rx_reset_lp_n = 1'b1;

reg reset_pixel_n_meta, reset_pixel_n_sync;

//	Reset Bridge for clk_pixel_pll clock
assign int_rst_n = reset_n_i;
always @(/*posedge clk_pixel_pll or negedge */int_rst_n) begin
	if (~int_rst_n) begin
		reset_pixel_n_meta <= 0;
		reset_pixel_n_sync <= 0;
	end
	else begin
		reset_pixel_n_meta <= int_rst_n;
		reset_pixel_n_sync <= reset_pixel_n_meta;
	end
end


/*synthesis translate_off*/
GSR GSR_INST (1'b1);
/*synthesis translate_on*/

assign rx_clk_byte_fr_o = rx_clk_byte_fr;
assign clk_pixel_pll = clk_pixel_i;

//	Reset Bridge for rx_clk_byte_fr clock
always @(posedge rx_clk_byte_fr or negedge int_rst_n) begin
	if (~int_rst_n) begin
		rx_reset_byte_fr_n_meta <= 0;
		rx_reset_byte_fr_n_sync <= 0;
	end
	else begin
		rx_reset_byte_fr_n_meta <= int_rst_n;
		rx_reset_byte_fr_n_sync <= rx_reset_byte_fr_n_meta;
	end
end

/////////////////////////////////////////////////////////////////////////////
///// RX D-PHY module instantiation                                     /////
///// Customer has to recreate a Soft-IP for own configuration settings /////
/////////////////////////////////////////////////////////////////////////////


csi_dphy_rx rx_dphy
(
// Inouts
	.clk_p_i			(rx_clk_p_i),
	.clk_n_i			(rx_clk_n_i),
	.d0_p_i				(rx_d0_p_i),
	.d0_n_i				(rx_d0_n_i),
	.d1_p_i				(rx_d1_p_i),
	.d1_n_i				(rx_d1_n_i),
// Inputs
	.pd_dphy_i			(~reset_n_i),
	.clk_byte_fr_i		(rx_clk_byte_fr),
	.clk_lp_ctrl_i		(rx_clk_lp_ctrl),
	.reset_byte_fr_n_i	(rx_reset_byte_fr_n_sync),
	.reset_byte_n_i		(rx_reset_byte_fr_n_sync),
	.reset_lp_n_i		(rx_reset_lp_n),
	.reset_n_i			(int_rst_n),
	.pll_lock_i			(1'b1),
// Outputs
	.clk_byte_o			(rx_clk_byte),
	.clk_byte_hs_o		(rx_clk_byte_hs),
	.cd_d0_o			(),
	.lp_d0_rx_p_o		(),
	.lp_d0_rx_n_o		(),
	.lp_d1_rx_p_o		(),
	.lp_d1_rx_n_o		(),
	.ref_dt_i			(ref_dt),
	.sp_en_o			(rx_sp_en),
	.lp_en_o			(rx_lp_en),
	.lp_av_en_o			(rx_lp_av_en),
	.vc_o				(),
	.dt_o				(rx_dt),
	.wc_o				(rx_wc),
	.ecc_o				(),
	.bd_o				(),
	.payload_o			(rx_payload),
	.payload_en_o		(rx_payload_en),
///// debug signals
	.hs_d_en_o				(rx_hs_d_en),
	.hs_sync_o				(rx_hs_sync),
	.term_clk_en_o			(rx_term_clk_en),
	.lp_hs_state_clk_o		(rx_lp_hs_state_clk),
	.lp_hs_state_d_o		(rx_lp_hs_state_d)
);

/////////////////////////////////////////////////////////////////////////////////////
///// Byte2Pixel module instantiation                                   		/////
///// Customer has to recreate a Soft-IP for their own configuration settings	/////
/////////////////////////////////////////////////////////////////////////////////////
byte2pix byte_pixel (
	.clk_byte_i			(rx_clk_byte_fr),
	.reset_byte_n_i		(rx_reset_byte_fr_n_sync),
	.clk_pixel_i		(clk_pixel_pll),
	.reset_pixel_n_i	(reset_pixel_n_sync),
	.sp_en_i			(rx_sp_en),
	.lp_av_en_i			(rx_lp_av_en),
	.dt_i				(rx_dt),
	.wc_i				(rx_wc),
	.payload_i			(rx_payload),
	.payload_en_i		(rx_payload_en),
	.fv_o				(fv_o),
	.lv_o				(lv_o),
	.pd_o				(pd0_o),
	.p_odd_o			(p_odd)
);
endmodule 