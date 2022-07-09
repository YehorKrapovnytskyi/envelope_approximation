module exp_integrator
#(parameter DATA_WIDTH = 16)
(
    input  [DATA_WIDTH - 1 : 0] i_data,
    input                       i_clk,
    input                       i_rst,
    output [DATA_WIDTH - 1 : 0] o_data
);

    localparam ALPHA  = 3/4;
    localparam FEEDBACK_ALPHA = 1/4;

    wire [DATA_WIDTH - 1 : 0] scaled_input;
    reg  [DATA_WIDTH - 1 : 0] accum_ff;
    reg  [DATA_WIDTH - 1 : 0] data_ff;
    wire [DATA_WIDTH - 1 : 0] accum_scaled;

    assign scaled_input = (data_ff >> 2) * 3;        // muliply input by ALPHA
    assign accum_scaled = accum_ff >> 2;

    always @(posedge i_clk) begin
        if (i_rst) begin
            accum_ff <= 0;
            data_ff <= 0;
        end else begin
            accum_ff <= scaled_input + accum_scaled; //multiply by FEEDBACK_ALPHA
            data_ff <= i_data; 
        end
    end

    assign o_data = accum_ff;


endmodule