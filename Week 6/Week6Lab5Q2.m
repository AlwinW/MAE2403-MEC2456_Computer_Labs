% Second order ODE
d2ydt2 = @(t, v, y) [-2.5 * v - 98.1 * y; v];

% Solve using RK4 in 2D
[x, v, y]=RK42D(d2ydt2, 0.125, 0, 0, 10, 200);

% Plot the output
hold on
title('ODE Solution')
xlabel('y')
ylabel('L')
plot(x, y)
hold off