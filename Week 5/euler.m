function [x, y]=euler(func,  y_init, x_init, x_end, nstep)
% Euler method to solve ODE
% func: the function f(x,y)
% x_range: the domain where x is defined.
% y_initial: the value of initial condition y1.
% nstep: number of steps

% Pre allocating matrix and intitializing algorithim
x = 1:nstep;
y = 1:nstep;
% initialization
x(1) = x_init;
y(1) = y_init;
% Finding step size
h = (x_end - x_init) / nstep;

% The iterations in Euler method
for i = 1 : nstep
    x(i+1) = x(i) + h;
    y(i+1) = y(i) + h * feval (func, x(i), y(i));
end
