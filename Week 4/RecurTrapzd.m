function [result,n]=RecurTrapzd(func, a, b, toler)
% This function finds the integration value using the recursive trapezium
% method. Requires the trapzd.m file

% Initialise the sum as zero
j = 0;  % Initial j value
s = 0;  % Previous value to compare to
s_new = 1; % New integral value (10 abritarily chosen)

while abs(s_new - s) > toler
    j = j + 1;  % Increase J
    s = s_new;  % Save old integral value
    s_new = trapzd(func,a,b,s,j); % Find new integral
    fprintf('j = %2d, s = %8.6f, s_new = %8.6f\n', j, s, s_new); 
end
result = s_new;
n = j - 1;


