clear all;

global k0 Ea R;
k0 = 36*10^6;
Ea = 12000;
R = 2;
Xi = [5; 400; 500]; %Initial Guess
for i= 1:50
 [f, jacobian] = cstr(Xi);
 Xsol = Xi - inv(jacobian)*f; %Multivariable Newton Raphson Method statement

 if(abs(Xi-Xsol)<=10^-4) %Tolerance Check
 break;
 end
 Xi=Xsol;
end

function [Func,j_val] = cstr(X) %Equations definition
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

syms x y z ; %Jacobian calculate
J = jacobian([10- x- k0 * exp(-Ea/(R*y))*x ; 500*(298-y) + 6500*(k0 * exp(-Ea/(R*y))*x) - 150*(y - z);
600*1.25*(298 - z) + 150*(y - z) ], [x y z]);
j_val = double(subs(J, [x y z], [X(1), X(2), X(3)]));
end