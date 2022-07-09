module magnitude_approx 

#(parameter DATA_WIDTH = 16,
  parameter ALPHA = 1,          //common choice for BETA and ALPHA
  parameter BETA = 3/8 
)  
(
    input  signed [DATA_WIDTH - 1 : 0] i_Re,
    input  signed [DATA_WIDTH - 1 : 0] i_Im,
    input                              i_clk,
    input                              i_rst,
    output        [DATA_WIDTH - 1 : 0] o_mag_approx
);

    reg signed [DATA_WIDTH - 1 : 0] Re_ff,  Im_ff;
    wire       [DATA_WIDTH - 1 : 0] Re_abs, Im_abs;
    reg        [DATA_WIDTH - 1 : 0] mag_approx_ff;

    // input flip-flops
    always @(posedge i_clk) begin
        if (i_rst) begin
            Re_ff <= 0;
            Im_ff <= 0;
        end else begin
            Re_ff <= i_Re;
            Im_ff <= i_Im;
        end
    end

    assign Re_abs = (Re_ff >= 0) ? Re_ff : (-Re_ff);
    assign Im_abs = (Im_ff >= 0) ? Im_ff : (-Im_ff);

    always @(posedge i_clk) begin
        if (i_rst) begin 
            mag_approx_ff <= 0;
        end else begin
            if (Re_abs >= Im_abs) begin
                mag_approx_ff <= Re_abs * ALPHA + ((Im_abs >> 3) * 3);           // for BETA = 3/8 use multiply and right shift by 3
            end else begin
                mag_approx_ff <= Im_abs * ALPHA + ((Re_abs >> 3) * 3); 
            end
        end
    end

    assign o_mag_approx = mag_approx_ff;


endmodule