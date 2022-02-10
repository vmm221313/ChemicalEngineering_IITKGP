x=5;
tol=0.000000001;
counter=0;
while true
    f_x=sin(x)-x*cos(x);
    f_dash_x=x*sin(x);
    x_next=x-f_x/f_dash_x;
    counter=counter+1;
    fprintf('Iteration %d: %d\n',counter,x_next);
    if abs(x_next-x)<=tol
        x=x_next;
        break;
    else
        x=x_next;
        continue;
    end
end