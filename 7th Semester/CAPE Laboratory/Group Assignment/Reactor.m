function dxdt = Reactor(x)
global F0 D1 F MR k1 k2;
dxdt(1) = (1/MR)*(F0*(1-x(1))+D1*(x(3)-x(1)))-k1*x(1);
dxdt(2) = (1/MR)*(-F0*x(2)+D1*(x(4)-x(2)))+k1*x(1)-k2*x(2);
end
