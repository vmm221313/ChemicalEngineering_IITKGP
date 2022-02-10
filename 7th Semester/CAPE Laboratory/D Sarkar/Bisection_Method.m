Re = 4.6*10^7;
epsilon_D = 0.037;
x0 = 0.01;
x1 = 0.1;
tol=10^-9;
counter=0;

while true
    x2 = (x0+x1)/2;
    f0 = (1/sqrt(x0))+2*log10((2.51/Re)*(1/sqrt(x0))+epsilon_D/3.71);
    f2 = (1/sqrt(x2))+2*log10((2.51/Re)*(1/sqrt(x2))+epsilon_D/3.71);
    if f0*f2<0
        x1=x2;
    else
        x0=x2;
    end
    if abs(x1-x0)<=tol
        break;
    end
end