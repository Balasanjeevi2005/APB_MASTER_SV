`include "apb_rtl.sv"
`include "apb_master_if.sv"
//`include "test_pkg.sv"

module top();
  import test_pkg ::*;

  bit presetn;
  bit pclk;
  
  initial begin 
    pclk=0;
  end
  
  initial begin
    forever #10 pclk=~pclk;
  end
  
  initial begin
    presetn=0;
    repeat(5)@(posedge pclk);
    #1;
    presetn=1;
    repeat(160) begin
      repeat(50)@(posedge pclk);
      #1;
      presetn=0;
      repeat(5)@(posedge pclk);
      #1;
      presetn=1;
    end
  end
  apb_master_if vif(pclk,presetn);
  apb_master DUV(.PADDR(vif.paddr),.PSEL(vif.psel),.PENABLE(vif.penable),.PWRITE(vif.pwrite),.PWDATA(vif.pwdata),.PSTRB(vif.pstrb),.PRDATA(vif.prdata),.PREADY(vif.pready),.PSLVERR(vif.pslverr),.transfer(vif.transfer),.write_read(vif.write_read),.addr_in(vif.addr_in),.wdata_in(vif.wdata_in),.strb_in(vif.strb_in),.rdata_out(vif.rdata_out),.transfer_done(vif.transfer_done),.error(vif.error),.PCLK(pclk),.PRESETn(presetn));
  //test1 t1=new(vif.INP_DRV,vif.INP_MON,vif.OUT_MON);
  //test2 t2=new(vif.INP_DRV,vif.INP_MON,vif.OUT_MON);
  //test3 t3=new(vif.INP_DRV,vif.INP_MON,vif.OUT_MON);
  //test4 t4=new(vif.INP_DRV,vif.INP_MON,vif.OUT_MON);
  regression_test rt = new(vif.INP_DRV,vif.INP_MON,vif.OUT_MON);
  
  initial begin
    //t1.run();
    //t2.run();
    //t3.run();
   // t4.run();
   rt.run();
   $finish();
  end

endmodule
