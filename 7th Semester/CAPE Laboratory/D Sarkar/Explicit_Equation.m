Re = 4.6*10^7;
epsilon_D = 0.037;

A = Re*epsilon_D/8.0884;
B = log(Re)-0.7794;
X = A+B;
C = log(X);

f = 1/((0.8686*(B-C+C/(X-0.5564*C+1.207)))^2)