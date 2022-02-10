function y = Eqilibrium(x1,x2,i)
global alphaA alphaB;
if(rem(i,2)==0)
    y = alphaA*x1/(1+(alphaA-1)*x1+(alphaB-1)*x2);
else
    y = alphaB*x2/(1+(alphaA-1)*x1+(alphaB-1)*x2);
end
end