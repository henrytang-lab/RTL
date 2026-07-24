
`timescale 1 ps / 1 ps

module reset_manager
  #
  (
   // Parameter for reference clock
   parameter REF_CLOCK_VALUE_I = 48_000_000,

   // Parameter for MIPI IP reset duration in micro seconds.
   parameter MIPI_IP_RESET_LOW_TIME_IN_MS_I = 500
  )
  (
    input      clk,
    input      reset_n,

    input      cam_app_en_i,

    output reg mipi_reset_n_o,
    output     reset_counter_is_low_o,
    output     reset_counter_is_high_o

  );

//----------------------------------
//
// Local Parameters
//
//----------------------------------

  // Maximum value of counter
  localparam RESET_COUNTER_MAX_VALUE = ( ( REF_CLOCK_VALUE_I/32'd1_000 ) * (MIPI_IP_RESET_LOW_TIME_IN_MS_I) );

  // Logic Low Value
  localparam LOW  = 1'b0;

  // Logic High Value
  localparam HIGH = 1'b1;
  
//----------------------------------
//
// Local Variables
//
//----------------------------------

  reg  [31:0] reset_counter;

//----------------------------------
//
// Reset Counter
//
//----------------------------------

  always @ ( posedge clk or negedge reset_n )
    begin
      if ( ~reset_n )
        begin
          reset_counter <= 32'd0;
        end
      else if ( cam_app_en_i )
        begin
          reset_counter <= 32'd0;
        end
    end

  assign reset_counter_is_low_o  = ( reset_counter == 1'd0 );
  assign reset_counter_is_high_o = ( reset_counter == RESET_COUNTER_MAX_VALUE );

//----------------------------------
//
// Reset
//
//----------------------------------

  always @ ( posedge clk or negedge reset_n )
    begin
      if ( ~reset_n )
        begin
          mipi_reset_n_o <= LOW;
        end
      else if ( ( cam_app_en_i ) |
                ( ( ~cam_app_en_i ) & ( reset_counter == RESET_COUNTER_MAX_VALUE ) )
              )
        begin
          mipi_reset_n_o <= HIGH;
        end
      else
        begin
          mipi_reset_n_o <= cam_app_en_i;
        end
    end

endmodule

