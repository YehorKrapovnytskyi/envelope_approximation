
# Delete old compilation results
transcript on
if { [file exists work] } {
    vdel -all
}

set models_dir "../models"

set design_dir "$models_dir/design" 
set verification_dir "$models_dir/verification"

# Create working library
vlib work

# Compile all the Verilog sources in current folder into working library

vlog $design_dir/*.v
vlog $verification_dir/sv/test_package.sv
vlog $verification_dir/sv/*.sv 
vlog $verification_dir/c/*.c -dpiheader $verification_dir/h/dpiheader.h 

# Open testbench module for simulation

vsim -t 1ns -voptargs=+acc top

# Add all testbench signals to waveform diagram

add wave  /top/env_approx_inst0/ext_integrator_inst0/*

onbreak resume

configure wave -timelineunits us
# Run simulation
run -all

wave zoom full



