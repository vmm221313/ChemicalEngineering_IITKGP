%problem initialization: -
alpha = 1.5; %over-relaxation weighting factor
tol = 1; %percentage tolerance allowed
global delta_x delta_y;
delta_x = 1; %interval length along x-axis
delta_y = 1; %interval length along y-axis
%since the net grid consists of 25 points i.e.x_index from 0 to 4 and y_index from 0 to 4
T = zeros(5,5); 
%In the problem, following boundary conditions exist:-
%{
    T(0,1)=T(0,2)=T(0,3)=75
    T(4,1)=T(4,2)=T(4,3)=50
    T(1,4)=T(2,4)=T(3,4)=100
    T(1,0)=T(2,0)=T(3,0)=0
For corner values, average is taken between temperatures of both surfaces
since they are unequal
    T(0,0)=(0+75)/2=37.5
    T(4,0)=(0+50)/2=25
    T(4,4)=(100+50)/2=75
    T(0,4)=(100+75)/2=87.5
%}
%initializing corner boundary values: -
T(5,1)=37.5; %T(0,0)
T(5,5)=25; %T(4,0)
T(1,5)=75; %T(4,4)
T(1,1)=87.5; %T(0,4)
%initializing non-corner boundary values: -
for i=2:4
    T(i,1)=75;
    T(i,5)=50;
    T(1,i)=100;
    T(5,i)=0;
end
%initialization done!
iteration=0;flag=0;
while flag==0 %executing the Gauss Seidel method with over-relaxation
    temp = zeros(9,1);
    k=1;
    t=T;
    for i=2:4
        for j=2:4
            temp(k)=func(T,i,j); %storing the residual term
            T(i,j)=(1-alpha)*T(i,j)+alpha*temp(k); %including the over-relaxation factor
            k=k+1;
        end
    end
    for i=2:4
        for j=2:4
            if (abs(-t(i,j)+T(i,j))<=(tol/100)*t(i,j)) %checking tolerance
                flag=1;
            else
                flag=0;
            end
        end
    end
    iteration=iteration+1;
end
function value=func(T,i,j) %for defining the expression involved in writing finite difference method
global delta_x delta_y;
if delta_x == delta_y
    value=(1/4)*(T(i,j+1)+T(i,j-1)+T(i+1,j)+T(i-1,j));
else %to account for unequal delta_x and delta_y, like managing delta_x = delta_y/2
    value=(1/2)*((T(i,j+1)+T(i,j-1))/(delta_x^2)+(T(i+1,j)+T(i-1,j))/(delta_y^2))/(1/(delta_x^2)+1/(delta_y^2));
end
end