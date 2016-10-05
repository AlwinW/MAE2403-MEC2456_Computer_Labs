% MATLAB code to compute implicit FDM for:
% U_t = U_xx
clear all;

% up x domain
x_min = 0;
x_max = 10;
delta_x = 2.5;

% t domain
coef = 80;
delta_t = delta_x.^2.*coef;
t_min = 0;
t_max = 2;
T_steps = (t_max-t_min)/delta_t;

% Initial Mesh
x = x_min:delta_x:x_max;
% Initial condition
init_field = sin(x) + sin(x/2) + sin(x/3) + sin(x/4);
u(:,1) = init_field;

% First loop for time
for jj = 1:T_steps
    % Second loop for x
    for ii = 2:size(u,1)-1
        % Vectors for tridiagonal matrix
        a(ii) = 1+2*coef;
        b(ii) = -coef;
        d(ii) = u(ii,jj);
    end
    % Constructing matrix d
    d(2) = d(2) + coef*u(1,1);
    d(size(u,1)-1) = d(size(u,1)-1) + coef*u(size(u,1),1);
    % Constructing tridiagonal matrix
    A = diag(a(2:size(u,1)-1),0) + diag(b(2:size(u,1)-2),1) + diag(b(2:size(u,1)-2),-1);
    % Solving matrix equation using GaussSeidel code
    [u_sol iter] = GaussSeidel(A,d(2:size(u,1)-1)',10^-6);
    % Storing result in matrix
    u(:,jj+1) = [u(1,1) u_sol' u(size(u,1),1)]';
end

% Plotting contour of results
contourf(u');