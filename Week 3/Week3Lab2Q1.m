x = [0, 1, 1.5, 3];
y = [1, 1, 15, 15];
x_ii = 0:0.1:3;

hold on
stem(x, y)
plot(x_ii,Lagrange(x, y, x_ii))
hold off

func1 = @(x) 10.72*x.^3 + (1-x) - 9.72*x;
func2 = @(x) 21.45*(1.5-x).^3 - 16.68*(x-1).^3 - 3.36*(1.5 - x) + 34.17*(x-1);
func3 = @(x) -5.56*(3-x).^3 + 22.51*(3-x) + 10*(x - 1.5);

hold on
stem(x, y)
plot(0:0.1:1, func1(0:0.1:1))
plot(1:0.1:1.5, func2(1:0.1:1.5))
plot(1.5:0.1:3, func3(1.5:0.1:3))
hold off