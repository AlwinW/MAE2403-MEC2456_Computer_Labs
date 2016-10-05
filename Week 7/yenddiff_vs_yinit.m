function yenddiff = yenddiff_vs_yinit(y_init)
% Matlab Function to calculate the difference between the y value
% at boudary and required value
% y_init: Initial y value (RHS boundary value
% yenddiff: The difference between the y value at boudary 
% and required value

% Store the ODEs as functions
ODE = @(x,y) -x*y-y*x^2;
% Solve the ODE by calling the RK4 function file
[~,Y] = RK4(ODE, y_init, 0, 1, 16);

% Output the difference between the calculated RHS boundary
% value and the required value 1.4
yenddiff = Y(length(Y)) - 1.4;
