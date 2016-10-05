% to solve 2D Heat/Diffusion Equation by Crank-Nicolson method.
% dT/dt = D*(T_xx+T_yy)+lambda*(T_x)
clear all;

% define PDE
D = 1.0;
lambda = -3;
% define xy-domain, step size dx, dy, and dt
xmin = 0.; 
xmax = 2.0; 
ymin = 0.; 
ymax = 2.0;
% dx = dy
dx = 0.03125; dy = dx;
tmin = 0;
tmax = 1.0;

dt = 0.1;
Nmb_steps = (tmax-tmin)/dt;

% define a mesh of xy-domain with only intenal nodes.
x = [xmin:dx:xmax]; 
y = [ymin:dy:ymax];
% Internal nodes only
[X,Y] = meshgrid(x(2:length(x)-1),y(2:length(y)-1));
[nx,ny] = size(X);

% intial conditions.
%f_xy = (3.5).*x.^2 + 3.*(y-0.5).^2;
T_init = zeros(nx,ny);
T_init = reshape(T_init',nx*ny,1); % convert the intial condition matrix to the column vector.

% Boundary Conditions
func_BC1 = @(x,y) 0.0 ; % top boundary condition.
func_BC2 = @(x,y) 0.0 ; % bottom boundary condition.
func_BC3 = @(x,y) 6.0; % left boundary condition.
func_BC4 = @(x,y) 0.0; % right boundary condition.
BC = zeros(size(X)); % initilize boundary condition matrix.
BC(1,:) = BC(1,:) + feval(func_BC1, X(1,:)) * D*dt/2/dy/dy;  % top boundary condition.
BC(ny,:) = BC(ny,:) + feval(func_BC2, X(ny,:)) * D*dt/2/dy/dy; % bottom boundary condition
BC(:,1) = BC(:,1) + feval(func_BC3, Y(:,1)) * dt/2*(D/dx/dx-lambda/2/dx); % left boundary condition.
BC(:,nx) = BC(:,nx) + feval(func_BC4, Y(:,nx)) * dt/2*(D/dx/dx+lambda/2/dx); % right boundary condition.
BC = reshape(BC',nx*ny,1); % convert the boundary condition matrix to the column vector.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% linear equations for first row of nodes
L(1,1) = -2*(1/dy/dy + 1/dx/dx);
L(1,2) = 1/dx/dx+lambda/2/dx;
L(1,1+nx) = 1/dy/dy;

for jj = 2:nx-1
    L(jj,jj) = -2*(1/dy/dy + 1/dx/dx);
    L(jj,jj-1) = 1/dx/dx-lambda/2/dx;
    L(jj,jj+1) = 1/dx/dx+lambda/2/dx;
    L(jj,jj+nx) = 1/dy/dy;
end

L(nx,nx) = -2*(1/dy/dy + 1/dx/dx);
L(nx,nx-1) = 1/dx/dx-lambda/2/dx;
L(nx,nx+nx) = 1/dy/dy;

% linear equations for the last row of nodes.
nstart = nx*(ny-1)+1; % the position of the first node in this row in the column vector.

L(nstart,nstart) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart,nstart)
L(nstart,nstart+1) = 1/dx/dx+lambda/2/dx; % its right neighbor
L(nstart,nstart-nx) = 1/dy/dy; % its top neighbor

for jj = 1:nx-2
    L(nstart+jj,nstart+jj) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart+jj, nstart+jj)
    L(nstart+jj,nstart+jj-1) = 1/dx/dx-lambda/2/dx;  % its left neighbor
    L(nstart+jj,nstart+jj+1) = 1/dx/dx+lambda/2/dx;  % its right neighbor
    L(nstart+jj,nstart+jj-nx) = 1/dy/dy; % its top neighbor
end

L(nstart+nx-1,nstart+nx-1) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart+nx, nstart+nx)
L(nstart+nx-1,nstart+nx-1-1) = 1/dx/dx-lambda/2/dx; % its left neighbor.
L(nstart+nx-1,nstart+nx-1-nx) = 1/dy/dy; % its top neighbor.

% linear equations for other rows of nodes.
for ii = 2:ny-1

    nstart = nx*(ii-1)+1; % the position of the first node in this row in the column vector.

    % the first node in this row
    L(nstart,nstart) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart,nstart)
    L(nstart,nstart+1) = 1/dx/dx+lambda/2/dx; % its right neighbor
    L(nstart,nstart-nx) = 1/dy/dy; % its top neighbor
    L(nstart,nstart+nx) = 1/dy/dy; % its bottom neighbor

    % the other rows
    for jj = 1:nx-2
        L(nstart+jj,nstart+jj) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart+jj, nstart+jj)
        L(nstart+jj,nstart+jj-1) = 1/dx/dx-lambda/2/dx;  % its left neighbor
        L(nstart+jj,nstart+jj+1) = 1/dx/dx+lambda/2/dx;  % its right neighbor
        L(nstart+jj,nstart+jj-nx) = 1/dy/dy; % its top neighbor
        L(nstart+jj,nstart+jj+nx) = 1/dy/dy; % its bottom neighbor
    end

    % the last node in this row
    L(nstart+nx-1,nstart+nx-1) = -2*(1/dy/dy + 1/dx/dx); % node T(nstart+nx, nstart+nx)
    L(nstart+nx-1,nstart+nx-2) = 1/dx/dx-lambda/2/dx; % its left neighbor.
    L(nstart+nx-1,nstart+nx-1-nx) = 1/dy/dy; % its top neighbor.
    L(nstart+nx-1,nstart+nx-1+nx) = 1/dy/dy; % its bottom neighbor.
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The coefficient matrix A, B,  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
II = eye(nx*ny);
A = (II-D*dt/2*L);
B = (II+D*dt/2*L);
Inv_A = inv(A);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% performing time steps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
soln(:,1) = T_init;
for jj = 1:Nmb_steps 
    soln(:,jj+1) = Inv_A*(B*soln(:,jj)+2*BC);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plotting the last solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

solnmap = reshape(soln(:,jj), nx, ny);

figure(1)
mesh(X,Y,solnmap), axis([xmin xmax ymin ymax 0. 6]), view(42,26);
xlabel x, ylabel y, zlabel T;
colormap(1e-6*[1 1 1]);
xmid = ceil(nx/2);ymid = ceil(ny/2);
title(['umid = ',num2str(soln(ceil(nx*ny/2),jj)),' at t = ',num2str(tmax)]);
umid = soln(ceil(nx*ny/2),jj)