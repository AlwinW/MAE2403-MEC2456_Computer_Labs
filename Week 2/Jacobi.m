function [x,counter] = Jacobi(A,d,toler)
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
%%% x_bak      : to back up x_old. this is for comparing the difference of x_new and x_bak to determine whether convergence is achieved. 
%%% x_new      : The updated guess of x
%%% toler      : tolerance for convergence
%%% temp       : a variable for temporary information
%%%
%%% ii         : just a counter
%%% jj         : just a counter
%%%%%%
%%%%%%


%%% Determine the # of columns and rows in the matrix A
[N,M] = size(A);
if N ~= M
    disp('Error, not a square matrix!');
    quit;
end

%%% Get the new A matrix
for ii = 1:N
    for jj = 1:M
        A_new(ii, jj) = -1 * A(ii,jj)/A(ii,ii);
    end
    A_new(ii, ii) = 0;
end


%%% Initialize the initial answer to 0, and the coefficient matrices
x_old = zeros(N,1);
x_bak = x_old;


%%% Now we start the Jacobi iteration
%%% In order to get inside the loop, we set all the initial new values as 1.0
counter = 1;
x_new = ones(N,1);

while (max(abs(x_new-x_bak) > toler)) && (counter < 100000)
    counter = counter + 1;
    x_bak = x_old;      % to back up x_old.
    for ii = 1:N        %% this for loop is to calculate each of x_new(ii)
        temp = 0.0;
        for jj = 1:M     %% this for loop is 
            temp = temp + A_new(ii,jj)*x_old(jj);
        end
        x_new(ii) = temp + d(ii)/A(ii,ii);
    end
    x_old = x_new;      % now asign the obtained x_new to x_old for next iteration.
end

x = x_new;
disp(counter);