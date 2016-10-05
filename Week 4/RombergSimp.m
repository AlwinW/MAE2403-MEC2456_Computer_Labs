function [result,n]=RombergSimp(func, a, b, toler)
% Computes the value of an integral using the Simpson's Rule

% Intialization of algorithim
simp = 10;
j = 1;
s = 0;

s1 =  trapzd(func,a,b,s,j);
simp1 = (4*s1-s)/3;

% While loop until tolerance limit is met
while abs(simp1 - simp) > toler
    j = j+1;    % increase j
    s = s1;     % save the old trap result
    simp = simp1; % save the old simpson's result
    s1 =  trapzd(func,a,b,s,j); % New trapzium value
    simp1 = (4*s1-s)/3; % Using Romberg's method rather than writing a new loop
    fprintf('j = %2d, simp = %8.6f, simp1 = %8.6f\n', j, simp, simp1); 
end
result = simp1;
n = j-1;

