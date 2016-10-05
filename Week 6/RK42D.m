function [x, v, y]=RK42D(func, y_init, v_init, x_init, x_end, nstep)
% Matlab Function of the 4th Order Runge-Kutta Method in 2D
% func: the ODE to be solved
% y_init: Initial y value
% x_init: Inital x value
% x_end: Final x value
% nstep: No. of steps to get from x_init to x_end

% Finding step size
h = (x_end - x_init)/nstep;

% Pre allocating matrix and intitializing algorithim
x = 1:nstep;
v = 1:nstep;
y  = 1:nstep;

% Set the initial values
x(1) = x_init;
v(1) = v_init;
y(1) = y_init;

% For loop used to represent the 4th Order Runge-Kutta Method
for i = 1 : nstep
    % Next x value 
    x(i+1) = x(i) + h;
    
    % Computing slope functions
    k1 = func(x(i),v(i),y(i));
    k2 = func(x(i)+h/2,v(i)+k1(1)*h/2,y(i)+k1(2)*h/2);
    k3 = func(x(i)+h/2,v(i)+k2(1)*h/2,y(i)+k2(2)*h/2);
    k4 = func(x(i)+h,v(i)+k3(1)*h,y(i)+k3(2)*h);
    
    % Determine the new v and y
    v(i+1) = v(i) + h/6 *(k1(1)+2*k2(1)+2*k3(1)+k4(1));
    y(i+1) = y(i) + h/6 *(k1(2)+2*k2(2)+2*k3(2)+k4(2));
    
    % Export the report
    fprintf('x = %6.8f, y = %6.8f, v = %6.8f\n', ...
       x(i+1), y(i+1), v(i+1));
end
end