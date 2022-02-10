function dxdt = Reboiler(x,N)
global M1B R1 F V1;
dxdt(2*N+5) = (1/M1B)*((R1+F)*(x(2*N+3)-x(2*N+5))-V1*(Equlibrium(x(2*N+3),x(2*N+4),2*N+3)-x(2*N+5)));
dxdt(2*N+6) = (1/M1B)*((R1+F)*(x(2*N+4)-x(2*N+6))-V1*(Equlibrium(x(2*N+4),x(2*N+3),2*N+4)-x(2*N+6)));
end