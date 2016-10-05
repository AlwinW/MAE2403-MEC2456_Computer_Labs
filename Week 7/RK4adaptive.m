function [x, y, h]=RK4adaptive(func, y_init, x_init, x_end, h_init, errorbound)
% Matlab Function of the 4th Order Runge-Kutta Method using Adaptive h
% func: the ODE to be solved
% y_init: Initial y value
% x_init: Inital x value
% x_end: Final x value
% nstep: No. of steps to get from x_init to x_end

% Current x, y values
i = 1;
x(i) = x_init;
y(i) = y_init;
h(i) = h_init;

% Step one by one until you just pass the end
while x(i) < x_end
    % RK with step value of h (nstep = 1)
    [~, RKh] = RK4(func, y(i), x(i), x(i) + h(i), 1);
    % RK with step value of h/2 (nstep = 2)
    [~, RKh2] = RK4(func, y(i), x(i), x(i) + h(i), 2);
    % Current error
    DeltaC = RKh2(end) - RKh(end);
    % Adjust the step size
    if DeltaC > errorbound 
        % Error too large, use formula to adjust
        h(i + 1) = 0.8 * h(i) * abs(errorbound / DeltaC)^0.2;
    else
        % Error too small, increase h for efficiency
        h(i + 1) = 0.9 * h(i) * abs(errorbound / DeltaC)^0.25;
        % Make sure h is not too large
        if h(i + 1) > h_init
            h(i + 1) = h_init;
        end
    end
    % Calculate the next step using the the new h value
    [xx, yy] = RK4(func, y(i), x(i), x(i) + h(i + 1), 1);
    x(i + 1) = xx(end);
    y(i + 1) = yy(end);
    % Next index
    i = i + 1;
end

% Since we "overshot" yend, recalculate it
i = i - 1; % "go back" one step
[xx, yy] = RK4(func, y(i-1), x(i-1), x_end, 1);
x(i + 1) = xx(end);
y(i + 1) = yy(end);
end