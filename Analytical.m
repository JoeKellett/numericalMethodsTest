function [ x, v, t ] = Analytical( x_0, v_0, k, m, d, h, T  )
%ANALYTICAL Analytically solves a un-forced damped harmonic oscillator
%   Uses the exponential trial solution of the damped ODE to solve the
%   oscillator in the unforced case.
n=T/h;

%Predefine and input the first values as described by the initial condition
v=zeros(n,1); v(1)=v_0;
x=zeros(n,1); x(1)=x_0;
t=zeros(n,1);
a=(-d+sqrt(d*d-4*m*k))/(2*m); %This is generally complex

for j=1:n
    t(j+1)=j*h;
    x(j+1)=((v_0/a)+x_0)*exp(a*t(j+1));
    v(j+1)=v_0*exp(a*t(j+1));
end
end