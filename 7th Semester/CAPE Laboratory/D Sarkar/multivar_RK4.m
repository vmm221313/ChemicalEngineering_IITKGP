clear all;

x(1) = 1;
y(1) = 0;
z(1) = 0;
t = 0:0.01:100;
for i=1:10000
    k1 = func(t(i),x(i),y(i),z(i));
    k2 = func(t(i)+0.005,x(i)+0.005*k1(1),y(i)+0.005*k1(2),z(i)+0.005*k1(3));
    k3 = func(t(i)+0.005,x(i)+0.005*k2(1),y(i)+0.005*k2(2),z(i)+0.005*k2(3));
    k4 = func(t(i)+0.01,x(i)+0.01*k3(1),y(i)+0.01*k3(2),z(i)+0.01*k3(3));
    x(i+1) = x(i) + (1/6)*(k1(1)+2*k2(1)+2*k3(1)+k4(1));
    y(i+1) = y(i) + (1/6)*(k1(2)+2*k2(2)+2*k3(2)+k4(2));
    z(i+1) = z(i) + (1/6)*(k1(3)+2*k2(3)+2*k3(3)+k4(3));
end
t = t';
x = x';
y = y';
z = z';
plot(t,x,'-x','LineWidth',2);hold on;
plot(t,y,'-o','LineWidth',2);hold on;
plot(t,z,'-.','LineWidth',2);
legend('x','y','z');

function dXdt = func(t,x,y,z)
dXdt = [-0.04*x+(10^4)*y*z;
        0.04*x-(10^4)*y*z-(3*(10^7))*(y^2);
        (3*(10^7))*(y^2)];
end