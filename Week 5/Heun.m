function [x, y]=Heun(func, y_init, x_init, x_end, nstep)
% Function of the Heun Method
% func: the ODE to be solved
% y_init: Initial y value
% x_init: Inital x value
% x_end: Final x value
% nstep: No. of steps to get from x_init to x_end

% Pre allocating matrix and intitializing algorithim
x = 1:nstep;
y0 = 1:nstep;
y = 1:nstep;

% Initial values (BCs)
x(1) = x_init;
y0(1) = y_init;
y(1) = y_init;
% Finding step size
h = (x_end - x_init) / nstep;

% For loop used to represent Heun's Method
for i = 1 : nstep
    x(i+1) = x(i) + h;
    y0(i+1) = y(i) + h * (func(x(i),y(i)));
    
    % Apply 4 corrections
    for j = 1:4 
        % Make a correction based on the old y0
        y(i+1) = y(i)+ (func(x(i),y(i)) + func(x(i+1),y0(i+1)))*h/2;
        % Update the old y0 to the new y
        y0(i+1) = y(i+1);
    end
end
end