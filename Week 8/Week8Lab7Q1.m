% Determine the various average u values for various Nx
for Nx = [8, 16, 32, 64, 128]
    % Calculate the values
    [u, Nx, Nt, dx, dt, u_avg] = explicit_FDM_func(Nx);
    % Display the result
    fprintf('Nx = %4d, Nt = %4d, dx = %2.4f, dt = %2.4f, u_avg = %2.4f\n', ...
        Nx, Nt, dx, dt, u_avg);
    figure
    contourf(u);
end

% Determine the minimum value of Nx
u_avg = 1;
Nx = 1;
while abs(u_avg + 0.225) > 0.01
    % Increase Nx
    Nx = Nx + 1;
    % Calculate the values
    [u, Nx, Nt, dx, dt, u_avg] = explicit_FDM_func(Nx);
end
% Display the result
fprintf('Nx = %4d, Nt = %4d, dx = %2.4f, dt = %2.4f, u_avg = %2.4f\n', ...
    Nx, Nt, dx, dt, u_avg);