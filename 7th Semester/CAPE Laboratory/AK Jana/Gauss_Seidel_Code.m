B=zeros(4,1);

B(1)=14;
B(2)=28;
B(3)=17.5;
B(4)=10.5;

A=[0.7 0.15 0.03 0.02;
   0.1 0.65 0.06 0.04;
   0.14 0.15 0.77 0.09;
   0.06 0.05 0.14 0.85];

X=zeros(4,1);
tol=0.0001; % assumed tolerance since nothing is given
iterations=0;
while true 
    temp=X;
    X(1)=(B(1)-A(1,2)*X(2)-A(1,3)*X(3)-A(1,4)*X(4))/A(1,1);
    X(2)=(B(2)-A(2,1)*X(1)-A(2,3)*X(3)-A(2,4)*X(4))/A(2,2);
    X(3)=(B(3)-A(3,1)*X(1)-A(3,2)*X(2)-A(3,4)*X(4))/A(3,3);
    X(4)=(B(4)-A(4,1)*X(1)-A(4,2)*X(2)-A(4,3)*X(3))/A(4,4);
    iterations=iterations+1;
    fprintf('The iteration vector is: [');
    fprintf('%g ',X);
    fprintf(']\n');
    
    ctr_false=0;ctr_true=0;
    for i=1:4
        if(abs(X(i)-temp(i))>tol)
            ctr_false=ctr_false+1; % to count number of times tolerance is not met
        else
            ctr_true=ctr_true+1;
        end
    end
    
    if(ctr_false>0) 
        continue; % continuing iterations when tolerance is not met
    else
        break; % stopping iterations when tolerance met for all variables
    end
end