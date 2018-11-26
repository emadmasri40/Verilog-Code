
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name decoder -dir "E:/Xilinx/New folder/new/decoder/planAhead_run_1" -part xc7a100tcsg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "E:/Xilinx/New folder/new/decoder/decoter.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {E:/Xilinx/New folder/new/decoder} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "tb1.ucf" [current_fileset -constrset]
add_files [list {tb1.ucf}] -fileset [get_property constrset [current_run]]
link_design
