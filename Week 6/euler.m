function [x, y]=euler(func, x_range, y_initial, nstep)


% Euler method to solve ODE 08/2009
% dy/dx=f(x,y) with initial condition y(x1)=y1
% func: the function f(x,y)
% x_range: the domain where x is defined.
% y_initial: the value of initial condition y1.
% nstep: number of steps

% initialization
x(1) = x_range(1);
y(1) = y_initial;
% step size h
h = ( x_range(2) - x_range(1) ) / nstep;

% The iterations in Euler method
for i = 1 : nstep
x(i+1) = x(i) + h;
y(i+1) = y(i) + h * feval ( func, x(i), y(i) );
end
