class transaction;
  
  
  rand logic pslverr,transfer,pready,write_read;
  rand logic[`ADDR_WIDTH-1:0]addr_in;
  rand logic[`DATA_WIDTH-1:0]prdata,wdata_in;
  rand logic[(`DATA_WIDTH/8)-1:0]strb_in;
  
  logic presetn,psel,penable,pwrite,transfer_done,error;
  logic[`ADDR_WIDTH-1:0]paddr;
  logic[`DATA_WIDTH-1:0]pwdata,rdata_out;
  logic[(`DATA_WIDTH/8)-1:0]pstrb;
  
  virtual function transaction copy();
    copy=new();
    copy.transfer=this.transfer;
    copy.pready=this.pready;
    copy.pslverr=this.pslverr;
    copy.prdata=this.prdata;
    copy.addr_in=this.addr_in;
    copy.wdata_in=this.wdata_in;
    copy.strb_in=this.strb_in;
    copy.write_read=this.write_read;
    return copy;
  endfunction 
  
endclass

class transaction1 extends transaction;
  
  logic[`DATA_WIDTH-1:0]r_data,w_data;
  logic[`ADDR_WIDTH-1:0]addr;
  logic[(`DATA_WIDTH/8)-1:0]strb;
  
  logic slverr,w_read;
  bit[3:0]count;
  
  function void pre_randomize();
    if(count!=0)begin
      r_data=prdata;
      w_data=wdata_in;
      slverr=pslverr;
      w_read=write_read;
      addr=addr_in;
      strb=strb_in;
    end
  endfunction
  
  function void post_randomize();
    if(count!=0)begin
      prdata=r_data;
      wdata_in=w_data;
      pslverr=slverr;
      write_read=w_read;
	  addr_in=addr;
	  strb_in=strb;
	  count=count+1;
    end
	if (count==0) begin 
      transfer=1; 
      count++; 
    end
    if (count==4) begin 
      pready=1; 
      transfer=0; 
      count=0; 
    end 
    else 
      pready=0;
  endfunction
  
  virtual function transaction copy();
    transaction1 copy1=new();
    copy1.pslverr=this.pslverr;
    copy1.transfer=this.transfer;
    copy1.write_read=this.write_read;
    copy1.pready=this.pready;
    copy1.prdata=this.prdata;
    copy1.addr_in=this.addr_in;
    copy1.wdata_in=this.wdata_in;
    copy1.strb_in=this.strb_in;
    return copy1;
  endfunction
  
endclass



class transaction2 extends transaction;
  
  logic[`DATA_WIDTH-1:0]r_data,w_data;
  logic[`ADDR_WIDTH-1:0]addr;
  logic[(`DATA_WIDTH/8)-1:0]strb;
  
  logic slverr,w_read;
  bit[3:0]count;
  
  function void pre_randomize();
    if(count!=0)begin
      r_data=prdata;
      w_data=wdata_in;
      slverr=pslverr;
      w_read=write_read;
      addr=addr_in;
      strb=strb_in;
    end
  endfunction
  
  function void post_randomize();
    if(count!=0)begin
      prdata=r_data;
      wdata_in=w_data;
      pslverr=slverr;
      write_read=w_read;
      addr_in=addr;
      strb_in=strb;
      count=count+1;
    end
	if (count==0) begin 
      transfer=1; 
      count++; 
    end
    if (count==4) begin 
      pready=1; 
      transfer=1; 
      count=0; 
    end 
    else 
      pready=0;
  endfunction
  
  virtual function transaction copy();
    transaction2 copy2=new();
    copy2.pslverr=this.pslverr;
    copy2.transfer=this.transfer;
    copy2.write_read=this.write_read;
    copy2.pready=this.pready;
    copy2.prdata=this.prdata;
    copy2.addr_in=this.addr_in;
    copy2.wdata_in=this.wdata_in;
    copy2.strb_in=this.strb_in;
    return copy2;
  endfunction
  
endclass



class transaction3 extends transaction;
  
  logic[`DATA_WIDTH-1:0]r_data,w_data;
  logic[`ADDR_WIDTH-1:0]addr;
  logic[(`DATA_WIDTH/8)-1:0]strb;
  
  logic slverr,w_read;
  bit[3:0]count;
  
  function void pre_randomize();
    if(count!=0)begin
      r_data=prdata;
      w_data=wdata_in;
      slverr=pslverr;
      w_read=write_read;
      addr=addr_in;
      strb=strb_in;
    end
  endfunction
  
  function void post_randomize();
    pready=1;
    if(count!=0)begin
      prdata=r_data;
      wdata_in=w_data;
      pslverr=slverr;
      write_read=w_read;
	  addr_in=addr;
	  strb_in=strb;
	  count=count+1;
    end
	if (count==0) begin 
      transfer=1; 
      count++; 
    end
    else
      transfer=0;
    if (count==4) begin  
      count=0; 
    end
  endfunction
  
  virtual function transaction copy();
    transaction3 copy3=new();
    copy3.pslverr=this.pslverr;
    copy3.transfer=this.transfer;
    copy3.write_read=this.write_read;
    copy3.pready=this.pready;
    copy3.prdata=this.prdata;
    copy3.addr_in=this.addr_in;
    copy3.wdata_in=this.wdata_in;
    copy3.strb_in=this.strb_in;
    return copy3;
  endfunction
  
endclass



class transaction4 extends transaction;
  
  logic[`DATA_WIDTH-1:0]r_data,w_data;
  logic[`ADDR_WIDTH-1:0]addr;
  logic[(`DATA_WIDTH/8)-1:0]strb;
  
  logic slverr,w_read;
  bit[3:0]count;
  bit t;
  
  function void pre_randomize();
    if(count!=0)begin
      r_data=prdata;
      w_data=wdata_in;
      slverr=pslverr;
      w_read=write_read;
      addr=addr_in;
      strb=strb_in;
    end
  endfunction
  
  function void post_randomize();
    pready=1;
    transfer=1;
    if(count!=0)begin
      prdata=r_data;
      wdata_in=w_data;
      pslverr=slverr;
      write_read=w_read;
      addr_in=addr;
      strb_in=strb;
      count=count+1;
    end
	if(count==0)begin 
      count=count+1; 
    end
    if((t==0)&&(count==3))begin 
      t=1; 
      count=0; 
    end 
    else if((t==1)&&(count==2))
      count=0;
  endfunction
  
  virtual function transaction copy();
    transaction4 copy4=new();
    copy4.pslverr=this.pslverr;
    copy4.transfer=this.transfer;
    copy4.write_read=this.write_read;
    copy4.pready=this.pready;
    copy4.prdata=this.prdata;
    copy4.addr_in=this.addr_in;
    copy4.wdata_in=this.wdata_in;
    copy4.strb_in=this.strb_in;
    return copy4;
  endfunction
  
endclass
