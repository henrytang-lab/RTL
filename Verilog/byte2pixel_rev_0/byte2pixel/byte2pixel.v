/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module byte2pixel
//
module byte2pixel (byte2pixel_rev_1_dt_i, byte2pixel_rev_1_p_odd_o, byte2pixel_rev_1_payload_i, 
            byte2pixel_rev_1_pd_o, byte2pixel_rev_1_wc_i, byte2pixel_rev_1_clk_byte_i, 
            byte2pixel_rev_1_clk_pixel_i, byte2pixel_rev_1_fv_o, byte2pixel_rev_1_lp_av_en_i, 
            byte2pixel_rev_1_lv_o, byte2pixel_rev_1_payload_en_i, byte2pixel_rev_1_reset_byte_n_i, 
            byte2pixel_rev_1_reset_pixel_n_i, byte2pixel_rev_1_sp_en_i) /* synthesis sbp_module=true */ ;
    input [5:0]byte2pixel_rev_1_dt_i;
    output [1:0]byte2pixel_rev_1_p_odd_o;
    input [15:0]byte2pixel_rev_1_payload_i;
    output [7:0]byte2pixel_rev_1_pd_o;
    input [15:0]byte2pixel_rev_1_wc_i;
    input byte2pixel_rev_1_clk_byte_i;
    input byte2pixel_rev_1_clk_pixel_i;
    output byte2pixel_rev_1_fv_o;
    input byte2pixel_rev_1_lp_av_en_i;
    output byte2pixel_rev_1_lv_o;
    input byte2pixel_rev_1_payload_en_i;
    input byte2pixel_rev_1_reset_byte_n_i;
    input byte2pixel_rev_1_reset_pixel_n_i;
    input byte2pixel_rev_1_sp_en_i;
    
    
    byte2pixel_rev_1 byte2pixel_rev_1_inst (.dt_i({byte2pixel_rev_1_dt_i}), 
            .p_odd_o({byte2pixel_rev_1_p_odd_o}), .payload_i({byte2pixel_rev_1_payload_i}), 
            .pd_o({byte2pixel_rev_1_pd_o}), .wc_i({byte2pixel_rev_1_wc_i}), 
            .clk_byte_i(byte2pixel_rev_1_clk_byte_i), .clk_pixel_i(byte2pixel_rev_1_clk_pixel_i), 
            .fv_o(byte2pixel_rev_1_fv_o), .lp_av_en_i(byte2pixel_rev_1_lp_av_en_i), 
            .lv_o(byte2pixel_rev_1_lv_o), .payload_en_i(byte2pixel_rev_1_payload_en_i), 
            .reset_byte_n_i(byte2pixel_rev_1_reset_byte_n_i), .reset_pixel_n_i(byte2pixel_rev_1_reset_pixel_n_i), 
            .sp_en_i(byte2pixel_rev_1_sp_en_i));
    
endmodule

