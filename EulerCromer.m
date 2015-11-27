function [ x, v, t ] = EulerCromer( x_0, v_0, k, m, d, h, T )
%EULER Uses the Euler-Cromer method to find x(t) for a SHO with spring constant k
%and mass m.
%   x_0 is defined as the intial condition, v_0 the initial 1D velocity, h
%   the step size used in the Euler method and T is the length of time the
%   simulation is run for, d is the damping constant.

n = T/h; %Number of iterations

v=zeros(n,1); %Define now to prevent resizing.
x=zeros(n,1);
t=zeros(n,1);
a=zeros(n,1);

v(1)=v_0; %Initial conditions
x(1)=x_0;
t(1)=0;
for j=1:n
    a(j)=-k*x(j)/m-d*v(j)/m;
    v(j+1)=v(j)+h*a(j);
    x(j+1)=x(j)+h*v(j+1);
    t(j+1)=h*j;
end