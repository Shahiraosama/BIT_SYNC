module BIT_SYNC #(parameter WIDTH = 4, STAGES = 4) (

input	wire	[WIDTH-1:0]	ASYNC,
input	wire			CLK,
input	wire			RST,
output	reg	[WIDTH-1:0]	SYNC
);

reg	[STAGES-1:0]	FF	[WIDTH-1:0];

integer i;
integer j;

always@(posedge CLK or negedge RST)
begin

if(!RST)
begin


for( i = 0 ; i <WIDTH ; i=i+1)
begin

SYNC <= 'b0;
FF[i] <= 'b0 ;

end

end

else
begin

for( i = 0 ; i <WIDTH ; i=i+1)
begin
/*


FF[0][0] <= ASYNC [0];  the first subscribts in LHS contain the value of unpacked array --> (the bit num 0 in the Data BUS)
                         and the second subscribts contain the value of packed array --> (the first Flip Flop) 
FF[0][1] <= ASYNC [1];
FF[0][2] <= ASYNC [2];
FF[0][3] <= ASYNC [3];
.
.
.
.
.
.

*/

FF[i][0] <= ASYNC [i] ;

end

/*
FF[0][1] <= FF [0][0];  
FF[1][1] <= FF [1][0];
FF[2][1] <= FF [2][0];
FF[3][1] <= FF [3][0];
.
.
.
.
.
*/

for(i = 1 ; i < STAGES ; i = i+1)
begin

for( j = 0 ; j < WIDTH ; j = j+1 )

begin

FF[j][i] <= FF[j][i-1] ;

end

end


end

end



always@(*)
begin

/*
SYNC[0] <= FF [0][STAGES-1];  
SYNC[1] <= FF [1][STAGES-1];
SYNC[2] <= FF [2][STAGES-1];
SYNC[3] <= FF [3][STAGES-1];
.
.
.
.
.
*/

for (i = 0; i<WIDTH ; i = i+1 )
begin

SYNC[i] <= FF[i][STAGES-1] ; 

end

end

endmodule
