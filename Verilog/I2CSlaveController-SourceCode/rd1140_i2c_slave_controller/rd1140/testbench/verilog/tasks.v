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

//`timescale 1 ns / 1 ps
    
    //**********************************************************************************************
    // START condition Generation
    //**********************************************************************************************

    

    task i2cm_start_gen;

        begin
			//@(posedge scl_in_tb_en);
			 generatet_scl_clock = 1'b1;			
			@(negedge scl_in_tb);
            sda_in = # (SCLK_FS_PERIOD/4) 1'b1;
            @(posedge scl_in_tb);
            sda_in = # (SCLK_FS_PERIOD/4) 1'b0;

            $display("START Generated", $time);
               
        end
    endtask // i2cm_start_gen



    //**********************************************************************************************
    // STOP condition Generation 
    //**********************************************************************************************

    task i2cm_stop_gen;

        begin
			
            sda_in = # (SCLK_FS_PERIOD/4) 1'b0;
            @(posedge scl_in_tb);
            sda_in = # (SCLK_FS_PERIOD/4) 1'b1;
            $display("STOP Generated", $time);
           
            @(negedge scl_in_tb);
            sda_in = # (SCLK_FS_PERIOD/4) 1'bZ;			
            # (SCLK_FS_PERIOD/4) generatet_scl_clock = 1'b0;
			
               
        end
    endtask // i2cm_stop_gen


    //**********************************************************************************************
    // Slave Acknowledgement Generation
    //**********************************************************************************************
 
    task i2cslave_ack_gen;

        begin
           
            @(posedge scl_in_tb);
            # (SCLK_FS_PERIOD/2);
            if (!sda_out_tb)
                $display("Slave generated Acknowledge", $time);
            else begin
                $display("Slave failed to generate Acknowledge", $time);
                if (!negative_testing_i) begin
                    if (!ack_busy_tb) begin
                        err_count_i <= #1 err_count_i + 1; end
                end
            end
           

        end
    endtask // i2cslave_ack_gen


    task i2cslave_ack_gen_clk_stretch;

        begin
           
            @(posedge scl_in_tb);
            # (SCLK_FS_PERIOD/4);
            if (!sda_out_tb) begin
                $display("Slave generated Acknowledge", $time);
                @(posedge sys_clk_tb);
                sclk_stretch_en_tb <= #1 1'b1;
                # (SYS_CLK_PERIOD * 3000);
                @ (posedge scl_fs_tb);
                sclk_stretch_en_tb <=  #1 1'b0; end
                

            else begin
                $display("Slave failed to generate Acknowledge", $time);
                if (!ack_busy_tb) begin
                    err_count_i <= #1 err_count_i + 1; end
                end
           

        end
    endtask // i2cslave_ack_gen


   

    //**********************************************************************************************
    // Slave Not Acknowledgement Generation
    //**********************************************************************************************
 
    task i2cslave_nack_gen;

        begin
            
            @(posedge scl_in_tb);
            # (SCLK_FS_PERIOD/4);
            if (sda_out_tb == 1'b0) begin
                $display("Slave Failed to generate Not Acknowledge", $time); 
                err_count_i <= #1 err_count_i + 1; end
            else begin
                $display("Slave generated Not Acknowledge", $time);
                hs_mode_clk <= #1 1'b1;
            end
           
           

        end
    endtask

    //**********************************************************************************************
    // Master Acknowledgement Generation
    //**********************************************************************************************

    task i2cm_ack_gen;

        begin
          
            @(negedge scl_in_tb);
            sda_in <= # (SCLK_FS_PERIOD/4) 1'b0 ;
            @(negedge scl_in_tb);
            sda_in <= # (SCLK_FS_PERIOD/4) 1'b1 ;
            $display("Master generated Acknowledge", $time);

        end
    endtask // i2cm_ack_gen


    task i2cm_ack_gen_clk_stretch;

        begin

            @(negedge scl_in_tb);
            sda_in <= # (SCLK_FS_PERIOD/4) 1'b0 ;
            @(negedge scl_in_tb);
            sda_in <= # (SCLK_FS_PERIOD/4) 1'b1 ;
            $display("Master generated Acknowledge", $time);

        end
    endtask // i2cm_ack_gen
          
            

    //**********************************************************************************************
    // Master Writing Data
    //**********************************************************************************************

    task i2cm_write_data;
        input [7:0] data;
        integer      i;
       
        begin
            
            for(i=0; i<=7; i=i+1)
                begin
                    @(negedge scl_in_tb);
                    # (SCLK_FS_PERIOD/4);
                    sda_in <= #1 data[7-i];
                end
           
        @(negedge scl_in_tb);
        sda_in <= # (SCLK_FS_PERIOD/4) 1'bZ;
        $display(" Master Byte Write Successful", $time);   
        end   
    endtask // i2cm_write_data



    task i2cm_write_data_clk_stretch;
        input [7:0] data;
        integer      i;
       
        begin
            
            for(i=0; i<=7; i=i+1)
                begin
                    @(negedge scl_in_tb);
                    # (SCLK_FS_PERIOD/4);
                    sda_in <= #1 data[7-i];
                    # (SCLK_FS_PERIOD/4);
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <= #1 1'b1;
                    # (SYS_CLK_PERIOD * 3000);
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <=  #1 1'b0;

                end
        
        
        @(negedge scl_in_tb);
        sda_in <= # (SCLK_FS_PERIOD/4) 1'bZ;
        $display(" Master Byte Write Successful", $time);   
        end   
    endtask // i2cm_write_data



    //**********************************************************************************************
    // Master Reading Data
    //**********************************************************************************************

    task i2cm_read_data;
        integer j;

        begin
            
            for (j=0; j<=7; j=j+1)
                begin
                    @(posedge scl_in_tb);
                    # (SCLK_FS_PERIOD/4);
                    read_data_i[7-j] = #1 sda_out_tb;
                end
           
            $display(" Master Byte Read Successful", $time);
            if (read_data_i != data_in_tb) begin
                $display(" Data mismatch read %h, expected %h", read_data_i, data_in_tb, $time);
                err_count_i = #1 err_count_i + 1; end
           
        end
    endtask // i2cm_read_data



    task i2cm_read_data_clk_stretch;
        integer j;

        begin
            
            for (j=0; j<=7; j=j+1)
                begin
                    @(posedge scl_in_tb);
                    # (SCLK_FS_PERIOD/4);
                    read_data_i[7-j] = #1 sda_out_tb;
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <= #1 1'b1;
                    # (SYS_CLK_PERIOD * 3000);
                    @ (posedge scl_fs_tb);
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <=  #1 1'b0;

                end
           
            $display(" Master Byte Read Successful", $time);
            if (read_data_i != data_in_tb) begin
                $display(" Data mismatch read %h, expected %h", read_data_i, data_in_tb, $time);
                err_count_i = #1 err_count_i + 1; end
           
        end
    endtask // i2cm_read_data



    //**********************************************************************************************
    // Master Not Acknowledgement Generation
    //**********************************************************************************************

    task i2cm_nack_gen;

        begin
          
            @(negedge scl_in_tb);
            # (SCLK_FS_PERIOD/4);
            sda_in <= #1  1'b1 ;
            @(negedge scl_in_tb);
            sda_in <= # 1 1'b1 ;
            $display("Master generated Not Acknowledge", $time);

        end
    endtask // i2cm_nack_gen


    //****************************************************************************************   
    // High Speed Mode Tasks
   //****************************************************************************************   

    task i2cm_hs_start_gen;

        begin
          
		  
			generatet_scl_clock = 1'b1;			
            @(negedge scl_in_tb);
            sda_in = # (SCLK_HS_PERIOD/4) 1'b1;
            @(posedge scl_in_tb);
            sda_in = # (SCLK_HS_PERIOD/4) 1'b0;

            $display("START Generated", $time);
               
        end
    endtask // i2cm_start_gen



    //**********************************************************************************************
    // STOP condition Generation 
    //**********************************************************************************************

    task i2cm_hs_stop_gen;

        begin
          
            
            sda_in = # (SCLK_HS_PERIOD/4) 1'b0;
            @(posedge scl_in_tb);
            sda_in = # (SCLK_HS_PERIOD/4) 1'b1;
            $display("STOP Generated", $time);
           
            @(negedge scl_in_tb);
            sda_in = # (SCLK_HS_PERIOD/4) 1'bZ;
			# (SCLK_HS_PERIOD/4) generatet_scl_clock = 1'b0;	
               
        end
    endtask // i2cm_stop_gen


    //**********************************************************************************************
    // Slave Acknowledgement Generation
    //**********************************************************************************************
 
    task i2cslave_hs_ack_gen;

        begin
           
            @(posedge scl_in_tb);
            # (SCLK_HS_PERIOD/4);
            if (!sda_out_tb)
                $display("Slave generated Acknowledge", $time);
            else begin
                $display("Slave failed to generate Acknowledge", $time);
                err_count_i <= #1 err_count_i + 1; end
           

        end
    endtask // i2cslave_hs_ack_gen



    task i2cslave_hs_ack_gen_clk_stretch;

        begin
           
            @(posedge scl_in_tb);
            # (SCLK_HS_PERIOD/4);
            if (!sda_out_tb) begin
                $display("Slave generated Acknowledge", $time);
                @(posedge sys_clk_tb);
                sclk_stretch_en_tb <= #1 1'b1;
                # (SYS_CLK_PERIOD * 3000);
                @ (posedge scl_hs_tb);
                sclk_stretch_en_tb <=  #1 1'b0; end
       
            else begin
                $display("Slave failed to generate Acknowledge", $time);
                if (!ack_busy_tb) begin
                    err_count_i <= #1 err_count_i + 1; end
                end
           

        end
    endtask // i2cslave_ack_gen


    //**********************************************************************************************
    // Slave Not Acknowledgement Generation
    //**********************************************************************************************
 
    task i2cslave_hs_nack_gen;

        begin
            
            @(posedge scl_in_tb);
            # (SCLK_HS_PERIOD/4);
            if (sda_out_tb) begin
                $display("Slave generated Not Acknowledge", $time); end
            else begin
                $display("Slave Failed to generate Not Acknowledge", $time);
                err_count_i <= #1 err_count_i + 1; end
           

        end
    endtask

    //**********************************************************************************************
    // Master Acknowledgement Generation
    //**********************************************************************************************

    task i2cm_hs_ack_gen;

        begin
          
            @(negedge scl_in_tb);
            
            sda_in <= # (SCLK_HS_PERIOD/4) 1'b0 ;
            @(negedge scl_in_tb);
            sda_in <= # (SCLK_HS_PERIOD/4) 1'b1 ;
            $display("Master generated Acknowledge", $time);

        end
    endtask // i2cm_ack_gen


    task i2cm_hs_ack_gen_clk_stretch;

        begin
          
            @(negedge scl_in_tb);
            
            sda_in <= # (SCLK_HS_PERIOD/4) 1'b0 ;
            @(negedge scl_in_tb);
            sda_in <= 1'b1 ;
            $display("Master generated Acknowledge", $time);

        end
    endtask // i2cm_ack_gen


    //**********************************************************************************************
    // Master Writing Data
    //**********************************************************************************************

    task i2cm_hs_write_data;
        input [7:0] data;
        integer      i;
       
        begin
            
            for(i=0; i<=7; i=i+1)
                begin
                    @(negedge scl_in_tb);
                    # (SCLK_HS_PERIOD/4);
                    sda_in <= #1 data[7-i];
                end
           
        @(negedge scl_in_tb);
        sda_in <= # (SCLK_HS_PERIOD/4) 1'bZ;
        $display(" Master Byte Write Successful", $time);   
        end   
    endtask // i2cm_write_data


    task i2cm_hs_write_data_clk_stretch;
        input [7:0] data;
        integer      i;
       
        begin
            
            for(i=0; i<=7; i=i+1)
                begin
                    @(negedge scl_in_tb);
                    # (SCLK_HS_PERIOD/4);
                    sda_in <= #1 data[7-i];
                    # (SCLK_HS_PERIOD/4);
                    
                    sclk_stretch_en_tb <= #1 1'b1;
                    # (SYS_CLK_PERIOD * 3000);
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <=  #1 1'b0;

                end
        
        
        @(negedge scl_in_tb);
        sda_in <= # (SCLK_HS_PERIOD/4) 1'bZ;
        $display(" Master Byte Write Successful", $time);   
        end   
    endtask // i2cm_write_data


    //**********************************************************************************************
    // Master Reading Data
    //**********************************************************************************************

    task i2cm_hs_read_data;
        integer j;

        begin
            
            for (j=0; j<=7; j=j+1)
                begin
                    @(posedge scl_in_tb);
                    # (SCLK_HS_PERIOD/4);
                    read_data_i[7-j] = #1 sda_out_tb;
                end
           
            $display(" Master Byte Read Successful", $time);
            if (read_data_i != data_in_tb) begin
                $display(" Data mismatch", $time);
                err_count_i = #1 err_count_i + 1; end
           
        end
    endtask // i2cm_read_data


    task i2cm_hs_read_data_clk_stretch;
        integer j;

        begin
            
            for (j=0; j<=7; j=j+1)
                begin
                    @(posedge scl_in_tb);
                    # (SCLK_HS_PERIOD/4);
                    read_data_i[7-j] = #1 sda_out_tb;
                    sclk_stretch_en_tb <= #1 1'b1;
                    # (SYS_CLK_PERIOD * 3000);
                    @ (posedge scl_hs_tb);
                    @ (posedge sys_clk_tb);
                    sclk_stretch_en_tb <=  #1 1'b0;

                end
           
            $display(" Master Byte Read Successful", $time);
            
            if (read_data_i != data_in_tb) begin
                $display(" Data mismatch read %h, expected %h", read_data_i, data_in_tb, $time);
                err_count_i = #1 err_count_i + 1; end
           
        end
    endtask // i2cm_read_data


    //**********************************************************************************************
    // Master Not Acknowledgement Generation
    //**********************************************************************************************

    task i2cm_hs_nack_gen;

        begin
          
            @(negedge scl_in_tb);
            # (SCLK_HS_PERIOD/4);
            sda_in <= #1  1'b1 ;
            @(negedge scl_in_tb);
            sda_in <= # 1 1'b1 ;
            $display("Master generated Not Acknowledge", $time);

        end
    endtask // i2cm_nack_gen
   