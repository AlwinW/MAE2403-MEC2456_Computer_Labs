function [x,counter] = GaussSeidel(A,d,toler)
% This function determines the solution of the matrix problem
%
%      [A][x] = [d]
%
% recursively using the Gauss-Seidel technique.
%
% The user enters in a matrix A and a vector of known values d.
%
% This code uses x = 0 for the initial guess. The code continues
% calculating until a converged estimate of the vector x is found.
%
% The code returns the vector x, and the number of iterations which were
% required for the converged estimate to be found (counter).


%----------------------------
% Variables
%============================
%
% x          : The vector of unknowns (User Output)
% counter    : The number of iterations required (User Output)
% A          : The matrix A (User Input)
% d          : The RHS vector d (User Input)
%
% N          : The number of columns in the matrix A
% M          : The number of rows in the matrix A
% x_old      : The old guess of x
% x_bak      : to back up x_old. this is for comparing the difference of x_new and x_bak to determine whether convergence is achieved. 
% x_new      : The updated guess of x
% toler      : tolerance for convergence
% temp       : a variable for temporary information
% i         : just a counter
% j         : just a counter

% Determine the # of columns and rows in the matrix A
[N,M] = size(A);
if N ~= M
    disp('Error, not a square matrix!');
    quit;
end
% Also determine if the vector d is the correct size
if N ~= length(d)
    disp('Error, length of d not the same as dim of A')
    quit;
end

% Initialise an empty A_new
A_new = zeros(N,M);
% Divides each row by negative of the diagonal value
% Note: the diagonals cannot be zero...
for i = 1:N
    for j = 1:M
        A_new(i, j) = -1 * A(i,j)/A(i,i);
    end
    A_new(i, i) = 0;
end

% Initialize the initial answer to 0, and the coefficient matrices
x_bak = ones(N,1);

% Now we start the Gauss Seidel iteration
% (note: first iteration is guessing zeros)
counter = 1;
x_new = zeros(N,1);

% Loop until the convergence is less than the tolerance required
while (max(abs(x_new-x_bak) > toler)) && (counter < 100000)
    counter = counter + 1;
    x_bak = x_new;      % to back up x_old so we can compare to it later
    for i = 1:N        % this for loop is to calculate each of x_new(i)
        temp = 0.0;
        % This loop is the matrix multiplication of each row and column
        for j = 1:M
            temp = temp + A_new(i,j)*x_new(j);
        end
        % Then we need to add on the original d element
        x_new(i) = temp + d(i)/A(i,i);
    end
end

% Return the results
x = x_new;
disp(counter);