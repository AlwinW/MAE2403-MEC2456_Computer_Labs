% dy/dx = 4*exp(0.5*x) - 100*y
% by using the implicit Euler method

% h: step size
% x_range: definition domain of x
% n: number of steps
% xx: x value
% yy: y value
% initilization of step size and x domain. calculations of step numbers.

figure(2)
hold on
for h = [1.0 0.1]
    x_range=[0 4];
    y_initial = 3;
    n=(x_range(2)-x_range(1))/h;

    % generating grid in x domain.
    xx = linspace(x_range(1), x_range(2), n+1);
    yy = y_initial;

    % for-loop to computer yy(i)
    for i=1:1:n
        % the implicit method
        yy(i+1) = ( yy(i) + h*(4*exp(0.5*xx(i+1)))) / ( 1 + 100*h );
    end
    % plot out result
    plot(xx, yy, 'DisplayName', ['n = ' num2str(h)])
end
% analytical solution
yy = 0.039801*exp(0.5*xx) + 2.9602*exp(-100*xx);
plot(xx, yy, 'DisplayName', 'Analytical')

% decorate the plot
legend(gca, 'show', 'Location', 'Best')
title('Implicit Euler Method')
xlabel('x')
ylabel('y')
hold off