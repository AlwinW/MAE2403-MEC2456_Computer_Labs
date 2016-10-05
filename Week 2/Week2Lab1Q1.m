A = [4 1 0; 1 4 1; 0 1 4];
d = [10 10 20];
tic; 
GaussSeidel(A, d', 1.e-6)
toc;


a=ones(59, 1);
b=4*ones(60, 1);
c=ones(59, 1);
d=linspace(-100, 100, 60);
A=diag(a,-1)+diag(b,0)+diag(c,1);
tic; [x_sol, num_iter]=GaussSeidel(A, d', 1.e-6); toc;

tic; [x_sol, num_iter]=Jacobi(A, d', 1.e-6); toc;