class input_driver;
  
  virtual apb_master_if.INP_DRV vif;
  mailbox#(transaction)mbx_g_d;
  transaction trans;
  covergroup cg;
    PRDATA:coverpoint trans.prdata{bins rd={[0:$]};}
    PREADY:coverpoint trans.pready{bins ry[]={0,1};}
    TRANSFER:coverpoint trans.transfer{bins t[]={0,1};}
    WRITE_READ:coverpoint trans.write_read{bins wr[]={0,1};}
    PADDR:coverpoint trans.paddr{bins ra={[0:$]};}
    PWDATA:coverpoint trans.pwdata{bins wd={[0:$]};}
    PSTRB:coverpoint trans.pstrb{bins sd[]={[0:$]};}
    PSLVERR:coverpoint trans.pslverr{bins se[]={0,1};}
  endgroup
  function new(virtual apb_master_if.INP_DRV vif,
               mailbox#(transaction)mbx_g_d
              );
    
    this.vif=vif;
    this.mbx_g_d=mbx_g_d;
    cg=new();
  endfunction
  
  task start();
    
    repeat(1)@(vif.inp_drv_cb);
    for(int i=0;i<`NO_TRANS;i++)begin
      mbx_g_d.get(trans);
      vif.inp_drv_cb.pslverr   <= trans.pslverr;
      vif.inp_drv_cb.pready    <= trans.pready;
      vif.inp_drv_cb.transfer  <= trans.transfer;
      vif.inp_drv_cb.write_read<= trans.write_read;
      vif.inp_drv_cb.addr_in   <= trans.addr_in;
      vif.inp_drv_cb.wdata_in  <= trans.wdata_in;
      vif.inp_drv_cb.strb_in   <= trans.strb_in;
      vif.inp_drv_cb.prdata    <= trans.prdata;
      cg.sample();
    
      repeat(1)@(vif.inp_drv_cb);
      $display("drived signals[%0d]:",i);
      $display("t=%0d|PSLVERR=%0d,PREADY=%0d,TRANSFER=%0d,WRITE_READ=%0d,PADDR=%0d,PWDATA=%0d;PSTRB=%0d,PRDATA=%0d",$time,trans.pslverr,trans.pready,trans.transfer,trans.write_read,trans.addr_in,trans.wdata_in,trans.strb_in,trans.prdata);
    end
  endtask
endclass
    
