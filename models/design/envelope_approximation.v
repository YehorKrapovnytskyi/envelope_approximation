module envelope_approximation 
#(parameter DATA_WIDTH = 16)  
(
    input  signed [DATA_WIDTH - 1 : 0] i_Re,
    input  signed [DATA_WIDTH - 1 : 0] i_Im,
    input                              i_clk,
    input                              i_rst,
    output        [DATA_WIDTH - 1 : 0] o_env_approx
);

    wire [DATA_WIDTH - 1 : 0] mag_approx;

    // design modules instantiation
    magnitude_approx mag_approx_inst0 (
        .i_Re(i_Re),
        .i_Im(i_Im),
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_mag_approx(mag_approx)
    );

    exp_integrator ext_integrator_inst0 (
        .i_data(mag_approx),
        .i_clk(i_clk),
        .i_rst(i_rst),
        .o_data(o_env_approx)
    );


endmodule