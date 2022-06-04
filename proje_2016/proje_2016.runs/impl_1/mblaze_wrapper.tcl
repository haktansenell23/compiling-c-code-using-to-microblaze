proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.cache/wt [current_project]
  set_property parent.project_path C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.xpr [current_project]
  set_property ip_repo_paths c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.cache/ip [current_project]
  set_property ip_output_repo c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.runs/synth_1/mblaze_wrapper.dcp
  add_files C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/mblaze.bmm
  set_property SCOPED_TO_REF mblaze [get_files -all C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/mblaze.bmm]
  add_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_0/data/mb_bootloop_le.elf
  set_property SCOPED_TO_REF mblaze [get_files -all c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_0/data/mb_bootloop_le.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_0/data/mb_bootloop_le.elf]
  read_xdc -ref mblaze_microblaze_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_0/mblaze_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_0/mblaze_microblaze_0_0.xdc]
  read_xdc -ref mblaze_dlmb_v10_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_dlmb_v10_0/mblaze_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_dlmb_v10_0/mblaze_dlmb_v10_0.xdc]
  read_xdc -ref mblaze_ilmb_v10_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_ilmb_v10_0/mblaze_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_ilmb_v10_0/mblaze_ilmb_v10_0.xdc]
  read_xdc -ref mblaze_microblaze_0_axi_intc_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_axi_intc_0/mblaze_microblaze_0_axi_intc_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_axi_intc_0/mblaze_microblaze_0_axi_intc_0.xdc]
  read_xdc -ref mblaze_mdm_1_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mdm_1_0/mblaze_mdm_1_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mdm_1_0/mblaze_mdm_1_0.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_clk_wiz_1_0 -cells inst c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_clk_wiz_1_0/mblaze_clk_wiz_1_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_clk_wiz_1_0/mblaze_clk_wiz_1_0_board.xdc]
  read_xdc -ref mblaze_clk_wiz_1_0 -cells inst c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_clk_wiz_1_0/mblaze_clk_wiz_1_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_clk_wiz_1_0/mblaze_clk_wiz_1_0.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_rst_clk_wiz_1_100M_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_clk_wiz_1_100M_0/mblaze_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_clk_wiz_1_100M_0/mblaze_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref mblaze_rst_clk_wiz_1_100M_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_clk_wiz_1_100M_0/mblaze_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_clk_wiz_1_100M_0/mblaze_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -ref mblaze_mig_7series_0_1 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mig_7series_0_1/mblaze_mig_7series_0_1/user_design/constraints/mblaze_mig_7series_0_1.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mig_7series_0_1/mblaze_mig_7series_0_1/user_design/constraints/mblaze_mig_7series_0_1.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_mig_7series_0_1 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mig_7series_0_1/mblaze_mig_7series_0_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mig_7series_0_1/mblaze_mig_7series_0_1_board.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_rst_mig_7series_0_81M_1 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_mig_7series_0_81M_1/mblaze_rst_mig_7series_0_81M_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_mig_7series_0_81M_1/mblaze_rst_mig_7series_0_81M_1_board.xdc]
  read_xdc -ref mblaze_rst_mig_7series_0_81M_1 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_mig_7series_0_81M_1/mblaze_rst_mig_7series_0_81M_1.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_rst_mig_7series_0_81M_1/mblaze_rst_mig_7series_0_81M_1.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_axi_uartlite_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_uartlite_0_0/mblaze_axi_uartlite_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_uartlite_0_0/mblaze_axi_uartlite_0_0_board.xdc]
  read_xdc -ref mblaze_axi_uartlite_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_uartlite_0_0/mblaze_axi_uartlite_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_uartlite_0_0/mblaze_axi_uartlite_0_0.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_axi_gpio_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_gpio_0_0/mblaze_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_gpio_0_0/mblaze_axi_gpio_0_0_board.xdc]
  read_xdc -ref mblaze_axi_gpio_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_gpio_0_0/mblaze_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_gpio_0_0/mblaze_axi_gpio_0_0.xdc]
  read_xdc -ref mblaze_axi_timer_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_timer_0_0/mblaze_axi_timer_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_timer_0_0/mblaze_axi_timer_0_0.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_axi_ethernetlite_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0_board.xdc]
  read_xdc -ref mblaze_axi_ethernetlite_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0.xdc]
  read_xdc -prop_thru_buffers -ref mblaze_mii_to_rmii_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mii_to_rmii_0_0/mblaze_mii_to_rmii_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_mii_to_rmii_0_0/mblaze_mii_to_rmii_0_0_board.xdc]
  read_xdc C:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/constrs_1/new/constr.xdc
  read_xdc -ref mblaze_microblaze_0_axi_intc_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_axi_intc_0/mblaze_microblaze_0_axi_intc_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_microblaze_0_axi_intc_0/mblaze_microblaze_0_axi_intc_0_clocks.xdc]
  read_xdc -ref mblaze_axi_ethernetlite_0_0 -cells U0 c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_axi_ethernetlite_0_0/mblaze_axi_ethernetlite_0_0_clocks.xdc]
  read_xdc -ref mblaze_auto_cc_0 -cells inst c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_cc_0/mblaze_auto_cc_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_cc_0/mblaze_auto_cc_0_clocks.xdc]
  read_xdc -ref mblaze_auto_us_0 -cells inst c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_us_0/mblaze_auto_us_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_us_0/mblaze_auto_us_0_clocks.xdc]
  read_xdc -ref mblaze_auto_us_1 -cells inst c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_us_1/mblaze_auto_us_1_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/senel/micro_blaze.xpr/proje_2016/proje_2016.srcs/sources_1/bd/mblaze/ip/mblaze_auto_us_1/mblaze_auto_us_1_clocks.xdc]
  link_design -top mblaze_wrapper -part xc7a100tcsg324-1
  write_hwdef -file mblaze_wrapper.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force mblaze_wrapper_opt.dcp
  report_drc -file mblaze_wrapper_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force mblaze_wrapper_placed.dcp
  report_io -file mblaze_wrapper_io_placed.rpt
  report_utilization -file mblaze_wrapper_utilization_placed.rpt -pb mblaze_wrapper_utilization_placed.pb
  report_control_sets -verbose -file mblaze_wrapper_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force mblaze_wrapper_routed.dcp
  report_drc -file mblaze_wrapper_drc_routed.rpt -pb mblaze_wrapper_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file mblaze_wrapper_timing_summary_routed.rpt -rpx mblaze_wrapper_timing_summary_routed.rpx
  report_power -file mblaze_wrapper_power_routed.rpt -pb mblaze_wrapper_power_summary_routed.pb -rpx mblaze_wrapper_power_routed.rpx
  report_route_status -file mblaze_wrapper_route_status.rpt -pb mblaze_wrapper_route_status.pb
  report_clock_utilization -file mblaze_wrapper_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

