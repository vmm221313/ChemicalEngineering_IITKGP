clear all;

% problem intialization
% differential equation obtained from the heat diffusion equation: -
% del(T)/del(t) = alpha*del^2(T)/del(x^2)
L = 0.5; % length of rod in m
k = 0.5; % thermal conductivity of rod in cal/(s.cm.degree celsius)
delta_x = 0.1; % delta_x = 10 cm given
delta_t = 0.1; % delta_t = 0.1 s given
tol = 1; % assumed percentage tolerance since nothing is mentioned
C = 0.2174; % specific heat capacity in cal/(g.degree celsius)
rho = 2.7; % rod density in g/ cm^3
alpha = k/(rho*C); % thermal diffusivity alpha = k/(rho*Cp)
global r;
r = alpha*0.0001*delta_t/(delta_x^2); % this dimensionlessconstant is used in Crank Nicholson method to simplify the finite difference equation obtained
% since we have an unsteady state problem at hand, we will eventually have
% 36 points for final solution of T, hence, initializing it as follows: -
T = zeros(6,6); % 6 because 0 - 0.5 in each variable (t along y axis, length along x axis)

% Initial conditions of the problem: - (at t = 0)
for i=1:6
    T(1,i) = 0;
end

% Boundary conditions of the problem: -
for i=2:6
    T(i,1) = 500; % boundary condition at x = 0 for t > 0
end
for i=2:6
    T(i,6) = 50; % boundary condition at x = 50 cm for t > 0
end
% initialization done!

iteration = 0;

for i = 2:6 % applying Gauss Seidl to solve for T-distribution at each time point
flag = 0; % indicator of tolerance satisfied or not
while flag == 0 % executing Gauss-Seidl without any relaxation factor
    temp =  zeros(4,1);
    l = 1;
    T_in = T;
    for j = 2:5
        temp(l) = fun(T,i,j);
        T(i,j) = temp(l); % implementing Gauss-Seidl without successive relaxation
        l = l+1;
    end   
    for j = 2:5
        if(abs(-T_in(i,j)+T(i,j)))<=(tol/100)*T_in(i,j) % checking tolerance
            flag = 1;
        else
            flag = 0;
        end
    end
    iteration = iteration + 1;
end
end

function val = fun(T,i,j) % Implementing Crank-Nicholson scheme
global r;
val = (r/(2*(r+1)))*(T(i,j+1)+T(i,j-1)+T(i-1,j+1)+T(i-1,j-1))-((r-1)/(r+1))*T(i-1,j);
end