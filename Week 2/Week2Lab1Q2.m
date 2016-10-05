func1 = @(x) cos(1./x);
xp = 0.1:0.1:2;
plot(xp,func1(xp))
false_pos(func1,0.1,2,1.e-12)

func2 = @(x) (x-1).^5;
xp = 0.1:0.1:2;
plot(xp,func2(xp))
false_pos(func2,0.1,2,1.e-12)

func3 = @(x) 3*cos(2*x).*exp(x);
xp = 0.1:0.1:2;
plot(xp,func3(xp))
false_pos(func3,0.1,2,1.e-12)