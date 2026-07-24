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

`timescale 1ns / 100ps

module i2cslave_controller_tb();

   


//--------------------------------------------------------------------------------------------------
// Parameter declarations
//--------------------------------------------------------------------------------------------------
    // SCL clock cycle and System Reset time
    parameter SCLK_FS_PERIOD = 10000;
    parameter SCLK_HS_PERIOD = 294;
    parameter SYS_CLK_PERIOD = 31;
   
    parameter RST_PERIOD  = 10;

       
    // I2C slave addresses
    parameter [6:0] SLAVE_ADDR_7BIT = 7'b01_01_01_0;
    parameter [7:0] MASTER_WRITE_DATA = 8'b10_10_10_10;
   


//--------------------------------------------------------------------------------------------------
// wire declarations
//--------------------------------------------------------------------------------------------------
    
    reg           rst_tb;
    reg   [7:0]   data_in_tb;
    wire  [7:0]   data_out_tb;
    tri1          scl_in_tb;
    tri1          scl_out_tb;
    tri1          sda_in_tb;
    tri1          sda_out_tb;
    reg   [9:0]   slave_addr_tb;
    reg           addr_10bit_en_tb;
    wire          data_request_tb;
    wire          o_data_valid_tb;
    reg           sclk_stretch_en_tb;
    wire          data_vaild_tb;
    wire          i2cs_busy_tb;
    wire          sda_tri_en_tb;
    wire          scl_tri_en_tb;
    reg           hs_mode_tb;
    reg           sys_clk_tb;
    reg           timeout_en_tb;
    reg [15:0]    timeout_val_tb;
    reg           ack_busy_tb;
    reg           init_intr_en_tb;
    reg           rw_done_intr_en_tb;
    reg           timeout_intr_en_tb;
    wire          intr_tb;
    wire          rx_status_tb;
    wire          tx_status_tb;
    wire          init_done_tb;
    wire          rd_done_tb;
    wire          wr_done_tb;
    wire          timeout_err_tb;
    wire          init_intr_tb;
    wire          rw_intr_tb;
    wire          timeout_intr_tb;
    reg           sda_in;
    
   
   
    reg [7:0]     read_data_i;
   
    integer       err_count_i;

    reg           scl_fs_tb;
    reg           scl_hs_tb;
    reg           hs_mode_clk;
    reg           negative_testing_i;
	
	tri1 		  scl_in_tb_en;
	reg 		  generatet_scl_clock;

                
      
    `include "testcase.v"
      

   assign sda_in_tb = sda_in;
   


//--------------------------------------------------------------------------------------------------
// SCLK generation
//--------------------------------------------------------------------------------------------------
    initial begin
        scl_fs_tb = 1'b0;
        forever #(SCLK_FS_PERIOD/2) scl_fs_tb = ~scl_fs_tb;
    end

   initial begin
        scl_hs_tb = 1'b1;
        forever #(SCLK_HS_PERIOD/2) scl_hs_tb = ~scl_hs_tb;
    end

	
	assign scl_in_tb_en = (!sclk_stretch_en_tb && !hs_mode_clk) ? scl_fs_tb : (!sclk_stretch_en_tb && hs_mode_clk) ? scl_hs_tb :(sclk_stretch_en_tb && hs_mode_clk) ?  1'bZ :(sclk_stretch_en_tb && !hs_mode_clk) ?  1'bZ  :
                       (scl_fs_tb);
	
	
	// Fix for the continuous SCL clock to slave design
    assign scl_in_tb = generatet_scl_clock ? ((!sclk_stretch_en_tb && !hs_mode_clk) ? scl_fs_tb : 
                       (!sclk_stretch_en_tb && hs_mode_clk) ? scl_hs_tb :
                       (sclk_stretch_en_tb && hs_mode_clk) ?  1'bZ :
                       (sclk_stretch_en_tb && !hs_mode_clk) ?  1'bZ  :
                       (scl_fs_tb)) : 1'bz;


//--------------------------------------------------------------------------------------------------
// System Clock generation
//--------------------------------------------------------------------------------------------------
    initial begin
		generatet_scl_clock = 1'b0;
        sys_clk_tb = 1'b0;
        forever #(SYS_CLK_PERIOD/2) sys_clk_tb = ~sys_clk_tb;
    end

//--------------------------------------------------------------------------------------------------
// System reset generation
//--------------------------------------------------------------------------------------------------
    initial begin
        rst_tb <= 1'b1;
        #RST_PERIOD;
        rst_tb <= 1'b0;
    end


//--------------------------------------------------------------------------------------------------
// Initialization
//--------------------------------------------------------------------------------------------------
    initial begin
        err_count_i <= 0;
        read_data_i <= 1'b0;
        timeout_en_tb <= 1'b0;
        timeout_val_tb <= 16'b0;
        init_intr_en_tb <= 1'b0;
        rw_done_intr_en_tb <= 1'b0;
        timeout_intr_en_tb <= 1'b0;
        hs_mode_tb <= 1'b0;
        sclk_stretch_en_tb <= 1'b0;
        ack_busy_tb <= 1'b0;
        data_in_tb <= 1'b0;
        sda_in <= 1'b0;
        hs_mode_clk <= 1'b0;
        negative_testing_i <= 1'b0;
                      
    end
  

//--------------------------------------------------------------------------------------------------
// testace execution
//--------------------------------------------------------------------------------------------------
    initial begin
        @(negedge rst_tb);
        testcase;
    end


//--------------------------------------------------------------------------------------------------
// DUT instance
//--------------------------------------------------------------------------------------------------

    i2cslave_controller_top i2cslave_controller_tb_u1 (
                                                   .i_rst(rst_tb),
		                                   .i_scl(scl_in_tb),
                                                   .o_scl(scl_out_tb),
		                                   .i_sda(sda_in_tb),
		                                   .o_sda(sda_out_tb),
		                                   .i_data(data_in_tb),
		                                   .o_data(data_out_tb),
                                                   .i_slave_addr(slave_addr_tb),
                                                   .i_addr_10bit_en(addr_10bit_en_tb),
                                                   .i_sclk_stretch_en(sclk_stretch_en_tb),
                                                   .o_data_valid(o_data_valid_tb),
                                                   .o_i2cs_busy(i2cs_busy_tb),
                                                   .o_sda_tri_en(sda_tri_en_tb),
                                                   .o_scl_tri_en(scl_tri_en_tb),
                                                   .i_hs_mode(hs_mode_tb),
                                                   .i_sys_clk(sys_clk_tb),
                                                   .i_timeout_en(timeout_en_tb),
                                                   .i_timeout_val(timeout_val_tb),
                                                   .i_ack_busy(ack_busy_tb),
                                                   .i_init_intr_en(init_intr_en_tb),
                                                   .i_rw_done_intr_en(rw_done_intr_en_tb),
                                                   .i_timeout_intr_en(timeout_intr_en_tb),
                                                   .o_intr(intr_tb),
                                                   .o_rx_status(rx_status_tb),
                                                   .o_tx_status(tx_status_tb),
                                                   .o_init_done(init_done_tb),
                                                   .o_rd_done(rd_done_tb),
                                                   .o_wr_done(wr_done_tb),
                                                   .o_timeout_err(timeout_err_tb),
                                                   .o_init_intr(init_intr_tb),
		                                   .o_rw_intr(rw_intr_tb),
		                                   .o_timeout_intr(timeout_intr_tb),
                                                   .o_data_request(data_request_tb)
                                                    );


endmodule

