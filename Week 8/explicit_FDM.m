% MATLAB code to compute explicit FDM for:
% U_t = U_xx - lambda*U_x
% n is the time step
% j is the position step
% Matrix is a grid of (x_j, t_n)

% Need to clear the previous u and whatnot values for each run
clear all
% Defining Lambda 
lambda = 3;         
% Setting up x (iterate for various Nx)
xmin = 0; xmax = 1;
Nx = 128;
dx = (xmax-xmin)/Nx;
% Setting up t (calculated from stability)
tmin = 0; tmax = 0.2;
    % From stability dt < 2/lambda^2 and dt < dx^2/2
dt = min([dx^2/2 2/lambda^2]);
Nt = ceil((tmax - tmin)/dt);    % Minimum integer Nt
dt = (tmax-tmin)/Nt;            % Update dt

% Creating mesh
xmesh = xmin:dx:xmax;
% Initial condition
u_init = sin(3*pi*xmesh/2);
u(1,:) = u_init;

% For each time value
for n = 1:Nt
    % Go along the x direction from 2 to 2nd last
    for j = 2:size(u,2)-1
        u(n+1,j) = u(n,j) +dt*((u(n,j-1)-2*u(n,j)+u(n,j+1))/dx^2 - ...
            lambda*((u(n,j+1)-u(n,j-1))/(2*dx)));
    end
    % Set the boundary values for the next time value
    u(n+1,1) = u(n,1);
    u(n+1,end) = u(n,end);
end

% Taking the average value of the solution
u_avg = mean(u(Nt,:));

% Display the result
fprintf('Nx = %4d, Nt = %4d, dx = %6.8f, dt = %6.8f, u_avg = %6.8f\n', ...
        Nx, Nt, dx, dt, u_avg);
    
contourf(u)