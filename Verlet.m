function [ x, v, t ] = Verlet( x_0, v_0, k, m, d, h, T )
%VERLET Numerically estimates the position and speed of a harmonic
%oscillator using the Verlet method using initial condtions, simulation
%time and step size.

n = T/h;

v=zeros(n,1); %Define now to prevent resizing.
x=zeros(n,1);
t=zeros(n,1);

v(1)=v_0; %Set inital conditions
x(1)=x_0;
t(1)=0;

%Use improved Euler to find first terms required for Verlet
[x_1, ~, ~]=ImprovedEuler(x_0, v_0, k, m, d, h, h );
x(2)=x_1(2);
t(2)=h;

D=2*m+d*h;
B=(d*h-2*m)/D;
A=2*(2*m-k*h*h)/D;

for j=2:n+1
    x(j+1)=A*x(j)+B*x(j-1);
    v(j)=(x(j+1)-x(j-1))/(2*h);
    t(j+1)=h*j;
end

x=x(1:end-1);%Shorten outputs to n+1 values
t=t(1:end-1);
end

