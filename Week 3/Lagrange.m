function [y_ii] = Lagrange(x, y, x_ii)
% Function that uses the Lagrange Method interpoation from previous data
% x <- x values (vector)
% y <- y values (vector)
% x_ii <- required interpolation point

n = length(x);  % Number of required iterations
R = 0; % Preallocating for size
for i = 1:n
    L = y(i);
    for j = 1:n
        if i ~= j
            L = L.*(x_ii-x(j))/(x(i)-x(j));
        end
    end
    R = R  + L;
end
y_ii = R;

end