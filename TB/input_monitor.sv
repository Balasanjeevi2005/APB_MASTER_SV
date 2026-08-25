class input_monitor;
  transaction trans;
  virtual apb_master_if.INP_MON vif;
  mailbox#(transaction)mbx_im_rf;
  
  function new(virtual apb_master_if.INP_MON vif,
               mailbox#(transaction)mbx_im_rf
              );
    this.vif=vif;
    this.mbx_im_rf=mbx_im_rf;
  endfunction
  
  task start();
    @(vif.inp_mon_cb);
    for(int i=0;i<`NO_TRANS;i++)begin
      @(vif.inp_mon_cb);
      trans=new();
      trans.presetn    = vif.inp_mon_cb.presetn;
      trans.pslverr    = vif.inp_mon_cb.pslverr;
      trans.pready     = vif.inp_mon_cb.pready;
      trans.transfer   = vif.inp_mon_cb.transfer;
      trans.write_read = vif.inp_mon_cb.write_read;
      trans.addr_in    = vif.inp_mon_cb.addr_in;
      trans.wdata_in   = vif.inp_mon_cb.wdata_in;
      trans.strb_in    = vif.inp_mon_cb.strb_in;
      trans.prdata     = vif.inp_mon_cb.prdata;
      $display("t=%0d|trans_no=%0d|input monitor value:presetn=%0d,pslverr=%0d,transfer=%0d,write_read=%0d,pready=%0d,paddr=%0h,pwdata=%0h,pstrb=%0d,prdata=%0h",$time,i,trans.presetn,trans.pslverr,trans.transfer,trans.write_read,trans.pready,trans.addr_in,trans.wdata_in,trans.strb_in,trans.prdata);
		
    end
  endtask
  
endclass
