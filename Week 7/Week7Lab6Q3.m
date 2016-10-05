ODE = @(x,y) 4*exp(0.8*x) - 0.5;

% [x,y] = RK4(ODE,3,0,1,16); 
% disp(y(end))

% RK4adaptive(func, y_init, x_init, x_end, h_init, errorbound)
[x,y,h] = RK4adaptive(ODE, 2, 0, 2, 0.5, 1e-6); 
% Plot of the ODE Solution
subplot(2,1,1)
plot(x, y)
title('ODE Solution')
xlabel('x')
ylabel('y')
% Plot of the step sizes
subplot(2,1,2)
plot(x, h)
title('Step Sizes')
xlabel('x')
ylabel('h')

disp(y(end))

for i = 1:length(x)
    fprintf('%6.4f %6.4f %6.4f\n', x(i), y(i), h(i))
end

%[tout, yout] = ode23(ODE,[0, 2],2);