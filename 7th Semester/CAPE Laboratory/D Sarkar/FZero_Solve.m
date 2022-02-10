global Re epsilon_D;
Re = 4.6*10^7;
epsilon_D = 0.037;
x0=0.05;
sol=fzero(@fun,x0);
fprintf('Root: %d\n',sol);

function y=fun(x)
global Re epsilon_D;
y=(1/sqrt(x))+2*log10((2.51/Re)*(1/sqrt(x))+epsilon_D/3.71);
end