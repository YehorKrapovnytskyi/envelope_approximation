`timescale 1ns/1ps

module top;


    localparam DATA_WIDTH = 16;



    real sin;
    real cos;
    real sin_square;

    logic                             i_rst;
    logic signed [DATA_WIDTH - 1 : 0] digital_cos; 
    logic signed [DATA_WIDTH - 1 : 0] digital_sin;
    logic signed [DATA_WIDTH - 1 : 0] re_data; 
    logic signed [DATA_WIDTH - 1 : 0] im_data;



    logic                             clk;
    logic        [DATA_WIDTH - 1 : 0] o_env_approx;
    logic                             square_pulse;
    logic                             clock_enable;
    
    

    //verification modules
    clock_gen #(.FREQ(100000))clock_gen_inst0 (
        .enable(clock_enable),
        .clk(clk)
    );     


    //sine/cos generation
    sine_cos_gen #(.FREQ(1000), .SAMPLING_TIME(5), .AMPLITUDE(1)) sine_gen_inst0 (
        .sin_out(sin),
        .cos_out(cos)
    );

    assign digital_cos = cos * (2 ** (DATA_WIDTH - 1) - 1);
    assign digital_sin = sin * (2 ** (DATA_WIDTH - 1) - 1);

    //square pulse generation
    sine_cos_gen #(.FREQ(200), .SAMPLING_TIME(5), .AMPLITUDE(1)) sine_gen_inst1 (
        .sin_out(sin_square),
        .cos_out()
    );

    assign square_pulse = (sin_square > 0) ? 1 : 0;

    //re and im data
    assign re_data = square_pulse * digital_cos;
    assign im_data = square_pulse * digital_sin;


    //design modules 
    envelope_approximation env_approx_inst0 (
        .i_Re(re_data),
        .i_Im(im_data),
        .i_clk(clk),
        .i_rst(i_rst),
        .o_env_approx(o_env_approx)
    );

    initial begin
        i_rst = 1;
        clock_enable = 0;
        #5;
        clock_enable = 1;
        #10;
        i_rst = 0;
        #10000000;
        $finish;
    end

endmodule