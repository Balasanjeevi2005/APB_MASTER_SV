class generator;
  
  transaction trans;
  mailbox #(transaction)mbx_g_d;
  function new(mailbox #(transaction)mbx_g_d);
    this.mbx_g_d=mbx_g_d;
    trans=new();
  endfunction
  
  task start();
    
    for(int i=0;i<`NO_TRANS;i++)begin
      assert(trans.randomize());
      mbx_g_d.put(trans.copy());
      $display("t=%0d,i=%0d,GENERATOR Randomized transaction PRDATA=%0d,PREADY=%0d,PSLVERR=%0d,transfer=%0d,write_read=%0d,addr_in=%0d,wdata_in=%0d,strb_in=%0d",$time,i,trans.prdata,trans.pready,trans.pslverr,trans.transfer,trans.write_read,trans.addr_in,trans.wdata_in,trans.strb_in);
    end
    
  endtask
		
endclass
