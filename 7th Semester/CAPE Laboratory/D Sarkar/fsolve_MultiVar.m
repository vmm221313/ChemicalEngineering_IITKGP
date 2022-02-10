clear all;

global k0 Ea R;

k0 = 36*10^6;
Ea = 12*10^3;
R = 2;
Xi = [5; 400; 500]; %Initial Guess
xout = fsolve(@cstrsteady,Xi); % fsolve statement

function [Func] = cstrsteady(X) %Equations definition
global k0 Ea R;

F = 1;
Rho_Cp= 500; % Model Parameter Values
UA=150;
Tj0=298;
Fj=1.25;
Tf = 298;
Rhoj_Cpj=600;
V=1;
CAf=10;
deltaH = 6500;
CA = X(1);
T = X(2);
Tj = X(3);

r = k0 * exp(-Ea/(R*T))*CA ;
Func(1, 1) = F*CAf - F*CA - r*V ;
Func(2, 1) = Rho_Cp*F*(Tf-T) + deltaH*V*r - UA*(T - Tj);
Func(3, 1) = Rhoj_Cpj*Fj*(Tj0 - Tj) + UA*(T - Tj);
end
