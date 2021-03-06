module sqrt32(
   input         clk, 
   input         rstn,
   input         data_rdy,
   input  [31:0] xin,
   output        rdy,
   output [15:0] result
);
   // acc holds the accumulated result, and acc2 is the accumulated
   // square of the accumulated result.
   reg [15:0] acc;
   reg [31:0] acc2;
   reg         rdy_r;

   reg [4:0]  bitl;
   wire [15:0] bit = 1 << bitl;
   wire [31:0] bit2 = 1 << (bitl << 1);

   wire [15:0] guess  = acc | bit;
   wire [31:0] guess2 = acc2 + bit2 + ((acc << bitl) << 1);

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
       acc  <= 16'b0;
       acc2 <= 32'b0;
       bitl  <= 4'b1;
       rdy_r <= 'b0;
      end
      else  begin
	 if (guess2 <= xin & guess != acc) begin
	    acc  <= guess;
	    acc2 <= guess2;
            //$monitor($time," Guess: %p, acc: %p, data_rdy: %p",guess,acc,data_rdy);
	 end
         else if (guess==acc & data_rdy) begin
             rdy_r <= 'b1;
         end
	 bitl <= bitl - 1;
      end
   end
   assign result = acc;
   assign rdy = rdy_r;
endmodule