`timescale 1ps/1ps

module test ;
   //input
   reg          clk ;
   reg          rstn ;
   reg          en ;
   reg [11:0]   xin ;
   reg [11:0]   yin ;
   //output
   wire         valid ;
   wire         valid_func;
   wire [28:0]  yout ;
   wire [28:0]  yout_func;

   //clock
   always begin
      clk = 0 ; #5 ;
      clk = 1 ; #5 ;
   end

   //reset
   initial begin
      rstn      = 1'b0 ;
      #8 ;
      rstn      = 1'b1 ;
   end


   //driver
   initial begin
      #55 ;
      @(negedge clk ) ;
      en  = 1'b1 ;
      xin  = 25;      yin      = 5;
      #400 ;
      en  = 1'b0 ;
      rstn = 1'b0;
      #8 ;
      rstn      = 1'b1 ;
      #55;
      en  = 1'b1 ;   
      xin  = 16;      yin      = 10;
     
   end // initial begin

    vector_len u_vector_len (
    .rstn        (rstn),
    .clk         (clk),
    .en          (en),
    .xin         (xin),
    .yin         (yin),
    .valid       (valid),
    .valid_func  (valid_func),
    .yout        (yout),
    .yout_func   (yout_func));

   //simulation finish
   initial begin
      forever begin
         #100;
         if ($time >= 10000)  $finish ;
      end
   end

endmodule // test
