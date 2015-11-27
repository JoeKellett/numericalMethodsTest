function [ x, v ] = ForcedImprovedEuler( x_0, v_0, k, m, d, h, T, F)
%Improved Euler method including a term for external force
%   Similar inputs to ImprovedEuler. F is a vector of length n. This
%   function is used to start the ForcedVerlet function

n = T/h;

v=zeros(n,1);
x=zeros(n,1);
a=zeros(n,1);
v(1)=v_0;
x(1)=x_0;

for j=1:n
    a(j)=-k*x(j)/m-d*v(j)/m+F(j)/m;
    v(j+1)=v(j)+h*a(j);
    x(j+1)=x(j)+h*v(j)+h*h*a(j)/2;
end
end

