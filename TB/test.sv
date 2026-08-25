class test;
  
  virtual apb_master_if.INP_DRV inp_drv_vif;
  virtual apb_master_if.INP_MON inp_mon_vif;
  virtual apb_master_if.OUT_MON out_mon_vif;
  
  env e;
  
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    this.inp_drv_vif=inp_drv_vif;
    this.inp_mon_vif=inp_mon_vif;
    this.out_mon_vif=out_mon_vif;
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    e.start();
  endtask
  
endclass

class test1 extends test;
  transaction1 t1;
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    super.new(inp_drv_vif,inp_mon_vif,out_mon_vif);
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    begin
      t1 = new();
      e.gen.trans= t1;
    end
    e.start();
  endtask
  
endclass
class test2 extends test;
  transaction2 t2;
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    super.new(inp_drv_vif,inp_mon_vif,out_mon_vif);
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    begin
      t2 = new();
      e.gen.trans= t2;
    end
    e.start();
  endtask
  
endclass
class test3 extends test;
  transaction3 t3;
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    super.new(inp_drv_vif,inp_mon_vif,out_mon_vif);
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    begin
      t3 = new();
      e.gen.trans= t3;
    end
    e.start();
  endtask
  
endclass
class test4 extends test;
  transaction4 t4;
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    super.new(inp_drv_vif,inp_mon_vif,out_mon_vif);
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    begin
      t4 = new();
      e.gen.trans= t4;
    end
    e.start();
  endtask
  
endclass

class regression_test extends test;
  
  transaction1 t1;
  transaction2 t2;
  transaction3 t3;
  transaction4 t4;
  
  function new(virtual apb_master_if.INP_DRV inp_drv_vif,
               virtual apb_master_if.INP_MON inp_mon_vif,
               virtual apb_master_if.OUT_MON out_mon_vif);
    super.new(inp_drv_vif,inp_mon_vif,out_mon_vif);
  endfunction
  
  task run();
    e=new(inp_drv_vif,inp_mon_vif,out_mon_vif);
    e.build();
    begin
      t1 = new();
      e.gen.trans= t1;
    end
    begin
      t2 = new();
      e.gen.trans= t2;
    end
    begin
      t3 = new();
      e.gen.trans= t3;
    end
    begin
      t4 = new();
      e.gen.trans= t4;
    end
    e.start();
  endtask
  
endclass
