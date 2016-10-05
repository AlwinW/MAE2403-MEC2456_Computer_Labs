function root = false_pos(func,x1,x2,toler)
% Determine the initial values of f_x1, and f_x2
f_x1 = feval(func,x1);
f_x2 = feval(func,x2);
f_xr = 10;
% current_loop = 1;
% use a "While loop" to loop through the Bisection method
while (abs(f_xr) > toler)
    % Estimate next value of x using False Position
    xr = x2 - (f_x2*(x1 - x2))/(f_x1 - f_x2);
    f_xr =  feval(func,xr);
    % Determine which side of the root xr is on.
    % and from this information set the new
    % brackets for the next iteration.
    if ((f_x1*f_xr) < 0)
        x2 = xr;
        f_x2 = f_xr;
    else
        x1 = xr;
        f_x1=f_xr;
    end
    % fprintf('%5d %10.4f\n',current_loop,xr)
    % current_loop = current_loop + 1;
end
root = xr;