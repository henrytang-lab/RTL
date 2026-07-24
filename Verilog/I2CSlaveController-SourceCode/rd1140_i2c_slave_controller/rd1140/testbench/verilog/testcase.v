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

`include "tasks.v"


task testcase;

    begin

        

    
//**************************************************************************************************
// Test cases 
//**************************************************************************************************
  
    //--------------------------------------------------------------------------------------------------
    // Standard mode operations
    // With out clock stretching

    //--------------------------------------------------------------------------------------------------
    // Testcase 1: Interrupt generation - i_init_intr_en   
    //--------------------------------------------------------------------------------------------------

    timeout_val_tb <= #1 16'b0000000010101111;

    rw_done_intr_en_tb <= #1 1'b1;

    init_intr_en_tb <= #1 1'b1;

    hs_mode_tb <= #1 1'b0;


       
    $display("~~~~~~~~~~ Testcase 1: Interrupt generation - i_init_intr_en ~~~~~~~~~~");

    
    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;
    
       
    init_intr_en_tb <= #1 1'b1;

    i2cm_start_gen();
    

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();

    i2cm_stop_gen();
     
    #10000000;
	 
       
       
 
    //--------------------------------------------------------------------------------------------------
    // Testcase 2: Interrupt generation - i_rw_done_intr_en
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 2: Interrupt generation - i_rw_done_intr_en ~~~~~~~~~~");

    
    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;
    
       
    rw_done_intr_en_tb <= #1 1'b1;

    i2cm_start_gen();
    

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0; 

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();

    i2cm_stop_gen();
       
    #10000000;
  

 
  
    //--------------------------------------------------------------------------------------------------
    // Testcase 3: 7 bit Addressing - 1 byte Slave Read 
    //--------------------------------------------------------------------------------------------------
       
    addr_10bit_en_tb <= #1 1'b0;                // 7 bit addressing       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
    
    $display("~~~~~~~~~~ Testcase 3: 7 bit addressing - 1 byte Slave Read Operation  ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(MASTER_WRITE_DATA);
    i2cslave_ack_gen();
       
    i2cm_stop_gen();

    #10000000;
       

    //--------------------------------------------------------------------------------------------------
    // Testcase 4: 7 bit Addressing - 4 bytes Slave Read 
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 4: 7 bit addressing - 4 bytes Slave Read Operation  ~~~~~~~~~~");
       
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);
    i2cslave_ack_gen();
       
    i2cm_stop_gen();   
 
    #10000000;
	

    //--------------------------------------------------------------------------------------------------
    // Testcase 5: 7 bit Addressing - 1 byte Slave Write
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 5: 7 bit addressing - 1 byte Slave Write Operation  ~~~~~~~~~~");
       
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
       
    fork
       
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
       
    data_in_tb <= #1 8'b10_01_01_01;
       
    end
    join
    
   
   
    i2cm_read_data();
    i2cm_nack_gen();
    
    

    i2cm_stop_gen();

    #10000000;

    
  
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 6: 7 bit Addressing - 3 bytes Slave Write
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 6: 7 bit addressing - 3 bytes Slave Write Operation  ~~~~~~~~~~");
       
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1

    fork

    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
                   
    data_in_tb <= #1 8'b00_01_11_00;
    end
    join   
    
        
       
    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join



    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join



    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join
       
   
    

    i2cm_read_data();
          
    i2cm_nack_gen();
       
   
    
    i2cm_stop_gen();
    
    #10000000;

       
    

    //--------------------------------------------------------------------------------------------------
    // Testcase 7: 7 bit Addressing - 2 bytes Slave Write Write Operation with Repeated Start (W-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 7: 7 bit addressing - 2 bytes Slave Write Write Operation with Repeated Start (W-W) ~~~~~~~~~~");

    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1

    fork 
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join
       
       
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b10_01_01_00;
    end
    join
       
    
    
    
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b10_01_01_01;
    end
    join
    
    
    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork 
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_00;
    end
    join

    
       
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_01;
    end
    join

    
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b10_01_01_00;
    end
    join

    
    
    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_stop_gen();
    
    #10000000;


    
    //--------------------------------------------------------------------------------------------------
    // Testcase 8: 7 bit Addressing - 2 bytes Slave Write Read Operation with Repeated Start (W-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 8: 7 bit addressing - 2 bytes Slave Write Read Operation with Repeated Start (W-R) ~~~~~~~~~~");

    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork 
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_00;
    end
    join
       
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork 
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b10_01_01_00;
    end
    join

    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_00_10);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);
    i2cslave_ack_gen();
    
    i2cm_stop_gen();    
       
    #10000000;

       
       

    //--------------------------------------------------------------------------------------------------
    // Testcase 9: 7 bit Addressing - 2 bytes Slave Read Read Operation with Repeated Start (R-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 9: 7 bit addressing - 2 bytes Slave Read Read Operation with Repeated Start (R-R) ~~~~~~~~~~");
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
    
    
    i2cm_write_data(MASTER_WRITE_DATA);
    i2cslave_ack_gen();
    
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
    
    
    i2cm_write_data(MASTER_WRITE_DATA);
    i2cslave_ack_gen();
       
    i2cm_stop_gen();
    
    #10000000;



    //--------------------------------------------------------------------------------------------------
    // Testcase 10: 7 bit Addressing - 2 bytes Slave Read Write Operation with Repeated Start (R-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 10: 7 bit addressing - 2 bytes Slave Read Write Operation with Repeated Start (R-W) ~~~~~~~~~~");
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
    
    
    i2cm_write_data(MASTER_WRITE_DATA);
    i2cslave_ack_gen();
    
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1

    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
   
    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_stop_gen();
    
    #10000000;

       
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 11: 10 bit Addressing - 2 bytes Slave Read 
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 11: 10 bit addressing - 2 bytes Slave Read Operation  ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                   
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();

    i2cm_stop_gen();
    
    #10000000;

    addr_10bit_en_tb <= #1 1'b0; 
    //--------------------------------------------------------------------------------------------------
    // Testcase 12: 10 bit Addressing - 2 bytes Slave Write 
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 12: 10 bit addressing - 2 bytes Slave Write Operation  ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1

           
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    

    i2cm_read_data();
    i2cm_nack_gen();
               
    i2cm_stop_gen();
     
    #10000000;
    
    
    //--------------------------------------------------------------------------------------------------
    // Testcase 13: 10 bit Addressing - 4 bytes Slave Write Read Operation with Repeated Start (W-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 13: 10 bit addressing - 4 bytes Slave Read Operation with Repeated Start (W-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0; 

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data1
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data2
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data3
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data4
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    

    i2cm_read_data();

    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_stop_gen();
    
    #10000000;
    
    
    //--------------------------------------------------------------------------------------------------
    // Testcase 14: 10 bit Addressing - 4 bytes Slave Read Read Operation with Repeated Start (R-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 14: 10 bit addressing - 4 bytes Slave Read Read Operation with Repeated Start (R-R) ~~~~~~~~~~");
    
    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data1
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data2
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data3
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data4
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data1
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data2
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data3
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data4
    i2cslave_ack_gen();
    
    i2cm_stop_gen();
    
    #10000000;
    
    //--------------------------------------------------------------------------------------------------
    // Testcase 15: 10 bit Addressing - 4 bytes Slave Write Read Operation with Repeated Start (W-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 15: 10 bit addressing - 4 bytes Slave Write Operation with Repeated Start (W-R) ~~~~~~~~~~");
    
    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
   
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();
          
    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data1
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data2
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data3
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data4
    i2cslave_ack_gen();
    
    i2cm_stop_gen();
    
    #10000000;
    
    
    //--------------------------------------------------------------------------------------------------
    // Testcase 16: 10 bit Addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 16: 10 bit addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W) ~~~~~~~~~~");
    
    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

           
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
     
    addr_10bit_en_tb <= #1 1'b0;
 
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();

    addr_10bit_en_tb <= #1 1'b1;
    
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();
    
    i2cm_stop_gen();

    
    
    #10000000;
    
    //--------------------------------------------------------------------------------------------------------
    // Testcase 17: 7 bit and 10 bit Addressing - 4 bytes Slave Read Read Operation with Repeated Start (R-R)
    //--------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 17: 7 bit and 10 bit addressing - 4 bytes Slave Read Operation with Repeated Start (R-R)~~~~~~~~~~");
    
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);    // Data
    i2cslave_ack_gen();
    
    i2cm_start_gen();                   
       
    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;
    
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_stop_gen();
    
    #10000000;

    
    //--------------------------------------------------------------------------------------------------
    // Testcase 18: 7 bit and 10 bit Addressing - 4 bytes Slave Read Write Operation with Repeated Start (R-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 18: 7 bit and 10 bit addressing - 4 bytes Slave Read Write Operation with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;
    
    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);    // Data
    i2cslave_ack_gen();
    
    i2cm_start_gen();                   

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();
           

    i2cm_stop_gen();
    
    #10000000;

      
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 19: 7 bit and 10 bit Addressing - 4 bytes Slave Write Read Operation with Repeated Start (R-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 19: 7 bit and 10 bit addressing - 4 bytes Slave Write Read Operation with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join 

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    i2cm_nack_gen();
      

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();
    

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_stop_gen();
    
    #10000000; 


    //--------------------------------------------------------------------------------------------------
    // Testcase 20: 7 bit and 10 bit Addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 20: 7 bit and 10 bit addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
       
    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    i2cm_nack_gen();


    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();
           

    i2cm_stop_gen();
    
    #10000000;


    //--------------------------------------------------------------------------------------------------
    // Testcase 21: 10 bit and 7 bit Addressing - 4 bytes Slave Read Read Operation with Repeated Start (R-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 21: 10 bit and 7 bit addressing - 4 bytes Slave Read Read Operation with Repeated Start (R-R)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();
    

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_start_gen();

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

           
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);    // Data
    i2cslave_ack_gen();

    i2cm_stop_gen();
    
    #10000000;     
	  
    //--------------------------------------------------------------------------------------------------
    // Testcase 22: 10 bit and 7 bit Addressing - 4 bytes Slave Read Write Operation with Repeated Start (R-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 22: 10 bit and 7 bit addressing - 4 bytes Slave Read Write Operation with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();
    

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    i2cm_write_data(8'b01_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_00);     // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b11_10_01_01);     // Data
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;
    
    i2cm_start_gen();

    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_read_data();
    i2cm_nack_gen();


    i2cm_stop_gen();
    
    #10000000;


    //--------------------------------------------------------------------------------------------------
    // Testcase 23: 10 bit and 7 bit Addressing - 4 bytes Slave Write Read Operation with Repeated Start (W-R)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 23: 10 bit and 7 bit addressing - 4 bytes Slave Write Read Operation with Repeated Start (W-R)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();

    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1

    
       
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();


    i2cm_start_gen(); 

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_00);    // Data
    i2cslave_ack_gen();

    i2cm_stop_gen();
    
    #10000000;

	
    //--------------------------------------------------------------------------------------------------
    // Testcase 24: 10 bit and 7 bit Addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W)
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 24: Testcase 3: 10 bit and 7 bit addressing - 4 bytes Slave Write Write Operation with Repeated Start (W-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();
    
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();
    
    i2cm_start_gen();  
    
    i2cm_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1

           
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_read_data();
    i2cm_nack_gen();
           


    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();

    i2cm_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_read_data();
    fork
    i2cm_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_read_data();
    i2cm_nack_gen();
       


    i2cm_stop_gen();
    
    #10000000;
    

    //--------------------------------------------------------------------------------------------------
    // High Speed mode operations
    // With out clock stretching
    //--------------------------------------------------------------------------------------------------    
    //--------------------------------------------------------------------------------------------------
    // Testcase 25: 7 bit Addressing - 4 bytes Slave Read Operation with High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 25: 7 bit addressing - 4 bytes Slave Read Operation with High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
       
    i2cm_hs_start_gen();

        
    i2cm_hs_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

        
       
   
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 26: 7 bit Addressing - 4 bytes Slave Write Operation with High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 26: 7 bit addressing - 4 bytes Slave Write Operation with High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;


    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();

    i2cm_hs_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
    
    


    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

              

    //--------------------------------------------------------------------------------------------------
    // Testcase 27: 10 bit Addressing - 4 bytes Slave Read Operation with High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 27: 10 bit addressing - 4 bytes Slave Read Operation with High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();
    

    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    addr_10bit_en_tb <= #1 1'b0; 

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b01_10_01_00);     // Data
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b01_10_01_01);     // Data
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_00);     // Data
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_01);     // Data
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
       
    #10000000;



    //--------------------------------------------------------------------------------------------------
    // Testcase 28: 10 bit Addressing - 4 bytes Slave Write Operation with High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 28: 10 bit addressing - 4 bytes Slave Write Operation with High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
    #(SCLK_HS_PERIOD/4);
       
      
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();

    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();
    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1

    addr_10bit_en_tb <= #1 1'b0;
       
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
           

     
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;
  
 
    //---------------------------------------------------------------------------------------------------------------------
    // Testcase 29: 7 bit Addressing - 4 bytes Slave Read Read Operation with High Speed Mode and with Repeated Start (R-R)
    //---------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 29: 7 bit addressing - 4 bytes Slave Read Read Operation with High Speed Mode and with Repeated Start (R-R)~~~~~~~~~~");


    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();

        
    i2cm_hs_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen();
       

    i2cm_hs_start_gen();                    // Repeated Start

        
    i2cm_hs_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen();
     
    i2cm_hs_write_data(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen();    

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;


    //---------------------------------------------------------------------------------------------------------------------------------
    // Testcase 30: 7 bit Addressing - 4 bytes Slave Read Write Operation with High Speed Mode and with Repeated Start (R-W)
    //---------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 30: 7 bit addressing - 4 bytes Slave Read Write Operation with High Speed Mode and with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();

        
    i2cm_hs_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen();
       

    i2cm_hs_start_gen();                    // Repeated Start

    i2cm_hs_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
       

    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;



    //-----------------------------------------------------------------------------------------------------------------------
    // Testcase 31: 7 bit Addressing - 4 bytes Slave  Write Read Operation with High Speed Mode and with Repeated Start(W-R)
    //--------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 31: 7 bit addressing - 4 bytes Slave Write Read Operation with High Speed Mode and with Repeated Start (W-R)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();

    i2cm_hs_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();

 

    i2cm_hs_start_gen();

        
    i2cm_hs_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen();
       
    i2cm_hs_write_data(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

     

    //------------------------------------------------------------------------------------------------------------------------
    // Testcase 32: 7 bit Addressing - 4 bytes Slave Write Write Operation with High Speed Mode and with Repeated Start (W-W)
    //------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 32: 7 bit addressing - 4 bytes Slave Write Write Operation with High Speed Mode and with Repeated Start (W-W)~~~~~~~~~~");
       
    
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();

    i2cm_hs_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join    

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();



    i2cm_hs_start_gen();                   // Repeated Start

    i2cm_hs_write_data(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();



    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

     
       

    //------------------------------------------------------------------------------------------------------------------------
    // Testcase 33: 10 bit Addressing - 4 bytes Slave Read Read Operation with High Speed Mode and with Repeated Start (R-R)
    //-------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 33: 10 bit addressing - 4 bytes Slave Read Read Operation with High Speed Mode and with Repeated Start (R-R)~~~~~~~~~~");
       
    
    addr_10bit_en_tb <= #1 1'b1;                     // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;

    
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();                    
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b01_10_01_00);     // Data1
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b01_10_01_01);     // Data2
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_00);     // Data3
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_01);     // Data4
    i2cslave_hs_ack_gen();

    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b01_10_01_00);     // Data1
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b01_10_01_01);     // Data2
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_00);     // Data3
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_01);     // Data4
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

       

    //---------------------------------------------------------------------------------------------------------------------------
    // Testcase 34: 10 bit Addressing - 4 bytes Slave Read Write Operation with High Speed Mode and with Repeated Start(R-W)
   //----------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 34: 10 bit addressing - 4 bytes Slave Read Write Operation with High Speed Mode and with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                     // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;


    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;

    
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();                    
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    addr_10bit_en_tb <= #1 1'b0; 

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b01_10_01_00);     // Data1
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b01_10_01_01);     // Data2
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_00);     // Data3
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_01);     // Data4
    i2cslave_hs_ack_gen();

    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
    
    
    
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

       
       
       
    //-----------------------------------------------------------------------------------------------------------------------
    // Testcase 35: 10 bit Addressing - 4 bytes Slave Write Read Operation with High Speed Mode and with Repeated Start(W-R)
    //------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 35: 10 bit addressing - 4 bytes Slave Write Read Operation with High Speed Mode and with Repeated Start (W-R)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                     // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;


    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;

    
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();                    
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte

    
       
    i2cslave_hs_ack_gen();
    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join
       
    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
           
    addr_10bit_en_tb <= #1 1'b1;
    
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b01_10_01_00);     // Data1
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b01_10_01_01);     // Data2
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_00);     // Data3
    i2cslave_hs_ack_gen();
    
    i2cm_hs_write_data(8'b11_10_01_01);     // Data4
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;  
  

   

    //-----------------------------------------------------------------------------------------------------------------------
    // Testcase 36: 10 bit Addressing - 4 bytes Slave Write Write Operation with High Speed Mode and with Repeated Start(W-W)
    //-------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 36: 10 bit addressing - 4 bytes Slave Write Write Operation with High Speed Mode and with Repeated Start (W-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                     // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
       
    hs_mode_tb <= #1 1'b0;

    
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();                    
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte
       
    
       
    i2cslave_hs_ack_gen();
    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join
       
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_hs_read_data();
    i2cm_hs_nack_gen();
           
    addr_10bit_en_tb <= #1 1'b1;
    
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen();

    i2cm_hs_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen();
    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
    
    i2cm_hs_read_data();
    fork
    i2cm_hs_ack_gen();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    
    i2cm_hs_read_data();
    i2cm_hs_nack_gen();


    
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;
       
       
       
    
    //--------------------------------------------------------------------------------------------------
    // Timeout condition for SCL - Also checks for o_intr when i_timeout_intr_en is High
    //--------------------------------------------------------------------------------------------------
       
    timeout_intr_en_tb <= #1 1'b1;
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 37: Timeout condition for SCL - Timeout enabled but SCL goes high before i_timeout_val
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 37: Timeout condition for SCL - Timeout enabled but SCL goes high before i_timeout_val ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
           
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b00_11_00_01);    // Data
    i2cslave_ack_gen();
    
    i2cm_write_data(8'b00_11_00_00);    // Data
    i2cslave_ack_gen();

    @ (negedge scl_in_tb);
        
    timeout_en_tb <= #1 1'b1;
    # (SYS_CLK_PERIOD * timeout_val_tb ); 
    
    timeout_en_tb <= #1 1'b0;  

    @ (negedge scl_in_tb);  
    
    i2cm_stop_gen();
       
    #10000000; 


    //--------------------------------------------------------------------------------------------------
    // Testcase 38: Timeout condition for SCL - Timeout enabled and SCL still low  when counter reaches i_timeout_val
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 38: Timeout condition for SCL - Timeout enabled and SCL still low  when counter reaches i_timeout_val ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
           
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_10);    // Data
    i2cslave_ack_gen();
       
    i2cm_write_data(8'b10_11_00_01);    // Data
    i2cslave_ack_gen();

    timeout_val_tb <= #1 16'b0000000000101100;
    
    @ (negedge scl_in_tb);
        
    timeout_en_tb <= #1 1'b1;
    # (SYS_CLK_PERIOD * timeout_val_tb ); 
    
    timeout_en_tb <= #1 1'b0;  
       
    
    #10000000; 
      

       
       
     
    //--------------------------------------------------------------------------------------------------
    // Testcase 39: Clock stretching  - 7 bit addressing 4 byte Slave Read Operations
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 39: Clock stretching  - 7 bit addressing 4 byte Slave Read Operations ~~~~~~~~~~");
    
               
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
           
    i2cm_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen_clk_stretch();
       
               
    i2cm_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_ack_gen_clk_stretch();

           
    i2cm_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();

    
       
    i2cm_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();

    
       
    i2cm_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_ack_gen_clk_stretch();

    
    @ (negedge scl_fs_tb);
       
    i2cm_stop_gen();
       
    #10000000;



       
       
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 40: Clock stretching  - 7 bit addressing 3 byte Slave Write Operations
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 40: Clock stretching  - 7 bit addressing 3 byte Slave Write Operations ~~~~~~~~~~");
    
               
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;


    i2cm_start_gen();
       
    i2cm_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

           
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

          

    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();

    
    i2cm_stop_gen();
    
    #10000000;


       //$stop;
       
    
       	
    //--------------------------------------------------------------------------------------------------
    // Testcase 41: Clock stretching  - 10 bit addressing 4 byte Slave Read Operations
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 41: Clock stretching  - 10 bit addressing 4 byte Slave Read Operations ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                   
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    @ (negedge scl_fs_tb);

    i2cm_stop_gen();
    
    #10000000;

    addr_10bit_en_tb <= #1 1'b0; 
   
    //--------------------------------------------------------------------------------------------------
    // Testcase 42: Clock stretching  - 10 bit addressing 4 byte Slave Write Operations
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 42: Clock stretching  - 10 bit addressing 4 byte Slave write Operations ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();
       
        
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_start_gen();  
    
    i2cm_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

        
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    

    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

        
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();

 
    
    i2cm_stop_gen();
     
    #10000000;
 
    addr_10bit_en_tb <= #1 1'b0;    
     
	
    //---------------------------------------------------------------------------------------------------------------
    // Testcase 43: Clock stretching  - 7 bit addressing 4 byte Slave Read Read Operation with Repeated Start (R-R)
    //----------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 43: Clock stretching  - 7 bit addressing 4 byte Slave Read Read Operation with Repeated Start (R-R) ~~~~~~~~~~");
    
               
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
           
    i2cm_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen_clk_stretch();
       
           
    i2cm_write_data_clk_stretch(8'b00_11_00_10);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_00);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();


    i2cm_start_gen();                    // Repeated Start
           
    i2cm_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen_clk_stretch();

           
    i2cm_write_data_clk_stretch(8'b00_11_00_10);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_00);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();


    @ (negedge scl_fs_tb);
       
    i2cm_stop_gen();
       
    #10000000;

     

    //---------------------------------------------------------------------------------------------------------------
    // Testcase 44: Clock stretching  - 7 bit addressing 4 byte Slave Read Write Operation with Repeated Start (R-W)
    //---------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 44: Clock stretching  - 7 bit addressing 4 byte Slave Read Write Operation with Repeated Start (R-W) ~~~~~~~~~~");

                   
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
           
    i2cm_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen_clk_stretch();
       
           
    i2cm_write_data_clk_stretch(8'b00_11_00_10);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_00);    // Data
    i2cslave_ack_gen_clk_stretch();

       
    i2cm_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();


   

    i2cm_start_gen();                    // Repeated Start

    i2cm_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    
       
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join


    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();


    
    i2cm_stop_gen();
    
    #10000000;


    

    //---------------------------------------------------------------------------------------------------------------
    // Testcase 45: Clock stretching  - 7 bit addressing 4 byte Slave Write Read Operation with Repeated Start (W-R)
    //----------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 45: Clock stretching  - 7 bit addressing 4 byte Slave Write Read Operation with Repeated Start (W-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();                    

    i2cm_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

        
       
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b00_01_01_01;
    end
    join

       

    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();


    
    i2cm_start_gen();
           
    i2cm_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen_clk_stretch();
       

           
    i2cm_write_data_clk_stretch(8'b00_11_00_10);    // Data
    i2cslave_ack_gen_clk_stretch();


       
    i2cm_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();


       
    i2cm_write_data_clk_stretch(8'b10_11_00_00);    // Data
    i2cslave_ack_gen_clk_stretch();


       
    i2cm_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_ack_gen_clk_stretch();


    @ (negedge scl_fs_tb);

    i2cm_stop_gen();
    
    #10000000;


    
    //----------------------------------------------------------------------------------------------------------------
    // Testcase 46: Clock stretching  - 7 bit addressing 4 byte Slave Write Write Operation with Repeated Start (W-W)
    //------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 46: Clock stretching  - 7 bit addressing 4 byte Slave Write Write Operation with Repeated Start (W-W) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();                    

    i2cm_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

       
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_11_01_00;
    end
    join


    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join


    i2cm_read_data_clk_stretch();  
    i2cm_nack_gen();
    
    
    i2cm_start_gen();                    // Repeated Start

    i2cm_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    
       
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_11_01_00;
    end
    join

    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

    

    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();

       


    i2cm_stop_gen();
    
    #10000000;

      
       
         

    //------------------------------------------------------------------------------------------------------------------
    // Testcase 47: Clock stretching  - 10 bit addressing 4 byte Slave Read Read Operation with Repeated Start (R-R)
    //-------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 47: Clock stretching  - 10 bit addressing 4 byte Slave Read Read Operation with Repeated Start (R-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                   
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cm_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    @ (negedge scl_fs_tb);

    i2cm_stop_gen();
    
    #10000000;




    //---------------------------------------------------------------------------------------------------------------
    // Testcase 48: Clock stretching  - 10 bit addressing 4 byte Slave Read Write Operation with Repeated Start (R-W)
    //---------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 48: Clock stretching  - 10 bit addressing 4 byte Slave Read Write Operation with Repeated Start (R-W) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                   
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte

    addr_10bit_en_tb <= #1 1'b0;
       
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_ack_gen_clk_stretch();

    addr_10bit_en_tb <= #1 1'b1;
          
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

        
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b10_01_01_00;
    end
    join

    
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();


    
    i2cm_stop_gen();
    
    #10000000;
	
	//---------------------------------------------------------------------------------------------------------------
    // Testcase 49: Clock stretching  - 10 bit addressing 4 byte Slave Write Write Operation with Repeated Start (W-W)
    //-----------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 49: Clock stretching  - 10 bit addressing 4 byte Slave Write Write Operation with Repeated Start (W-W) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                    
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_start_gen();  
    
    i2cm_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

    
    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

        
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

        
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


        
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();

        
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_start_gen();  
    
    i2cm_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    
    
    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join

    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

        
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join

       
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();
       
    
    i2cm_stop_gen();

  #10000000; 
     
//---------------------------------------------------------------------------------------------------------------------
    // Testcase 50: Clock stretching  - 10 bit addressing 4 byte Slave Write Read Operation with Repeated Start (W-R)
    //------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 50: Clock stretching  - 10 bit addressing 4 byte Slave Write Read Operation with Repeated Start (W-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;


    i2cm_start_gen();                    
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte

    
       
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_start_gen();  
    
    i2cm_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    addr_10bit_en_tb <= #1 1'b0;
    
    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

       
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
       
    
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

     
    i2cm_read_data_clk_stretch();
    fork
    i2cm_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

        
    i2cm_read_data_clk_stretch();
    i2cm_nack_gen();
           
    addr_10bit_en_tb <= #1 1'b1;
       
    i2cm_start_gen();                    // Repeated Start
       
    i2cm_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen_clk_stretch();

    
    i2cm_write_data_clk_stretch(8'b01_10_01_00);     // Data1
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_write_data_clk_stretch(8'b01_10_01_01);     // Data2
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_write_data_clk_stretch(8'b11_10_01_00);     // Data3
    i2cslave_ack_gen_clk_stretch();

        
    i2cm_write_data_clk_stretch(8'b11_10_01_01);     // Data4
    i2cslave_ack_gen_clk_stretch();

    
       
    i2cm_stop_gen();

   #10000000;

	
    //--------------------------------------------------------------------------------------------------
    // Testcase 51: Clock stretching  - 7 bit addressing 4 byte Slave Read Operations in High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 51: Clock stretching  - 7 bit addressing 4 byte Slave Read Operations High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;


    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_hs_start_gen();
           
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

             
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

         
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

         
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

         
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

  
    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;
       
    
       
       
	 

    //--------------------------------------------------------------------------------------------------
    // Testcase 52: Clock stretching  - 7 bit addressing 3 byte Slave Write Operations in High Speed Mode
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 52: Clock stretching  - 7 bit addressing 3 byte Slave Write Operations in High Speed Mode ~~~~~~~~~~");
    
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
       
    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join
       

   
       
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end		
    join

    
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

        

    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;
       
    
       

    //----------------------------------------------------------------------------------------------------------------------------------
    // Testcase 53: Clock stretching  - 7 bit addressing 4 byte Slave Read Read Operations in High Speed Mode with Repeated Start (R-R) 
    //-----------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 53: Clock stretching  - 7 bit addressing 4 byte Slave Read Read Operations High Speed Mode with Repeated Start (R-R)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_hs_start_gen();
           
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

               
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_start_gen();
           
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
           
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

       
       

    //--------------------------------------------------------------------------------------------------------------------------------------
    // Testcase 54: Clock stretching  - 7 bit addressing 4 byte Slave Read Write Operations in High Speed Mode with Repeated Start (R-W) 
    //------------------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 54: Clock stretching  - 7 bit addressing 4 byte Slave Read Write Operations High Speed Mode with Repeated Start (R-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_hs_start_gen();
           
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

               
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join


           
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
    

    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

    

    //-----------------------------------------------------------------------------------------------------------------------------------------
    // Testcase 55: Clock stretching  - 7 bit addressing 4 byte Slave  Write Read Operations in High Speed Mode with Repeated Start (W-R) 
    //-----------------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 55: Clock stretching  - 7 bit addressing 4 byte Slave Write Read Operations High Speed Mode with Repeated Start (W-R)~~~~~~~~~~");
     
    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;


    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


       
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_start_gen();
           
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

           
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_10);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

       
    i2cm_hs_write_data_clk_stretch(8'b10_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

       
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_01);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

       
    i2cm_hs_write_data_clk_stretch(8'b00_11_00_00);    // Data
    i2cslave_hs_ack_gen_clk_stretch();

        
    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

    

    //-----------------------------------------------------------------------------------------------------------------------------------------
    // Testcase 56: Clock stretching  - 7 bit addressing 4 byte Slave Write Write Operations in High Speed Mode with Repeated Start (W-W) 
    //------------------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 56: Clock stretching  - 7 bit addressing 4 byte Slave Write Write Operations High Speed Mode with Repeated Start (W-W)~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();
    
    hs_mode_tb <= #1 1'b0;
       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    addr_10bit_en_tb <= #1 1'b0;                     // 7 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_10;

       
    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

           
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b01_01_01_01);     // Slave Address ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


       
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join



    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;

        
    #10000000;

    
       
    //--------------------------------------------------------------------------------------------------
    // Testcase 57: Clock stretching  - 10 bit addressing 4 byte Slave Read Operations in High Speed Mode 
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 57: Clock stretching  - 10 bit addressing 4 byte Slave Read Operations in High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;
       
    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();

           
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();



    i2cm_hs_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();



    i2cm_hs_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();



    i2cm_hs_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();


    @ (negedge scl_hs_tb);

    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
  
    
    #10000000;


      
         
    //-------------------------------------------------------------------------------------------------------
    // Testcase 58: Clock stretching  - 10 bit addressing 4 byte Slave Write Operations in High Speed Mode 
    //--------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 58: Clock stretching  - 10 bit addressing 4 byte Slave Write Operations in High Speed Mode ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();

    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

        
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join


  
    
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       

    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join



    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();


    
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
     
    #10000000;

    

    //---------------------------------------------------------------------------------------------------------------------------------
    // Testcase 59: Clock stretching  - 10 bit addressing 4 byte Slave Read Read Operations in High Speed Mode Repeated start (R-R)
    //----------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 59: Clock stretching  - 10 bit addressing 4 byte Slave Read Read Operations in High Speed Mode (R-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();
       
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

       
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    @ (negedge scl_hs_tb);

    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;
       


    //-------------------------------------------------------------------------------------------------------------------------------
    // Testcase 60: Clock stretching  - 10 bit addressing 4 byte Slave Read Write Operations in High Speed Mode Repeated start (R-W)
    //--------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 60: Clock stretching  - 10 bit addressing 4 byte Slave Read Write Operations in High Speed Mode (R-W) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();

    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_01);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_00);     // Data
    i2cslave_hs_ack_gen_clk_stretch();

          
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    
  

      
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join
       
    

    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join
       
    
    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();

    
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

    
      
    //---------------------------------------------------------------------------------------------------------------------------------
    // Testcase 61: Clock stretching  - 10 bit addressing 4 byte Slave Write Read Operations in High Speed Mode Repeated start (W-R)
    //---------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 61: Clock stretching  - 10 bit addressing 4 byte Slave Write Read Operations in High Speed Mode (W-R) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();

    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

        
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

    
    
 
    
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join

   
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join 
       
    

    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_00;
    end
    join
       
 
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_11_01_01;
    end
    join

    
    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();
           

    
    i2cm_hs_start_gen();                    // Repeated Start
       
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();


    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();


    i2cm_hs_write_data_clk_stretch(8'b01_10_01_00);     // Data1
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b01_10_01_01);     // Data2
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_00);     // Data3
    i2cslave_hs_ack_gen_clk_stretch();


    
    i2cm_hs_write_data_clk_stretch(8'b11_10_01_01);     // Data4
    i2cslave_hs_ack_gen();

    @ (negedge scl_hs_tb);
       
    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;
    
    #10000000;

          
       
    //----------------------------------------------------------------------------------------------------------------------------------
    // Testcase 62: Clock stretching  - 10 bit addressing 4 byte Slave Write Write Operations in High Speed Mode Repeated start (W-W)
    //------------------------------------------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 62: Clock stretching  - 10 bit addressing 4 byte Slave Write Write Operations in High Speed Mode (W-W) ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;                // 10 bit addressing
    slave_addr_tb <= #1 10'b00_00_10_10_00;

    hs_mode_tb <= #1 1'b1;

    i2cm_start_gen();

    i2cm_write_data_clk_stretch(8'b00_00_10_10);     // Master Code
    i2cslave_nack_gen();

    @(posedge scl_hs_tb);
            
    hs_mode_tb <= #1 1'b0;

    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_hs_start_gen();
    
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

        
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_01;
    end
    join

           
   
             
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b11_01_01_00;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();

    
    i2cm_hs_start_gen();                    // Repeated Start


    i2cm_hs_write_data_clk_stretch(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_hs_ack_gen_clk_stretch();


    i2cm_hs_write_data_clk_stretch(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_hs_ack_gen_clk_stretch();

    
    i2cm_hs_start_gen();  
    
    i2cm_hs_write_data_clk_stretch(8'b11_11_01_01);     // Slave Address 1st byte ,R/W-1
    fork
    i2cslave_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_01_01;
    end
    join


   
       
      
    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_11_01_01;
    end
    join


    i2cm_hs_read_data_clk_stretch();
    fork
    i2cm_hs_ack_gen_clk_stretch();
    begin
    @ (posedge data_request_tb);
    @ (posedge sys_clk_tb);
    @ (posedge sys_clk_tb);
    data_in_tb <= #1 8'b01_01_11_01;
    end
    join

    

    i2cm_hs_read_data_clk_stretch();
    i2cm_hs_nack_gen();



    i2cm_hs_stop_gen();

    hs_mode_tb <= #1 1'b0;

    hs_mode_clk <= #1 1'b0;

       
    #10000000;


    
    //--------------------------------------------------------------------------------------------------
    // Testcase 63: i_ack_busy  - 7 bit addressing - NACK during Address Phase
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 63: 7 bit addressing - NACK during Address Phase ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                // 7 bit addressing       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
    
    ack_busy_tb <= #1 1'b1;   
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();

    ack_busy_tb <= #1 1'b0;
    
    #10000000;


    //--------------------------------------------------------------------------------------------------
    // Testcase 64: i_ack_busy  - 7 bit addressing - NACK during Data Read Phase
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 64: 7 bit addressing - NACK during Data Read Phase ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b0;                // 7 bit addressing       
    slave_addr_tb <= #1 10'b00_00_10_10_10;

    i2cm_start_gen();
    
    i2cm_write_data(8'b01_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();

    
    i2cm_write_data(8'b10_11_00_10);
    i2cslave_ack_gen();

    ack_busy_tb <= #1 1'b1;

       
    i2cm_write_data(8'b10_11_00_01);
    i2cslave_ack_gen();

    ack_busy_tb <= #1 1'b0;

    
       
    #10000000;



    //--------------------------------------------------------------------------------------------------
    // Testcase 65: i_ack_busy  - 10 bit addressing - NACK during First Address Phase
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 65: 10 bit addressing - NACK during First Address Phase ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();  
                 
    ack_busy_tb <= #1 1'b1;       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    
    ack_busy_tb <= #1 1'b0;
       
    #10000000;



    //--------------------------------------------------------------------------------------------------
    // Testcase 66: i_ack_busy  - 10 bit addressing - NACK during Second Address Phase
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 66: 10 bit addressing - NACK during Second Address Phase ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();  
                 
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();
       
    ack_busy_tb <= #1 1'b1;       
    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    ack_busy_tb <= #1 1'b0;       
    
    #10000000;


       
    //--------------------------------------------------------------------------------------------------
    // Testcase 67: i_ack_busy  - 10 bit addressing - NACK during Data Read Phase
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 67: 10 bit addressing - NACK during Data Read Phase ~~~~~~~~~~");

    addr_10bit_en_tb <= #1 1'b1;
    slave_addr_tb <= #1 10'b10_10_11_01_00;

    i2cm_start_gen();                   
       
    i2cm_write_data(8'b11_11_01_00);     // Slave Address 1st byte ,R/W-0
    i2cslave_ack_gen();

    i2cm_write_data(8'b10_11_01_00);     // Slave Address 2nd byte 
    i2cslave_ack_gen();

    ack_busy_tb <= #1 1'b1;       
    i2cm_write_data(8'b01_10_01_01);     // Data
    i2cslave_ack_gen();


    ack_busy_tb <= #1 1'b0;       
    
    #10000000;

       
    //--------------------------------------------------------------------------------------------------
    // Testcase 68 :  Providing invalid address for negative testing
    //--------------------------------------------------------------------------------------------------
    $display("~~~~~~~~~~ Testcase 68: Providing invalid address for negative testing ~~~~~~~~~~");       

    addr_10bit_en_tb <= #1 1'b0;                // 7 bit addressing       
    slave_addr_tb <= #1 10'b00_00_10_10_10;
    
    negative_testing_i <= 1'b1;
       
    i2cm_start_gen();
       
    i2cm_write_data(8'b11_01_01_00);     // Slave Address ,R/W-0
    i2cslave_ack_gen();
       
    i2cm_write_data(MASTER_WRITE_DATA);
    i2cslave_ack_gen();
       
    i2cm_stop_gen();

    negative_testing_i <= 1'b0;   

    #10000000;
 	
    if (err_count_i ==0)
        $display("SBT_PASS");
    else
        $display("SBT_FAIL");

    #100;
      
   
 $stop;



  
 
  
    end
 
endtask
   