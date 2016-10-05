% NOTE: THIS DOES NOT WORK WITHOUT ' '
root = false_pos('yenddiff_vs_yinit', 0, 10, 1e-4);

ODE = @(x,y) -x*y-y*x^2;
[X,Y] = RK4(ODE, 3.2214, 0, 1, 10);

fprintf('The solution is yinit = %6.8f, yend = %6.8f\n', ...
    root, Y(end))

% PRINT EACH OF THE SOLUTIONS FROM 1 to 10
hold on
plot(X, Y)
xlabel('x')
ylabel('y');
hold off
