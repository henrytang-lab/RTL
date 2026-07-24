/* synthesis translate_off*/
`define SBP_SIMULATION
/* synthesis translate_on*/
`ifndef SBP_SIMULATION
`define SBP_SYNTHESIS
`endif

//
// Verific Verilog Description of module ip
//
module ip (byte2pix_dt_i, byte2pix_p_odd_o, byte2pix_payload_i, byte2pix_pd_o, 
           byte2pix_wc_i, csi_dphy_rx_bd_o, csi_dphy_rx_dt_o, csi_dphy_rx_ecc_o, 
           csi_dphy_rx_lp_hs_state_clk_o, csi_dphy_rx_lp_hs_state_d_o, csi_dphy_rx_payload_o, 
           csi_dphy_rx_ref_dt_i, csi_dphy_rx_vc_o, csi_dphy_rx_wc_o, ram_dq_ip_Address, 
           ram_dq_ip_Data, ram_dq_ip_Q, byte2pix_clk_byte_i, byte2pix_clk_pixel_i, 
           byte2pix_fv_o, byte2pix_lp_av_en_i, byte2pix_lv_o, byte2pix_payload_en_i, 
           byte2pix_reset_byte_n_i, byte2pix_reset_pixel_n_i, byte2pix_sp_en_i, 
           csi_dphy_rx_cd_d0_o, csi_dphy_rx_clk_byte_fr_i, csi_dphy_rx_clk_byte_hs_o, 
           csi_dphy_rx_clk_byte_o, csi_dphy_rx_clk_lp_ctrl_i, csi_dphy_rx_clk_n_i, 
           csi_dphy_rx_clk_p_i, csi_dphy_rx_d0_n_i, csi_dphy_rx_d0_p_i, 
           csi_dphy_rx_d1_n_i, csi_dphy_rx_d1_p_i, csi_dphy_rx_hs_d_en_o, 
           csi_dphy_rx_hs_sync_o, csi_dphy_rx_lp_av_en_o, csi_dphy_rx_lp_d0_rx_n_o, 
           csi_dphy_rx_lp_d0_rx_p_o, csi_dphy_rx_lp_d1_rx_n_o, csi_dphy_rx_lp_d1_rx_p_o, 
           csi_dphy_rx_lp_en_o, csi_dphy_rx_payload_en_o, csi_dphy_rx_pd_dphy_i, 
           csi_dphy_rx_pll_lock_i, csi_dphy_rx_reset_byte_fr_n_i, csi_dphy_rx_reset_byte_n_i, 
           csi_dphy_rx_reset_lp_n_i, csi_dphy_rx_reset_n_i, csi_dphy_rx_sp_en_o, 
           csi_dphy_rx_term_clk_en_o, pll_ip_CLKI, pll_ip_CLKOP, pll_ip_CLKOS, 
           pll_ip_LOCK, ram_dq_ip_Clock, ram_dq_ip_ClockEn, ram_dq_ip_Reset, 
           ram_dq_ip_WE) /* synthesis sbp_module=true */ ;
    input [5:0]byte2pix_dt_i;
    output [1:0]byte2pix_p_odd_o;
    input [15:0]byte2pix_payload_i;
    output [15:0]byte2pix_pd_o;
    input [15:0]byte2pix_wc_i;
    output [15:0]csi_dphy_rx_bd_o;
    output [5:0]csi_dphy_rx_dt_o;
    output [7:0]csi_dphy_rx_ecc_o;
    output [1:0]csi_dphy_rx_lp_hs_state_clk_o;
    output [1:0]csi_dphy_rx_lp_hs_state_d_o;
    output [15:0]csi_dphy_rx_payload_o;
    input [5:0]csi_dphy_rx_ref_dt_i;
    output [1:0]csi_dphy_rx_vc_o;
    output [15:0]csi_dphy_rx_wc_o;
    input [9:0]ram_dq_ip_Address;
    input [31:0]ram_dq_ip_Data;
    output [31:0]ram_dq_ip_Q;
    input byte2pix_clk_byte_i;
    input byte2pix_clk_pixel_i;
    output byte2pix_fv_o;
    input byte2pix_lp_av_en_i;
    output byte2pix_lv_o;
    input byte2pix_payload_en_i;
    input byte2pix_reset_byte_n_i;
    input byte2pix_reset_pixel_n_i;
    input byte2pix_sp_en_i;
    output csi_dphy_rx_cd_d0_o;
    input csi_dphy_rx_clk_byte_fr_i;
    output csi_dphy_rx_clk_byte_hs_o;
    output csi_dphy_rx_clk_byte_o;
    input csi_dphy_rx_clk_lp_ctrl_i;
    inout csi_dphy_rx_clk_n_i;
    inout csi_dphy_rx_clk_p_i;
    inout csi_dphy_rx_d0_n_i;
    inout csi_dphy_rx_d0_p_i;
    inout csi_dphy_rx_d1_n_i;
    inout csi_dphy_rx_d1_p_i;
    output csi_dphy_rx_hs_d_en_o;
    output csi_dphy_rx_hs_sync_o;
    output csi_dphy_rx_lp_av_en_o;
    output csi_dphy_rx_lp_d0_rx_n_o;
    output csi_dphy_rx_lp_d0_rx_p_o;
    output csi_dphy_rx_lp_d1_rx_n_o;
    output csi_dphy_rx_lp_d1_rx_p_o;
    output csi_dphy_rx_lp_en_o;
    output csi_dphy_rx_payload_en_o;
    input csi_dphy_rx_pd_dphy_i;
    input csi_dphy_rx_pll_lock_i;
    input csi_dphy_rx_reset_byte_fr_n_i;
    input csi_dphy_rx_reset_byte_n_i;
    input csi_dphy_rx_reset_lp_n_i;
    input csi_dphy_rx_reset_n_i;
    output csi_dphy_rx_sp_en_o;
    output csi_dphy_rx_term_clk_en_o;
    input pll_ip_CLKI;
    output pll_ip_CLKOP;
    output pll_ip_CLKOS;
    output pll_ip_LOCK;
    input ram_dq_ip_Clock;
    input ram_dq_ip_ClockEn;
    input ram_dq_ip_Reset;
    input ram_dq_ip_WE;
    
    
    byte2pix byte2pix_inst (.dt_i({byte2pix_dt_i}), .p_odd_o({byte2pix_p_odd_o}), 
            .payload_i({byte2pix_payload_i}), .pd_o({byte2pix_pd_o}), .wc_i({byte2pix_wc_i}), 
            .clk_byte_i(byte2pix_clk_byte_i), .clk_pixel_i(byte2pix_clk_pixel_i), 
            .fv_o(byte2pix_fv_o), .lp_av_en_i(byte2pix_lp_av_en_i), .lv_o(byte2pix_lv_o), 
            .payload_en_i(byte2pix_payload_en_i), .reset_byte_n_i(byte2pix_reset_byte_n_i), 
            .reset_pixel_n_i(byte2pix_reset_pixel_n_i), .sp_en_i(byte2pix_sp_en_i));
    csi_dphy_rx csi_dphy_rx_inst (.bd_o({csi_dphy_rx_bd_o}), .dt_o({csi_dphy_rx_dt_o}), 
            .ecc_o({csi_dphy_rx_ecc_o}), .lp_hs_state_clk_o({csi_dphy_rx_lp_hs_state_clk_o}), 
            .lp_hs_state_d_o({csi_dphy_rx_lp_hs_state_d_o}), .payload_o({csi_dphy_rx_payload_o}), 
            .ref_dt_i({csi_dphy_rx_ref_dt_i}), .vc_o({csi_dphy_rx_vc_o}), 
            .wc_o({csi_dphy_rx_wc_o}), .cd_d0_o(csi_dphy_rx_cd_d0_o), .clk_byte_fr_i(csi_dphy_rx_clk_byte_fr_i), 
            .clk_byte_hs_o(csi_dphy_rx_clk_byte_hs_o), .clk_byte_o(csi_dphy_rx_clk_byte_o), 
            .clk_lp_ctrl_i(csi_dphy_rx_clk_lp_ctrl_i), .clk_n_i(csi_dphy_rx_clk_n_i), 
            .clk_p_i(csi_dphy_rx_clk_p_i), .d0_n_i(csi_dphy_rx_d0_n_i), 
            .d0_p_i(csi_dphy_rx_d0_p_i), .d1_n_i(csi_dphy_rx_d1_n_i), .d1_p_i(csi_dphy_rx_d1_p_i), 
            .hs_d_en_o(csi_dphy_rx_hs_d_en_o), .hs_sync_o(csi_dphy_rx_hs_sync_o), 
            .lp_av_en_o(csi_dphy_rx_lp_av_en_o), .lp_d0_rx_n_o(csi_dphy_rx_lp_d0_rx_n_o), 
            .lp_d0_rx_p_o(csi_dphy_rx_lp_d0_rx_p_o), .lp_d1_rx_n_o(csi_dphy_rx_lp_d1_rx_n_o), 
            .lp_d1_rx_p_o(csi_dphy_rx_lp_d1_rx_p_o), .lp_en_o(csi_dphy_rx_lp_en_o), 
            .payload_en_o(csi_dphy_rx_payload_en_o), .pd_dphy_i(csi_dphy_rx_pd_dphy_i), 
            .pll_lock_i(csi_dphy_rx_pll_lock_i), .reset_byte_fr_n_i(csi_dphy_rx_reset_byte_fr_n_i), 
            .reset_byte_n_i(csi_dphy_rx_reset_byte_n_i), .reset_lp_n_i(csi_dphy_rx_reset_lp_n_i), 
            .reset_n_i(csi_dphy_rx_reset_n_i), .sp_en_o(csi_dphy_rx_sp_en_o), 
            .term_clk_en_o(csi_dphy_rx_term_clk_en_o));
    pll_ip pll_ip_inst (.CLKI(pll_ip_CLKI), .CLKOP(pll_ip_CLKOP), .CLKOS(pll_ip_CLKOS), 
           .LOCK(pll_ip_LOCK));
    ram_dq_ip ram_dq_ip_inst (.Address({ram_dq_ip_Address}), .Data({ram_dq_ip_Data}), 
            .Q({ram_dq_ip_Q}), .Clock(ram_dq_ip_Clock), .ClockEn(ram_dq_ip_ClockEn), 
            .Reset(ram_dq_ip_Reset), .WE(ram_dq_ip_WE));
    
endmodule

