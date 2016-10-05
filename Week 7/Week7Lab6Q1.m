% ODE
dydx = @(x, y) 4*exp(0.5*x) - 100*y;

figure(1)
hold on
% Each of the individual cases
for h = [1.0 0.1 0.001]
    [xx, yy] = euler(dydx, 3, 0, 4, 4/h);
    
    % plot out result
    plot(xx, sign(yy).*log(abs(yy)), 'DisplayName', ['n = ' num2str(h)])
end
% analytical solution
yy = 0.039801*exp(0.5*xx) + 2.9602*exp(-100*xx);
plot(xx, sign(yy).*log(abs(yy)), 'DisplayName', 'Analytical')

% decorate the plot
legend(gca, 'show', 'Location', 'Best')
title('Explicit Euler Method')
xlabel('x')
ylabel('log(y)')
hold off