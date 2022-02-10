clear all;

% MR XA,R XB,R M1,D XA1,D XB1,D XA1,i YA1,i XB1,i YB1,i M1,i XA1,f XB1,f
% M1,f M1,B XA1,B XB1,B YA1,B YB1,B

x0 = ones(54,1)*0.5; % initial guesses
x0(1,1) = 25;
tspan = [0 10]; % time interval to check steady state

% using ode15s solver to solve the ODE
[t,x] = ode15s(@(t,x) reaction_and_distillation(t,x), tspan, x0);

%  Plotting composition of top and bottom products variation with time

% for component A
plot(t, x(:, 5),'-.','LineWidth',1.5);
title('Composition of Top Product(A1) vs. Time')
xlabel('Time') 
ylabel('Composition of Top Product(A1)') 

% for component B
figure
plot(t, x(:, 6),'-o','Color','red','LineWidth',1.5);
title('Composition of Top Product(B1) vs. Time')
xlabel('Time') 
ylabel('Composition of Top Product(B1)') 

% Bottom Product

% Component B
figure
plot(t, x(:, 54),'-x','Color','green','LineWidth',1.5);
title('Composition of Bottom Product(B1) vs. Time')
xlabel('time') 
ylabel('Composition of Bottom Product(B1)') 

% Component A
figure
plot(t, x(:, 53),'-*','Color','black','LineWidth',1.5);
title('Composition of Bottom Product(A1) vs. Time')
xlabel('time') 
ylabel('Composition of Bottom Product(A1)')

function dxdt =  reaction_and_distillation(t,x) % function definition to define the differential equations to be solved
k1 = 1; k2 = 1; % reaction rate constants
alphaA = 4; alphaB = 2; % relative volatility
N = 15; % no. of trays
f = 4; % feed tray

% molar flow rates
F0 = 100; F = 1880; 
D1 = 1780; R1 = 290; 
V1 = 2070; B1 = 100;

