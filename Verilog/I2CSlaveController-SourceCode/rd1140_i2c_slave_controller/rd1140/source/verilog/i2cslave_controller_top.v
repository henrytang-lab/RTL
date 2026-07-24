//   ==================================================================
//   >>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
//   ------------------------------------------------------------------
//   Copyright (c) 2014 by Lattice Semiconductor Corporation
//   ALL RIGHTS RESERVED 
//   ------------------------------------------------------------------
//
//   Permission:
//
//      Lattice SG Pte. Ltd. grants permission to use this code
//      pursuant to the terms of the Lattice Reference Design License Agreement. 
//
//
//   Disclaimer:
//
//      This VHDL or Verilog source code is intended as a design reference
//      which illustrates how these types of functions can be implemented.
//      It is the user's responsibility to verify their design for
//      consistency and functionality through the use of formal
//      verification methods.  Lattice provides no warranty
//      regarding the use or functionality of this code.
//
//   --------------------------------------------------------------------
//
//                  Lattice SG Pte. Ltd.
//                  101 Thomson Road, United Square #07-02 
//                  Singapore 307591
//
//
//                  TEL: 1-800-Lattice (USA and Canada)
//                       +65-6631-2000 (Singapore)
//                       +1-503-268-8001 (other locations)
//
//                  web: http://www.latticesemi.com/
//                  email: techsupport@latticesemi.com
//
//   --------------------------------------------------------------------
module i2cslave_controller_top (
                                    i_rst,
									
		                    i_scl,
                                    o_scl,
		                    i_sda,
		                    o_sda,
		                    i_data,
		                    o_data,
                                    i_slave_addr,
                                    i_addr_10bit_en,
                                    i_sclk_stretch_en,
                                    i_hs_mode,
                                    i_sys_clk,
                                    i_timeout_en,
                                    i_timeout_val,
                                    i_ack_busy,
                                    i_init_intr_en,
                                    i_rw_done_intr_en,
                                    i_timeout_intr_en,
                                    o_intr,
                                    o_rx_status,
                                    o_tx_status,
                                    o_data_valid,
                                    o_data_request,
                                    o_i2cs_busy,
                                    o_init_done,
                                    o_rd_done,
                                    o_wr_done,
                                    o_timeout_err,
                                    o_sda_tri_en,
                                    o_scl_tri_en,
		                    o_init_intr,
		                    o_rw_intr,
		                    o_timeout_intr
		                    );


   /*********************************************************************************
    * Input Ports
    *********************************************************************************/
    input        i_rst;
    input        i_scl;
    input        i_sda;
    input  [7:0] i_data;
    input  [9:0] i_slave_addr;
    input        i_addr_10bit_en;
    input        i_sclk_stretch_en;
    input        i_hs_mode;
    input        i_sys_clk;
    input        i_timeout_en;
    input [15:0] i_timeout_val;
    input        i_ack_busy;
    input        i_init_intr_en;
    input        i_rw_done_intr_en;
    input        i_timeout_intr_en;
       
      
   
    /**********************************************************************************
    * Output Ports
    ***********************************************************************************/
    output [7:0]     o_data;
    output           o_sda;
    output           o_scl;
    output           o_data_valid;
    output           o_i2cs_busy;
    output           o_sda_tri_en;
    output           o_scl_tri_en;
    output           o_intr;
    output           o_rx_status;
    output           o_tx_status;
    output           o_init_done;
    output           o_rd_done;
    output           o_wr_done;
    output           o_timeout_err;
    output 	     o_init_intr;
    output 	     o_rw_intr;  
    output	     o_timeout_intr;
    output           o_data_request;


    i2cslave_controller i2cslave_controller_u1 (
                                                 .i_rst(i_rst),
		                                 .i_scl(i_scl),
                                                 .o_scl(o_scl),
		                                 .i_sda(i_sda),
		                                 .o_sda(o_sda),
		                                 .i_data(i_data),
		                                 .o_data(o_data),
                                                 .i_slave_addr(i_slave_addr),
                                                 .i_addr_10bit_en(i_addr_10bit_en),
                                                 .i_sclk_stretch_en(i_sclk_stretch_en),
                                                 .i_hs_mode(i_hs_mode),
                                                 .i_sys_clk(i_sys_clk),
                                                 .i_timeout_en(i_timeout_en),
                                                 .i_timeout_val(i_timeout_val),
                                                 .i_ack_busy(i_ack_busy),
                                                 .i_init_intr_en(i_init_intr_en),
                                                 .i_rw_done_intr_en(i_rw_done_intr_en),
                                                 .i_timeout_intr_en(i_timeout_intr_en),
                                                 .o_intr(o_intr),
                                                 .o_rx_status(o_rx_status),
                                                 .o_tx_status(o_tx_status),
                                                 .o_data_valid(o_data_valid),
                                                 .o_data_request(o_data_request),
                                                 .o_i2cs_busy(o_i2cs_busy),
                                                 .o_init_done(o_init_done),
                                                 .o_rd_done(o_rd_done),
                                                 .o_wr_done(o_wr_done),
                                                 .o_timeout_err(o_timeout_err),
                                                 .o_sda_tri_en(o_sda_tri_en),
                                                 .o_scl_tri_en(o_scl_tri_en),
		                                 .o_init_intr(o_init_intr),
		                                 .o_rw_intr(o_rw_intr),
		                                 .o_timeout_intr(o_timeout_intr)
		                                 );

    endmodule