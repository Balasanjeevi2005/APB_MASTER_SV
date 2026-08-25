`include "defines.svh"
interface apb_master_if(input logic pclk,input logic presetn);
 
  //INPUTS
  
  logic pslverr;
  logic pready;
  logic transfer;
  logic write_read;
  
  logic [`ADDR_WIDTH-1:0]paddr;
  logic [`DATA_WIDTH-1:0]pwdata;
  logic [(`DATA_WIDTH/8)-1:0]pstrb;
  logic [`DATA_WIDTH-1:0]prdata;
  
  //OUTPUTS
  logic error;
  logic penable;
  logic transfer_done;
  logic pwrite;
  
  logic [`ADDR_WIDTH-1:0]addr_in;
  logic [`DATA_WIDTH-1:0]wdata_in;
  logic [(`DATA_WIDTH/8)-1:0]strb_in;
  logic [`DATA_WIDTH-1:0]rdata_out;
  
  logic psel;
  
  clocking inp_drv_cb@(posedge pclk);
    default input #0 output #0;
    input presetn;
    output prdata,pready,pslverr,transfer,write_read,addr_in,wdata_in,strb_in;
  endclocking
  
  clocking inp_mon_cb@(posedge pclk);
    default input #0 output #0;
    input presetn,prdata,pready,pslverr,transfer,write_read,addr_in,wdata_in,strb_in;
	endclocking
  
  clocking out_mon_cb@(posedge pclk);
    default input #0 output #0;
    input presetn,paddr,psel,penable,pwrite,pwdata,pstrb,rdata_out,transfer_done,error;
  endclocking
  
  modport INP_DRV(clocking inp_drv_cb);
  modport INP_MON(clocking inp_mon_cb);
  modport OUT_MON(clocking out_mon_cb);
    
    idle_setup:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      ((!psel)&&(!penable)&&(transfer))|=>((psel)&&(!penable))
    )
    else
      $error("t=%0d|fail:idle->setup",$time);
      
    setup_access:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      ((psel)&&(!penable))|=>((psel)&&(penable))
    )
    else
      $error("t=%0d|fail:setup->access",$time);
      
    access_setup:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      ((psel)&&(penable)&&(transfer)&&(pready))|=>((psel)&&(!penable))
    )
    else
      $error("t=%0d|fail:access->setup",$time);
      
    access_idle:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      ((psel)&&(penable)&&(!transfer)&&(pready))|=>((!psel)&&(!penable))
    )
    else
      $error("t=%0d|fail:access->idle",$time);
      
    stable_addr_data:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      ((psel)&&(!penable))
      |->(($stable(paddr) && 
           $stable(pwdata) && 
           $stable(pstrb))
           until_with pready
         )
    )
    else
      $error("t=%0d|fail:unstable->data,addr",$time);
      
    slverr_check:assert property(
      @(posedge pclk)
      disable iff(!presetn)
      (pslverr && psel && penable && pready)|=>error##1(!error)
    )
    else
        $error("t=%0d|fail:slverr at wrong state",$time);
   
  
endinterface