% Variables to be found out and program variables analogy
%{
MR = x(1,1); XA,R = x(2,1); XB,R = x(3,1); M1,D = x(4,1); XA1,D = x(5,1); XB1,D = x(6,1);  
tray 1<=i<f XA1,i = x(7:9); XB1,i = x(10:12); M1,i = x(13:15); YA1,i = x(55:57);YB1,i = x(58:60);
tray i=f    XA1,f = x(16,1); XB1,f = x(17,1);  M1,f = x(18,1)  YA1, f= x(61,1); YB1,f = x(62,1);
tray i>f    XA1,i = x(19:29); XB1,i = x(30:40); M1,i = x(41:51); YA1,i = x(63:73); YB1,i = x(74:84);
M1,B = x(52,1); XA1,B = x(53,1) XB1,B = x(54,1) YA1,B = x(85,1) YB1,B = x(86,1)
%}
    % equilibrium equation: y vs x relations
   for i=1:f-1 
       x(54+i,1) = (alphaA*x(6+i,1))/(1+ (alphaA - 1)*x(6+i,1)+ (alphaB - 1)*x(12+i,1));
       x(57+i,1) = (alphaA*x(12+i,1))/(1+ (alphaA - 1)*x(6+i,1)+ (alphaB - 1)*x(12+i,1));
   end
    x(61,1) = (alphaA*x(16,1))/(1+ (alphaA - 1)*x(16,1)+ (alphaB - 1)*x(17,1));
    x(62,1) = (alphaA*x(17,1))/(1+ (alphaA - 1)*x(16,1)+ (alphaB - 1)*x(17,1));
   for i=1:11 
       x(62+i,1) = (alphaA*x(18+i))/(1+ (alphaA - 1)*x(18+i,1)+ (alphaB - 1)*x(29+i,1));
       x(73+i,1) = (alphaA*x(29+i,1))/(1+ (alphaA - 1)*x(18+i,1)+ (alphaB - 1)*x(29+i,1));
   end
   
   x(85,1) = (alphaA*x(53,1))/(1+ (alphaA - 1)*x(53,1)+ (alphaB - 1)*x(54,1));
   x(86,1) = (alphaA*x(54,1))/(1+ (alphaA - 1)*x(53,1)+ (alphaB - 1)*x(54,1));
   
   % reactor equations
    dxdt(1,1) = F0 + D1 -F; % 1
    dxdt(2,1) = ((F0*(1-x(2,1)) + D1*(x(5,1) - x(2,1))))/x(1,1) - (k1*x(2,1)); % 2
    dxdt(3,1) = (-F0*x(3,1) + D1*(x(6,1)-x(3,1)))/x(1,1) + k1*x(2,1) - k2*(x(3,1)); % 3
    
    % condenser equations
    dxdt(4,1) = V1 - R1 - D1; % 4
    dxdt(5,1) = V1*(x(55,1)-x(5,1))/x(4,1); % 5
    dxdt(6,1) = V1*(x(58,1)- x(6,1))/x(4,1); % 6
    
    % Trays 1<=i<f
    dxdt(13,1) = 0; % 13 liquid hold up
    dxdt(7,1) = (V1*(x(56,1)-x(55,1))+ R1*(x(5,1)-x(7,1)))/x(13,1); % 7
    dxdt(10,1) = (V1*(x(59,1)-x(58,1))+ R1*(x(6,1)-x(10,1)))/x(13,1); % 10
    
    dxdt(14,1) = 0; % 14 
    dxdt(8,1) = (V1*(x(57,1)-x(56,1))+ R1*(x(7,1)-x(8,1)))/x(14,1); % 8
    dxdt(11,1) = (V1*(x(60,1)-x(59,1))+ R1*(x(10,1)-x(11,1)))/x(14,1); % 11
    
    
    dxdt(15,1) = 0; % 15
    dxdt(9,1) = (V1*(x(61,1)-x(57,1))+ R1*(x(8,1)-x(9,1)))/x(15,1); % 9
    dxdt(12,1) = (V1*(x(62,1)-x(60,1))+ R1*(x(11,1)-x(12,1)))/x(15,1); % 12
    dxdt(18,1) = 0; % 18
    
    % Tray f
    dxdt(16,1) = ((V1*(x(63,1)-x(61,1))) + (F*(x(2,1)-x(16,1))) + (R1*(x(9,1)-x(16,1))))/x(18,1); % 16
    dxdt(17,1) = ((V1*(x(74,1)-x(62,1))) + (F*(x(3,1)-x(17,1))) + (R1*(x(12,1)-x(17,1))))/x(18,1); % 17
    dxdt(41,1) = 0; % 41
    
    % Tray f<i<=N
    dxdt(19,1) = (V1*(x(64,1)-x(63,1))+ (R1+F)*(x(16,1)-x(19,1)))/x(41,1); % 19
    dxdt(30,1) = (V1*(x(75,1)-x(74,1))+ (R1+F)*(x(17,1)-x(30,1)))/x(41,1); % 30
    
for k=2:10
    dxdt(40+k,1) = 0; % 42:50
    dxdt(18+k,1) = (V1*(x(63+k,1)-x(62+k,1))+ (R1+F)*(x(18+k-1,1)-x(18+k,1)))/x(40+k,1); % 20:28
    dxdt(29+k,1) = (V1*(x(73+k,1)-x(73+k,1))+ (R1+F)*(x(29+k-1,1)-x(29+k,1)))/x(40+k,1);  % 31:39
end
    % Trays f<i<=N
    dxdt(51,1) = 0; % 51
    dxdt(29,1) = (V1*(x(85,1)-x(73,1))+ (R1+F)*(x(28,1)-x(29,1)))/x(51,1); % 29
    dxdt(40,1) = (V1*(x(86,1)-x(84,1))+ (R1+F)*(x(39,1)-x(40,1)))/x(51,1); % 40
    
    % Reboiler Equations
    dxdt(52,1) = R1 + F -V1 -B1; % 52
    dxdt(53,1) = (((R1+F)*(x(29,1)-x(53,1)) - V1*(x(85,1)-x(53,1))))/x(52,1); % 53
    dxdt(54,1) = (((R1+F)*(x(40,1)-x(54,1)) - V1*(x(86,1)-x(54,1))))/x(52,1); % 54
end