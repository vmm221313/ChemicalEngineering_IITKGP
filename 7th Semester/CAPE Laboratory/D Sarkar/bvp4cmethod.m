clear all;

h = 0.05;
T0 = 300;
TL = 400;
Tinf = 200;
sigma = 2.7*10^-9;
f = @(x,y) [ y(2) ; (-h*(Tinf-y(1)) - sigma*(Tinf^4 - (y(1))^4))]; %defining both differential equations
bc = @(ya, yb) [ya(1)-T0; yb(1) - TL]; % given boundary conditions
xmesh = linspace(0 , 10 , 100); % mesh over which differnetial equation is to be solved
solinit = bvpinit(xmesh, [0 10]);
sol = bvp4c(f, bc,solinit);
T = sol.y;
plot(sol.x, T(1,:),'-x','LineWidth',2);