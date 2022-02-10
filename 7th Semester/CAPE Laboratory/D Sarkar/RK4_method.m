clear all;

global u k Kr
k = 2; % s^-1
Kr = 1; % mol^2 m^-6
z = 1; % length of PFR
A = 0.4; % m^2
Q = 0.2; % m^3 s^-1
CA0 = 1; % mol m^-3
u = Q/A; % velocity
h = 0.01;
l = 0:h:z;
CA(1) = CA0;

for i=1:(z/h)
k1 = fun(CA(i));
k2 = fun(CA(i)+(h/2)*k1);
k3 = fun(CA(i)+(h/2)*k2);
k4 = fun(CA(i)+h*k3);
CA(i+1) = CA(i) + (h/6)*(k1+2*k2+2*k3+k4);
end

XA = (CA0 - CA)/CA0;
plot(l,CA,'-o','LineWidth',2);
hold on;
plot(l, XA,'-x','LineWidth',2);
legend('CA','XA');

CA = CA';
XA = XA';
l = l';
function s = fun(CA)
global u k Kr
s = -(1/u)*k*CA/sqrt(1+Kr*(CA^2));
end