clear all;

global u k Kr
k = 2; % s^-1
Kr = 1; % mol^2 m^-6
z = 1; % length of PFR
A = 0.4; % m^2
Q = 0.2; % m^3 s^-1
CA0 = 1; % mol m^-3
u = Q/A; % velocity
l = [0 z];

[length,CA_sol] = ode45(@(l,CA) -(1/u)*k*CA/sqrt(1+Kr*(CA^2)),l,CA0);
XA = (CA0 - CA_sol)/CA0;
plot(length,CA_sol,'-o','LineWidth',2);
hold on;
plot(length, XA,'-x','LineWidth',2);
legend('CA','XA');