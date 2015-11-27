function [ x, v ] = ForcedVerlet( x_0, v_0, k, m, d, h, T, F )
%FORCEDVERLET. Uses an adapated version of the Verlet method that includes
%a force term. The force input (F) must be of a vector of length n.

n = T/h;

v=zeros(n,1); %Define now to prevent resizing.
x=zeros(n,1);
v(1)=v_0;
x(1)=x_0;

%Start the function with FIE.
[x_1, ~]=ForcedImprovedEuler(x_0, v_0, k, m, d, h, h, F );
x(2)=x_1(2);

D=2*m+d*h;
B=(d*h-2*m)/D;
A=2*(2*m-k*h*h)/D;

for j=2:n+1
    x(j+1)=A*x(j)+B*x(j-1)+2*(h)^2/D *F(j);
    v(j)=(x(j+1)-x(j-1))/(2*h);
end
x=x(1:end-1);%Shorten vector so it is of length n+1
end