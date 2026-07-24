`timescale 1 ps / 1 ps

module topmod
(
	input			reset_n_i,

	// Camera MIPI input
	inout 			rx_clk_p_i,
	inout 			rx_clk_n_i,
	inout 			rx_d0_p_i,
	inout 			rx_d0_n_i,
	inout 			rx_d1_p_i,
	inout 			rx_d1_n_i,
	
	output			pclk_o,
	output			cmos_fv,
	output			cmos_lv,	
	output			[15:0] cmos_data
);


//-----------------------------------------------------------------------------
//	Local parameter declarations
//-----------------------------------------------------------------------------

//	The Bus width of the data in sync_img_size module instansiated
localparam IMG_SZ_BUS_WDT = 'd32;

// Internal Oscillator
// 1 -> 48MHz, 2 -> 24MHz, 4 -> 12MHz, 8 -> 6MHz
// Possible Values: 1, 2, 4 and 8.
localparam INT_OSC_CLK_DIVIDER = 4'd1;

// Internal Oscillator Clock Value
localparam INT_OSC_CLK_VALUE = ( 32'd48_000_000 / INT_OSC_CLK_DIVIDER );

// PCLK Value
// It must be changed when PLL configuration is changed.
localparam PCLK_VALUE = 32'd84_000_000;

//-----------------------------------------------------------------------------
//	Wire and Register declarations
//-----------------------------------------------------------------------------

wire clk_osc;  // Oscillator clock
wire clk_pixel;  // Pixel clock
wire clk_pixel1;
wire pll_lock;
wire reset_n_HFCLKOUT;

wire rx_clk_byte_fr;
wire cam_app_en;
wire cam_app_en_osc;

assign pclk_o = clk_osc;

// Internal Oscillator
// 1 -> 48MHz, 2 -> 24MHz, 4 -> 12MHz, 8 -> 6MHz
defparam int_osc.HFCLKDIV = INT_OSC_CLK_DIVIDER;
OSCI int_osc
(
	.HFOUTEN	(1'b1),
	.HFCLKOUT	(clk_osc),
	.LFCLKOUT	()
);

//	PLL Instance for 720p and 1080p resolution.
pll_ip pll_inst (
	.CLKI	( rx_clk_byte_fr /* clk_osc*/ ),
	.CLKOP	(clk_pixel1),    // 84 MHz
	.CLKOS	(clk_pixel),  // 84 MHz
	.LOCK	(pll_lock)
);

//	Reset Bridge for clk_osc
reset_bridge rst_brg_osc(
  .clk_i			(clk_osc),// Destination clock
  .ext_resetn_i		( reset_n_i ),// Asynchronous reset signal
  .sync_resetn_out	(reset_n_HFCLKOUT)// Synchronized reset signal
);

reset_manager 
#
(
	.REF_CLOCK_VALUE_I              ( INT_OSC_CLK_VALUE ),
	.MIPI_IP_RESET_LOW_TIME_IN_MS_I ( 32'd300 )
)
rm
(
	.clk                      ( clk_osc ),
	.reset_n                  ( reset_n_HFCLKOUT ),
	.cam_app_en_i             ( cam_app_en_osc ),
	.mipi_reset_n_o           ( mipi_reset_n_o ),
	.reset_counter_is_low_o   ( reset_counter_is_low_o ),
	.reset_counter_is_high_o  ( reset_counter_is_high_o )
);

//	MIPI DPHY to CMOS module : It converts the MIPI camera input to Parallel video data at clock "clk_pixel"
 mipidphy2cmos mipidphy2cmos
 (
 	.reset_n_i			(mipi_reset_n_o), // Changed to test 1080p resolution
 	.rx_clk_p_i			(rx_clk_p_i),
 	.rx_clk_n_i			(rx_clk_n_i),
 	.rx_d0_p_i			(rx_d0_p_i),
 	.rx_d0_n_i			(rx_d0_n_i),
 	.rx_d1_p_i			(rx_d1_p_i),
 	.rx_d1_n_i			(rx_d1_n_i),
 	.pd0_o				(cmos_data),
 	.fv_o				(cmos_fv),
 	.lv_o				(cmos_lv),
 	.rx_clk_byte_fr_o	(rx_clk_byte_fr),
 	.clk_pixel_i		(clk_pixel1),
 	.pll_lock_i			(pll_lock)
 );
 
 
 
endmodule