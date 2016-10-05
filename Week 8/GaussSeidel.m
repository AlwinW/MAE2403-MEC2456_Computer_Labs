function [x_sol, num_iter]=GaussSeidel(A, d, toler)
%%% This function determines the solution of the matrix problem 
%%%
%%%      [A][x] = [d]
%%%
%%% recursively using the Jacobi technique.
%%%
%%% The user enters in a matrix A and a vector of known values d.
%%%
%%% This code uses x = 0 for the initial guess. The code continues
%%% calculating until a converged estimate of the vector x is found.
%%% 
%%% The code returns the vector x, and the number of iterations which were
%%% required for the converged estimate to be found (counter).


%%%%%%%
%%% Variables 
%%% 
%%%%%%%
%%%
%%% x          : The vector of unknowns (User Output)
%%% counter    : The number of iterations required (User Output)
%%% A          : The matrix A (User Input)
%%% d          : The RHS vector d (User Input)
%%%
%%%
%%% N          : The number of columns in the matrix A
%%% M          : The number of rows in the matrix A
%%% x_old      : The old guess of x
%%% x_new      : The updated guess of x
%%% coeff_sum1 : The coefficients of the first summation in the Jacobi
%%%                technique
%%% coeff_sum2 : The coefficients of the second summation in the Jacobi
%%%                technique
%%% coeff_a_ii : A vector containing the terms a_ii
%%% toler      : tolerance for convergence
%%%
%%% ii         : just a counter
%%% jj         : just a counter
%%%%%%
%%%%%%


%%% Determine the # of columns and rows in the matrix A
[N,M] = size(A);


%%% Initialize the initial answer to 0, and the coefficient matrices
x_old = zeros(N,1);
coeff_sum1 = zeros(N,M);
coeff_sum2 = zeros(N,M);


%%% Initialize the tolerance
%%% note eps is a MATLAB inbuilt function that returns
%%%      the smallest number MATLAB can store
%toler=eps;


%%% Create the coefficient matrices from A
for ii = 1:N
    for jj =   1:(ii-1)
        coeff_sum1(ii,jj) = A(ii,jj);
    end
end
        
for ii = 1:N
    for jj = (ii + 1):M
        coeff_sum2(ii,jj) = A(ii,jj);
    end
end

for ii = 1:N
    coeff_a_ii(ii) = A(ii,ii);
end

    
%%% Now we start the Jacobi iteration to determine the new values of x
num_iter = 1;
x_new = (d - coeff_sum1*x_old...
    - coeff_sum2*x_old)./coeff_a_ii';

while (max(abs(x_new-x_old) > toler)) & (num_iter < 100000)
    x_old = x_new;
    num_iter = num_iter + 1;
    for ii = 1:N
        x_new(ii) = (d(ii) - coeff_sum1(ii,:)*x_new...
            - coeff_sum2(ii,:)*x_old)./coeff_a_ii(ii);
    end
end

x_sol = x_new;