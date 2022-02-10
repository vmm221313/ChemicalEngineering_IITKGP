clear all;

global u a kg k; % Model Given Parameters
u = 1;
a = 200;
kg = 0.02;
k = 0.01;
CAi = 1; % Initial Condition on CA
length = [0,1];
[z,sol] = ode45(@(z,y) reactor_func(z, y),length,CAi); % Solving ode
plot(z,sol,'-o','LineWidth',2); % Plotting CA vs z
hold on;
plot(z,(kg/(k+kg))*sol,'-.','LineWidth',2); % Plotting CAs vs z
legend('CA','CAs');

function func = reactor_func(z,y) % Defining function for ODE
global u a kg k;
CA = y;
CAs_initial_guess = CA;
CAs = fsolve(@(Cas) Alg_Eqn(CA,Cas),CAs_initial_guess); % Solving Algebraic part
func = -(kg*a/u)*(CA - CAs);
end

function y = Alg_Eqn(CA,CAs) % Defining function for Algebraic Equation
global u a kg k;
y = kg*(CA-CAs) - k*CAs;
end