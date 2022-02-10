clear all;

[t,sol] = ode15s(@func,[0 100],[1 0 0]);
plot(t,sol,'-o','LineWidth',2);
legend('x','y','z');
function dXdt = func(t,X)
dXdt = [-0.04*X(1)+(10^4)*X(2)*X(3);
        0.04*X(1)-(10^4)*X(2)*X(3)-(3*(10^7))*(X(2)^2);
        (3*(10^7))*(X(2)^2)];
end