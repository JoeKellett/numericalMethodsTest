function [ x, v, t ] = ImprovedEuler( x_0, v_0, k, m, d, h, T )
%IMPROVEDEULER Uses the Improved Euler method to find displacment (x) and
%velcity (v) for given values of t.
%   x_0 is defined as the intial condition, v_0 the initial 1D velocity, h
%   the step size used in the Euler method and T is the length of time the
%   simulation is run for, d is the damping constant.

n = T/h; %Number of interations

v=zeros(n,1); %Define now to prevent resizing.
x=zeros(n,1);
t=zeros(n,1);
a=zeros(n,1);

v(1)=v_0; %Initial values
x(1)=x_0;
t(1)=0;

for j=1:n
    a(j)=-k*x(j)/m-d*v(j)/m;
    v(j+1)=v(j)+h*a(j);
    x(j+1)=x(j)+h*v(j)+h*h*a(j)/2;
    t(j+1)=h*j;
end
end

