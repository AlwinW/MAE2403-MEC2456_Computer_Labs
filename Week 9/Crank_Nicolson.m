% MATLAB code to compute Crank Nicolson for:
% U_t = U_xx
clear all; clf; close all; clc; 

% x domain
x_min = 0; x_max = 10;
dx = 0.1;   % Arbitrarily Chosen
% t domain
coef = 10;  % Some relationship between dt/dx^2 to vary
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
        % Vectors for LHS tridiagonal matrix
        l_a(ii) = 1+coef;     % 1 + dt/dx^2
        l_b(ii) = -1/2*coef;  % -1/2 * dt/dx^2
        % Vectors for RHS tridiagonal matrix
        r_a(ii) = 1-coef;     % 1 + dt/dx^2
        r_b(ii) = 1/2*coef;   % -1/2 * dt/dx^2
        % Vector for RHS solution
        r_d(ii) = u(ii,jj);   % Solution vector (RHS)
    end
    % Constructing the LHS tridiagonal matrix
    LHS_A = diag(l_a(2:size(u,1)-1),0) + diag(l_b(2:size(u,1)-2),1) + diag(l_b(2:size(u,1)-2),-1);
    % Constructing the RHS tridiagonal matrix
    RHS_A = diag(r_a(2:size(u,1)-1),0) + diag(r_b(2:size(u,1)-2),1) + diag(r_b(2:size(u,1)-2),-1);
    % Construct the RHS solution: A * d + [vec] - [vec]
    rhs = RHS_A * r_d(2:end)';
    rhs(1) = rhs(1) + coef*u(1,1);  % + coef/2*u(1,1) + coef/2*u(1,1)
    rhs(end) = rhs(end) + coef*u(end,1);    % + coef/2*u(N,1) + coef/2*u(N,1)
    % Solving matrix equation using GaussSeidel code from previous weeks
    [u_sol, iter] = GaussSeidel(LHS_A,rhs,10^-6);
    % Storing result in matrix
    u(:,jj+1) = [u(1,1) u_sol' u(size(u,1),1)]';
end

% Plotting contour of results
contourf(u');