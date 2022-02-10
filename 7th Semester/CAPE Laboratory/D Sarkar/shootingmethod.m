clear all;

h = 0.05;
T0 = 300;
TL = 400;
Tinf = 200;
sigma = 2.7*(10^-9);
% defining differential equations
f = @(x,y1,y2) [y2]; 
g = @(x,y1,y2)[(-h*(Tinf-y1) - sigma*(Tinf^4 - (y1)^4))];
y1(1) = 300; 
y2(1) = -41.75; % initial guess through trial and error
h = 0.01; % step size
x = [0:h:10]; % rod length
for i = 1:10/h
y1(i+1) = y1(i) + h*f(x(i),y1(i),y2(i)); % slving given system using Explicit Euler method
y2(i+1) = y2(i) + h*g(x(i),y1(i),y2(i));
end
plot(x,y1,'-.','LineWidth',2);