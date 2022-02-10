function dxdt = Condenser(x)
global V1 R1 D1;
dxdt(3) = (V1/M1D)*(Equilibrium(x(5))-x(3));
dxdt(4) = (V1/M1D)*(Equilibrium(x(6))-x(4));
end