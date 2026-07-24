module spi_top(
    input wire reset_i,
    input wire i_send_data,    // Input signal to control sending data
    output wire led0, led1, led2, led3, led4, led5, led6, led7,
    output wire w_Clk,
    output wire spi_clk_o,
    output wire spi_mosi_o
);

    // Internal Oscillator
    defparam OSCH_inst.NOM_FREQ = "20.46";  // Set to the correct frequency
    OSCH OSCH_inst (
        .STDBY(1'b0),    // 0=Enabled, 1=Disabled also Disabled with Bandgap=OFF
        .OSC(w_Clk),
        .SEDSTDBY()        // This signal is not required if not using SED - see TN1199 for more details.
    );
    
    // Data to be sent over SPI
    reg [7:0] HELLO_WORLD [0:12];
    initial begin
        HELLO_WORLD[0]  = 8'h48; // H
        HELLO_WORLD[1]  = 8'h65; // e
        HELLO_WORLD[2]  = 8'h6C; // l
        HELLO_WORLD[3]  = 8'h6C; // l
        HELLO_WORLD[4]  = 8'h6F; // o
        HELLO_WORLD[5]  = 8'h20; //  
        HELLO_WORLD[6]  = 8'h57; // W
        HELLO_WORLD[7]  = 8'h6F; // o
        HELLO_WORLD[8]  = 8'h72; // r
        HELLO_WORLD[9]  = 8'h6C; // l
        HELLO_WORLD[10] = 8'h64; // d
        HELLO_WORLD[11] = 8'h21; // !
        HELLO_WORLD[12] = 8'h00; // Null terminator (optional)
    end

    // Internal signal declarations
    reg [3:0] byte_index = 0;
    reg [7:0] m_tdat = 8'b00000000;
    reg m_tvalid = 1'b0;
    wire m_tready;
    wire m_rxdv;
    wire [7:0] m_rxdata;
    reg sending = 0;

    // SPI Master Instantiation
    SPI_Master #(
        .SPI_MODE(0),                    // SPI Mode 0 (CPOL = 0, CPHA = 0)
        .CLKS_PER_HALF_BIT(2)            // Clock divider: 2 (20.46 MHz / 2 = 10.23 MHz SCLK)
    ) spi_inst (
        .i_Rst_L(~reset_i),             // SPI Master active low reset
        .i_Clk(w_Clk),                 // System Clock
        .i_TX_Byte(m_tdat),           // Byte to be transmitted
        .i_TX_DV(m_tvalid),           // Data valid signal
        .o_TX_Ready(m_tready),       // Indicates ready for the next byte
        .o_RX_DV(m_rxdv),            // Data valid signal for received byte
        .o_RX_Byte(m_rxdata),       // Received byte
        .o_SPI_Clk(spi_clk_o),      // SPI Clock Output
        .i_SPI_MISO(),    // SPI MISO Input
        .o_SPI_MOSI(spi_mosi_o)     // SPI MOSI Output
    );

    // SPI Transaction Control
    always @(posedge w_Clk or posedge reset_i) begin
        if (reset_i) begin
            byte_index <= 0;
            m_tdat <= 8'b00000000;
            m_tvalid <= 1'b0;
            sending <= 0;
        end else begin
            if (i_send_data == 0 && !sending) begin
                sending <= 1;
                byte_index <= 0;
            end else if (i_send_data == 1) begin
                sending <= 0;
                byte_index <= 0;
            end

            if (sending && byte_index <= 12) begin
                if (!m_tvalid && m_tready) begin
                    m_tdat <= HELLO_WORLD[byte_index];
                    m_tvalid <= 1'b1;  // Start the transaction
                end else if (m_tready && m_tvalid) begin
                    m_tvalid <= 1'b0;  // End the transaction
                    byte_index <= byte_index + 1;
                    if (byte_index > 12) begin
                        sending <= 0;
                        byte_index <= 0;
                    end
                end
            end
        end
    end

    // LED Indicators
    assign led0 = reset_i;          // Indicates the reset state (active high)
    assign led1 = ~m_tvalid;       // TX valid status (Inverted)
    assign led2 = m_rxdv;          // RX data valid (Shows when data is received)
    assign led3 = 1'b1;           // Constant high for debugging
    assign led4 = 1'b1;           // Constant high for debugging
    assign led5 = 1'b1;           // Constant high for debugging
    assign led6 = 1'b1;           // Constant high for debugging
    assign led7 = 1'b0;           // Constant low for debugging

endmodule
