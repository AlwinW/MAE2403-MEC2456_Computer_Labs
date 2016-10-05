function s1 = trapzd(func,a,b,s,n)
%
% function s1 = trapzd(func,a,b,s,n)
%
% This routine uses the trapezoidal rule to evaluate
% the integral between a and b of the integrand defined
% by the function func. n is the number of times the interval is subdivided.
% 
% The new approximation (s1) is adjusted from the previous approximation 
% (s) from a prior call.
%
if (n == 1) 
   s=0.5*(b-a)*(feval(func,a)+feval(func,b));
   s1 = s;
else
   it=2^(n-2);
   tnm=it;
   h=(b-a)/tnm;
   x=a+0.5*h;
   sum=0.0;
   for j=1:it
      sum=sum+feval(func,x);
      x=x+h;
   end
   s=0.5*(s+h*sum);
   s1 = s;
end