N=256 ;
n=0:N-1 ;
f=4.3125*n ;
m=n( f>134 & f<956 & n ~= 64 ) ;

A=0.1;
x=zeros(2*N,1) ;
x(m)=A*exp(1j*2*pi*rand(length(m),1)) ;
x(65)=A;

x(2*N-n)=conj(x(n+2)) ;
y=N*ifft(x) ;
y=real(y) ;
y=[y(481:512);y] ;