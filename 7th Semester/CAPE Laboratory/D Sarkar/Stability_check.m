clear all;

R=1.987;
F=1;
Vj=0.25;
V=1;
k0=36000000;
H=6500;
E=12000;
rhoCp=500;
Tf=298;
Caf=10;
UA=150;
Tj0=298;
rhojCj=600;
Fj=1.25;
A=zeros([20,3]);  
for i=1:20  %Finding steady states
    options=optimoptions('fsolve','Display','off');  %Supressing the output
    z=[];
    z(1)=0+rand*(10);   %Intial Guesses
    z(2)=298+rand*(100);
    z(3)=298+rand*(100);
    A(i,1:3)=fsolve(@cstrsteady,z,options); %Solving the function
end
A=round(A,6);%Rounding the variables to 6 decimal places
Cs=A(:,1);
Ts=A(:,2);
Tjs=A(:,3);
Cs=unique(Cs,'stable');  %Finding only unique values and stores them in the order that is found in sol.
Ts=unique(Ts,'stable');
Tjs=unique(Tjs,'stable');
A=([Cs Ts Tjs])
syms Ca T Tj
%Forming the equations
dCdt=(F/V)*(Caf-Ca)-k0*exp(-E/(R*T))*Ca;
dTdt=(rhoCp*F*(Tf-T)+H*V*k0*exp(-E/(R*T))*Ca-UA*(T-Tj))/(rhoCp*V);
dTjdt=(Fj/Vj)*(Tj0-Tj)+(UA/(rhojCj*Vj))*(T-Tj);
Cas=A(:,1);
Ts=A(:,2);
Tjs=A(:,3);
C=zeros([3 3 3]);
for i=1:3 %Finding the value of derivative at steady state
    C(1,1,i) = double(subs(diff(dCdt,Ca),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(1,2,i) = double(subs(diff(dCdt,T),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(1,3,i) = double(subs(diff(dCdt,Tj),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(2,1,i) = double(subs(diff(dTdt,Ca),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(2,2,i) = double(subs(diff(dTdt,T),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(2,3,i) = double(subs(diff(dTdt,Tj),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(3,1,i) = double(subs(diff(dTjdt,Ca),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(3,2,i) = double(subs(diff(dTjdt,T),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
    C(3,3,i) = double(subs(diff(dTjdt,Tj),[Ca T Tj],[Cas(i) Ts(i) Tjs(i)]));
end
Eig=zeros([3,3]);
for i=1:3
    Eig(i,:)=eig(C(:,:,i));
end
Eig
for i=1:3  %Checking for stability of steady states
    if real(Eig(i,:))<0
        fprintf("The steady state [%f,%f,%f] is stable\n",A(i,1),A(i,2),A(i,3));
    else
        fprintf("The steady state [%f,%f,%f] is not stable\n",A(i,1),A(i,2),A(i,3));
    end
end

function f=cstrsteady(x)
    
    R=1.987;
F=1;
Vj=0.25;
V=1;
k0=36*1e6;
H=-6500;
E=12000;
Rho_Cp=500;
Tf=298;
CAf=10;
UA=150;
Tj0=298;
Rhoj_Cj=600;
Fj=1.25;
Cs=x(1);
Ts=x(2);
Tjs=x(3);
r = k0 * exp(-E/(R*Ts))*Cs;
    f(1)=F*CAf-F*Cs-r*V;
    f(2)=Rho_Cp*F*(Tf-Ts)-H*V*r-UA*(Ts-Tjs);
    f(3)=Rhoj_Cj*Fj*(Tj0-Tjs)+UA*(Ts-Tjs);
end
