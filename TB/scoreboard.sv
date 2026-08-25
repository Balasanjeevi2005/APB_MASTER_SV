class scoreboard;
  transaction t1,t2;
  //ref_model -> scoreboard
  mailbox #(transaction)mbx_rf_s;
  
  //out_monitor -> scoreboard
  mailbox #(transaction)mbx_om_s;
  
  int match_count=0;
  int mis_count=0;
  
  function new(mailbox #(transaction)mbx_rf_s,mailbox #(transaction)mbx_om_s);
    this.mbx_rf_s=mbx_rf_s;
    this.mbx_om_s=mbx_om_s;
  endfunction
  
  task start();
    repeat(`NO_TRANS)begin
      fork
        begin
          mbx_rf_s.get(t1);
        end
        begin
          mbx_om_s.get(t2);
        end
      join
      compare();
    end
  endtask
  
  task compare();
    if(t1.error==1)begin
      if(t2.error==1)begin
        ++match_count;
        $display("error found & matches");
      end
      else begin
        ++mis_count;
        $display("error found & mismatches");
      end
    end
    else begin
      if((t1.psel==t2.psel)&&(t1.penable==t2.penable)&&(t1.error==t2.error)&&(t1.transfer_done==t2.transfer_done)&&(t1.rdata_out==t2.rdata_out)&&(t1.paddr==t2.paddr)&&(t1.pwrite==t2.pwrite)&&(t1.pwdata==t2.pwdata)&&(t1.pstrb==t2.pstrb))begin
        ++match_count;
       // $display();
      end
      else begin
        ++mis_count;
       // display();
      end
        
    end
    
  endtask
  
  task final_count();
    $display("match_count=%0d",match_count);
    $display("mis_count=%0d",mis_count);
    $display("total count=%0d",match_count+mis_count);
  endtask
    
endclass
     
      
  
  
