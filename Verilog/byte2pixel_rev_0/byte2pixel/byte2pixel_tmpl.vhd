--VHDL instantiation template

component byte2pixel is
    port (byte2pixel_rev_1_dt_i: in std_logic_vector(5 downto 0);
        byte2pixel_rev_1_p_odd_o: out std_logic_vector(1 downto 0);
        byte2pixel_rev_1_payload_i: in std_logic_vector(15 downto 0);
        byte2pixel_rev_1_pd_o: out std_logic_vector(7 downto 0);
        byte2pixel_rev_1_wc_i: in std_logic_vector(15 downto 0);
        byte2pixel_rev_1_clk_byte_i: in std_logic;
        byte2pixel_rev_1_clk_pixel_i: in std_logic;
        byte2pixel_rev_1_fv_o: out std_logic;
        byte2pixel_rev_1_lp_av_en_i: in std_logic;
        byte2pixel_rev_1_lv_o: out std_logic;
        byte2pixel_rev_1_payload_en_i: in std_logic;
        byte2pixel_rev_1_reset_byte_n_i: in std_logic;
        byte2pixel_rev_1_reset_pixel_n_i: in std_logic;
        byte2pixel_rev_1_sp_en_i: in std_logic
    );
    
end component byte2pixel; -- sbp_module=true 
_inst: byte2pixel port map (byte2pixel_rev_1_dt_i => __,byte2pixel_rev_1_p_odd_o => __,
            byte2pixel_rev_1_payload_i => __,byte2pixel_rev_1_pd_o => __,byte2pixel_rev_1_wc_i => __,
            byte2pixel_rev_1_clk_byte_i => __,byte2pixel_rev_1_clk_pixel_i => __,
            byte2pixel_rev_1_fv_o => __,byte2pixel_rev_1_lp_av_en_i => __,
            byte2pixel_rev_1_lv_o => __,byte2pixel_rev_1_payload_en_i => __,
            byte2pixel_rev_1_reset_byte_n_i => __,byte2pixel_rev_1_reset_pixel_n_i => __,
            byte2pixel_rev_1_sp_en_i => __);
