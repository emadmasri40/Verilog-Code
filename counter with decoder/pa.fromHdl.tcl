
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name decoder -dir "E:/Xilinx/New folder/new/decoder/planAhead_run_4" -part xc7a100tcsg324-3
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "tb1.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {decoter.v}]]
set_property file_type Verilog $hdlfile
set_property library work $hdlfile
set_property top decoter $srcset
add_files [list {tb1.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc7a100tcsg324-3
