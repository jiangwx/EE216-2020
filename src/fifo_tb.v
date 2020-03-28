`define BUF_WIDTH   4     //地址宽度为3+1，
`define BUF_SIZE    (8)    //数据个数，FIFO深度

module tb_fifo_counter;
	reg clk,rst_n;
	reg wr_en,rd_en;
	reg [7:0] buf_in;		     // data input to be pushed to buffer
	wire [7:0] buf_out;       // port to output the data using pop.
    wire buf_empty,buf_full;  // buffer empty and full indication 
	wire [`BUF_WIDTH-1:0] fifo_cnt;  // number of data pushed in to buffer 
	
	fifo_counter dut(clk,rst_n,buf_in,buf_out,wr_en,rd_en,buf_empty,buf_full,fifo_cnt);
	
	always #10 clk = ~clk;
	
	initial begin
		clk = 0;
		rst_n = 0;
		wr_en = 0;
		rd_en = 0;
		buf_in = 0;
		#15;
		rst_n = 1;
		
		push(1);
		fork
			push(2);
			pop();
		join			//push and pop together   
		push(10);
		push(20);
		push(30);
		push(40);
		push(50);
		push(60);
		push(70);
		pop();
		push(2);
		pop();
		pop();
		pop();
		pop();
		push(140);
		pop();
		push(50);//
		pop();
		pop();
		pop();
		pop();
		pop();
		push(140);
		pop();
		
	end
	
	task push (input [7:0] data);
	begin
			buf_in = data;
			wr_en = 1;
			@(posedge clk);
			#5 wr_en = 0;
		end
	endtask
	
	task pop();
	begin
			rd_en = 1;
			@(posedge clk);
			#3 rd_en = 0;
	end
	endtask
	
	
endmodule 
