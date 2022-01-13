module vector_len
(
   input                rstn,
   input                clk, 
   input                en,
   input        [11:0]  xin, 
   input        [11:0]  yin, 
   output               valid,
   output               valid_func,
   output       [28:0]  yout,
   output       [28:0]  yout_func
);

   reg [4:0]            en_r ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         en_r[4:0]      <= 'b0 ;
      end
      else begin
         en_r[4:0]      <= {en_r[3:0], en} ;
      end
   end

   //(1) x square
   wire        [23:0]   moutx; 
   wire                 valid_multx ;
   mult_man #(12, 12)
   u_mult_paral_x
       (.clk        (clk),
        .rstn       (rstn),
        .data_rdy   (en_r[0]),
        .mult1      (xin),
        .mult2      (xin),
        .res_rdy    (valid_multx), 
        .res        (moutx)
        );


   //(2) y square
   wire        [23:0]   mouty; 
   wire                 valid_multy ;
   mult_man #(12, 12)
   u_mult_paral_y
      (.clk        (clk),
       .rstn       (rstn),
       .data_rdy   (en_r[0]),
       .mult1      (yin),
       .mult2      (yin),
       .res_rdy    (valid_multy), 
       .res        (mouty)
       );

  //(3) sum and square
   reg        [28:0]    yout_t ;
   wire                  valid_sum;
   reg                   valid_sum_r;
   reg         [1:0]    valid_mult;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         yout_t  <= 29'd0 ;
         valid_mult <= 2'd0;
       end
       else begin
          valid_mult <= {valid_multy,valid_multx};
       end
   end
   always @(posedge clk or negedge rstn) begin
       if(valid_multx & valid_multy) begin
         yout_t  <= moutx + mouty;
         valid_sum_r <= 'd1;
         valid_mult <= 2'd0;
     end
   end
   assign valid_sum = valid_multx & valid_multy;
   assign yout_func = sqrt({3'd0,yout_t});
   assign valid_func = valid_multx & valid_multy & valid_sum;


function [15:0] sqrt;
    input [31:0] num;  //declare input
    //intermediate signals.
    reg [31:0] a;
    reg [15:0] q;
    reg [17:0] left,right,r;    
    integer i;
begin
    //initialize all the variables.
    a = num;
    q = 0;
    i = 0;
    left = 0;   //input to adder/sub
    right = 0;  //input to adder/sub
    r = 0;  //remainder
    //run the calculations for 16 iterations.
    for(i=0;i<16;i=i+1) begin 
        right = {q,r[17],1'b1};
        left = {r[15:0],a[31:30]};
        a = {a[29:0],2'b00};    //left shift by 2 bits.
        if (r[17] == 1) //add if r is negative
            r = left + right;
        else    //subtract if r is positive
            r = left - right;
        q = {q[14:0],!r[17]};       
    end
    sqrt = q;   //final assignment of output.
end
endfunction //end of Function

   wire        [15:0]   sqrt_result; 
   wire                 valid_sqrt ;
   sqrt32
   u_sqrt32(
   .clk(clk), 
   .rstn(rstn),
   .data_rdy(valid_sum),
   .xin({3'b0,yout_t}),
   .rdy(valid_sqrt),
   .result(sqrt_result)
);
   assign yout = {13'b0,sqrt_result};

   assign valid = valid_multx & valid_multy & valid_sum & valid_sqrt;

endmodule // fir_guide
