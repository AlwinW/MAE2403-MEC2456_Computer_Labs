% To find the correct initial condition of ODE using the Shooting method

% The range of initial y values
y0 = 0:0.1:10;
% Define the ODE
ODE = @(x,y) -x*y-y*x^2;
% Pre allocating matrix
BC_RHS = 1:length(y0);
% Find the RHS values
for i = 1:length(y0)
    % Solve the ODE with using RK4 function file
    [x,y] = RK4(ODE,y0(i),0,1,16);
    % Write out the RHS boundary value
    BC_RHS(i) = y(length(y));

end

% plot out the calculated value at RHS boundary vs. Y0
figure(3)
plot(y0,BC_RHS);
xlabel('Initial y(0)')
ylabel('BC_{RHS}');
line([y0(1) y0(end)], [1.4 1.4],'Color','r');
