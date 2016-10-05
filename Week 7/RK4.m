function [x, y]=RK4(func, y_init, x_init, x_end, nstep)
% Matlab Function of the 4th Order Runge-Kutta Method

% func: the ODE to be solved
% y_init: Initial y value
% x_init: Inital x value
% x_end: Final x value
% nstep: No. of steps to get from x_init to x_end

% Finding step size
h = (x_end - x_init)/nstep;

% Pre allocating matrix and intitializing algorithim
x = 1:nstep;
y  = 1:nstep;

x(1) = x_init;
y(1) = y_init;

% For loop used to represent the 4th Order Runge-Kutta Method
for i = 1 : nstep
    % Next x value 
    x(i+1) = x(i) + h;
    % Computing slope functions
    k1 = func(x(i),y(i));
    k2 = func(x(i)+h/2,y(i)+k1*h/2);
    k3 = func(x(i)+h/2,y(i)+k2*h/2);
    k4 = func(x(i)+h,y(i)+h*k3);

    y(i+1) = y(i) + h/6 *(k1+2*k2+2*k3+k4);
    
    % fprintf('x = %6.8f, y = %6.8f, k1 = %6.8f, k2 = %6.8f, k3 = %6.8f, k4 = %6.8f,\n', ...
    %    x(i+1), y(i+1), k1, k2, k3, k4);

end
end