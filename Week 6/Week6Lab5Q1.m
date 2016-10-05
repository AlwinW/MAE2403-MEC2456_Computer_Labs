% ODE Formula
dvdt = @(t, v) v/t + 1/4 * log(t);

% Loop for each case
hold on
for i = 1:6
    n = 2^i;
    % RK4 Method
    [x, y] = RK4(dvdt, 13.71, 10, 30, n);
    fprintf('RK4:   n = %2d, x = %6.4f, y = %6.4f\n', n, x(end), y(end));
    plot(n, y(end), 'ro', 'DisplayName', 'RK4')
    % Euler Method
    [x, y] = euler(dvdt, [10 30], 13.71, n);
    fprintf('Euler: n = %2d, x = %6.4f, y = %6.4f\n', n, x(end), y(end));
    plot(n, y(end), 'g*', 'DisplayName', 'Euler')
    % Heun Method
    [x, y] = Heun(dvdt, 13.71, 10, 30, n);
    fprintf('Heun:  n = %2d, x = %6.4f, y = %6.4f\n', n, x(end), y(end));
    plot(n, y(end), 'b+', 'DisplayName', 'Heun')
    legend(gca, 'show', 'Location', 'Best')
end
% decorate the plot
title('Results at x = 30 for various steps')
xlabel('n')
ylabel('y(30)')
hold off