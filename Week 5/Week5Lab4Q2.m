% ODE Function
func = @(x, y) 4*exp(0.8*x) - 0.5*y;
% Figure 1: Heun Method
figure(1)
hold on
for i = 1:6
    n = 2^i;
    [x, y] = Heun(func, 0, 0, 6, n);
    fprintf('Heun, n = %2d, x = %6.4f, y = %6.4f\n', n, x(end), y(end));
    plot(x, y, 'DisplayName', ['n = ' num2str(n)])
end
legend(gca,'show', 'Location', 'Best')
title('Heun Method')
hold off
% Figure 2: Euler Method
figure(2)
hold on
for i = 1:6
    n = 2^i;
    [x, y] = euler(func, 0, 0, 6, n);
    fprintf('Euler, n = %2d, x = %6.4f, y = %6.4f\n', n, x(end), y(end));
    plot(x, y, 'DisplayName', ['n = ' num2str(n)])
end
legend(gca,'show', 'Location', 'Best')
title('Euler Method')
hold off