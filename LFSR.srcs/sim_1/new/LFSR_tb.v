`timescale 1ns / 1ps

module LFSR_TB ();

  parameter NUM_BITS = 5;
  
  reg i_Clk = 1'b0;
  reg i_Enable;
  reg i_Seed_DV;
  reg [NUM_BITS-1:0] i_Seed_Data;
  wire [NUM_BITS-1:0] o_LFSR_Data;
  wire cycle_complete, cycle_start;
  
  LFSR #(.NUM_BITS(NUM_BITS)) LFSR_inst
         (.i_Clk(i_Clk),
          .i_Enable(i_Enable),
          .i_Seed_DV(i_Seed_DV),
          .i_Seed_Data(i_Seed_Data), // Replication
          .o_LFSR_Data(o_LFSR_Data),
          .cycle_complete(cycle_complete),
          .cycle_start(cycle_start)
          );
 
  initial begin
    i_Clk = 0;
    forever #2 i_Clk = ~i_Clk; // Clock period is 10ns
  end
  
  initial 
  begin
    i_Enable = 0; i_Seed_DV = 0;
    #10
    
    i_Enable = 1; i_Seed_DV = 1; i_Seed_Data = 5'b10001;
    #5;
    
    i_Seed_DV = 0;
    #50
    
    i_Seed_DV = 1; i_Seed_Data = 5'b10110;
    #5;
    
    i_Seed_DV = 0;
    #100
    
    i_Enable = 0;
    #30;
    
    i_Enable = 1;
    #100;
    
    $finish;
  end  
  
endmodule // LFSR_TB

