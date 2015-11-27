function [ E ] = Energy( x, v, k, m )
%Energy: Finds energy of SHO system with position x, velocity v, spring
%constant k and mass m.
E= 0.5*k*real(x).^2+0.5*m*real(v).^2;
end