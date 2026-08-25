`include "defines.svh"
class env;
  
  virtual apb_master_if.INP_DRV inp_drv_vif;
  virtual apb_master_if.INP_MON inp_mon_vif;
  virtual apb_master_if.OUT_MON out_mon_vif;
  
  generator gen;
  input_driver drv;
  input_monitor inp_mon;
  output_monitor out_mon;
  ref_model ref_sb;
  scoreboard scb;
  
  //g -> drv
  mailbox #(transaction)mbx_g_d;
  
  //inp_monior -> ref_model
  mailbox #(transaction)mbx_im_rf;
  
  //ref_model -> scoreboard
  mailbox #(transaction)mbx_rf_s;
  
  //out_monitor -> scoreboard
  mailbox #(transaction)mbx_om_s;
  
  function new(
    virtual apb_master_if.INP_DRV inp_drv_vif,
    virtual apb_master_if.INP_MON inp_mon_vif,
    virtual apb_master_if.OUT_MON out_mon_vif
  );
    
    this.inp_drv_vif = inp_drv_vif;
    this.inp_mon_vif = inp_mon_vif;
    this.out_mon_vif = out_mon_vif;
    
  endfunction
  
  task build();
    
    mbx_g_d = new();
    mbx_im_rf = new();
    mbx_rf_s = new();
    mbx_om_s = new();
    
    gen=new(mbx_g_d);
    drv=new(inp_drv_vif,mbx_g_d);
    inp_mon=new(inp_mon_vif,mbx_im_rf);
    out_mon=new(out_mon_vif,mbx_om_s);
    ref_sb=new(mbx_im_rf,mbx_rf_s);
    scb=new(mbx_rf_s,mbx_om_s);
    
  endtask
  
  task start();
    
    fork
      gen.start();
      drv.start();
      inp_mon.start();
      out_mon.start();
      ref_sb.start();
    join
      scb.final_count();
    
  endtask
endclass
