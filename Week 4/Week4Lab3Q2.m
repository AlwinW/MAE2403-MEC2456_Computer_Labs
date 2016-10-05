func1 = @(x) sqrt(1 - 4*x.^2);
tic;
[result,n] = RecurTrapzd(func1, -0.5, 0.5, 10^-4);
toc;
tic;
[result,n] = RombergSimp(func1, -0.5, 0.5, 10^-4);
toc;