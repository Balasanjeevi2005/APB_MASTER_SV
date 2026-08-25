class ref_model;
  transaction trans;
  //ref_model -> scoreboard
  mailbox #(transaction)mbx_rf_s;
  
  //input_monitor -> ref_model
  mailbox #(transaction)mbx_im_rf;
  
  typedef enum{idle,setup,access}states;
  
  states ct_st=idle;
  
  
  logic[`ADDR_WIDTH-1:0]addr;
  logic[`DATA_WIDTH-1:0]r_data,w_data;
  logic[((`DATA_WIDTH)/8)-1:0]strb;
  bit p_write,err,trans_done;
  
  function new(mailbox #(transaction)mbx_rf_s,mailbox #(transaction)mbx_im_rf);
    this.mbx_rf_s=mbx_rf_s;
    this.mbx_im_rf=mbx_im_rf;
  endfunction
  
task start();

  for (int i = 0; i < `NO_TRANS; i++) begin

    mbx_im_rf.get(trans);

    if (trans.presetn == 1) begin

      // IDLE STATE
      if (ct_st == idle) begin

        trans.psel          = 0;
        trans.penable       = 0;
        trans.paddr         = addr;
        trans.pwdata        = w_data;
        trans.pstrb         = strb;
        trans.rdata_out     = r_data;
        trans.pwrite        = p_write;
        trans.transfer_done = 0;
        trans.error         = 0;

        if (trans_done == 1) begin
          trans.transfer_done = 1;
          trans_done = 0;
        end

        if (err == 1) begin
          trans.error = 1;
          err = 0;
        end

        if (trans.transfer == 1)
          ct_st = setup;

      end

      // SETUP STATE
      else if (ct_st == setup) begin

        trans.psel      = 1;
        trans.penable   = 0;
        trans.paddr     = addr;
        trans.pwdata    = w_data;
        trans.pstrb     = strb;
        trans.rdata_out = r_data;
        trans.pwrite    = p_write;

        if (trans_done == 1) begin
          trans.transfer_done = 1;
          trans_done = 0;
        end
        else begin
          trans.transfer_done = 0;
        end

        if (err == 1) begin
          trans.error = 1;
          err = 0;
        end
        else begin
          trans.error = 0;
        end

        ct_st = access;

      end

      // ACCESS STATE
      else if (ct_st == access) begin

        trans.psel          = 1;
        trans.penable       = 1;
        trans.paddr         = trans.addr_in;
        addr                = trans.addr_in;

        trans.pwrite        = trans.write_read;
        p_write             = trans.write_read;

        trans.transfer_done = 0;
        trans.error         = 0;

        if (trans.pwrite == 1) begin

          trans.pwdata   = trans.wdata_in;
          w_data         = trans.wdata_in;

          trans.pstrb    = trans.strb_in;
          strb           = trans.strb_in;

          trans.rdata_out = r_data;

        end
        else begin

          trans.pwdata    = 0;
          w_data          = 0;

          trans.pstrb     = 0;
          strb            = 0;

          trans.rdata_out = r_data;

        end

        if (trans.pready == 1) begin

          trans_done = 1;

          if (trans.pslverr == 1)
            err = 1;
          else
            err = 0;

          if (trans.transfer == 1)
            ct_st = setup;
          else
            ct_st = idle;

          if (trans.pwrite == 0)
            r_data = trans.prdata;

        end

      end

    end

    // RESET
    else begin

      trans.psel          = 0;
      trans.penable       = 0;
      trans.pwrite        = 0;
      trans.paddr         = 0;
      trans.pwdata        = 0;
      trans.pstrb         = 0;
      trans.rdata_out     = 0;
      trans.transfer_done = 0;
      trans.error         = 0;

      r_data    = 0;
      addr      = 0;
      w_data    = 0;
      strb      = 0;
      p_write   = 0;
      trans_done = 0;
      err       = 0;
      ct_st     = idle;

    end

    $display("t=%0d|ref_model input:i=%0d,presetn=%0d,pready=%0d,pslverr=%0d,transfer=%0d,write_read=%0d,addr_in=%0h,wdata_in=%0h,strb_in=%0d",
             $time, i, trans.presetn, trans.pready, trans.pslverr,
             trans.transfer, trans.write_read, trans.addr_in,
             trans.wdata_in, trans.strb_in);

    $display("t=%0d|ref_model output:i=%0d,psel=%0d,penable=%0d,paddr=%0h,pwdata=%0h,pstrb=%0d,pwrite=%0d,rdata_out=%0h,transfer_done=%0d,error=%0d",
             $time, i, trans.psel, trans.penable, trans.paddr,
             trans.pwdata, trans.pstrb, trans.pwrite,
             trans.rdata_out, trans.transfer_done, trans.error);

    mbx_rf_s.put(trans);

  end

endtask

endclass
        
        
        
              
