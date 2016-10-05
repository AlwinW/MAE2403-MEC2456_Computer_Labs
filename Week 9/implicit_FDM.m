% MATLAB code to compute implicit FDM for:
% U_t = U_xx
clear all; close all; clc; clf;

% x domain
x_min = 0; x_max = 10;
dx = 2.5;   % Arbitrarily Chosen
% t domain
coef = 0.16;  % Some relationship between dt/dx^2 to vary
delta_t = dx.^2.*coef;
t_min = 0; t_max = 2;
Nt = (t_max-t_min)/delta_t;

% Initial Mesh
x = x_min:dx:x_max;
% Initial condition
init_field = sin(x) + sin(x/2) + sin(x/3) + sin(x/4);
u(:,1) = init_field;

% First loop for time
for jj = 1:Nt
    % Second loop for x
    for ii = 2:size(u,1)-1
        % Vectors for tridiagonal matrix
        a(ii) = 1+2*coef;   % 1 + 2 * dt/dx^2
        b(ii) = -coef;      % -dt/dx^2
        d(ii) = u(ii,jj);   % Solution vector (RHS)
    end
    % Boundary Conditions BC + dt/dx^2
    d(2) = d(2) + coef*u(1,1);
    d(size(u,1)-1) = d(size(u,1)-1) + coef*u(size(u,1),1);
    % Constructing tridiagonal matrix
    A = diag(a(2:size(u,1)-1),0) + diag(b(2:size(u,1)-2),1) + diag(b(2:size(u,1)-2),-1);
    % Solving matrix equation using GaussSeidel code from previous weeks
    [u_sol, iter] = GaussSeidel(A,d(2:size(u,1)-1)',10^-6);
    % Storing result in matrix
    u(:,jj+1) = [u(1,1) u_sol' u(size(u,1),1)]';
end

% Plotting contour of results
contourf(u');