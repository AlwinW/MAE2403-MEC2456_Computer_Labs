function result = GaussQuad(func, a, b, n)
% Gauss Quadrature Technique of integration
% func: the function to be integrated
% a: lower limit
% b: upper limit
% n: number of points used in the Gauss Quadrature integration

% Determine which case depending on the number of points
switch n
    % Two point integral
    case 2
        c(1) = 1;
        c(2)= 1;
        x(1)= -0.577350269;
        x(2)= 0.577350269;
    % Three point integral
    case 3
        c(1)= 0.5555556;
        c(2)= 0.8888889;
        c(3)= 0.5555556;
        x(1)= -0.774596669;
        x(2)=0.0;
        x(3)= 0.774596669; 
    % Four point integral
    case 4
        c(1)= 0.3478548;
        c(2)= 0.6521452;
        c(3)= 0.6521452;
        c(4)= 0.3478548;     
        x(1)= -0.861136312;
        x(2)= -0.339981044;
        x(3)= 0.339981044;
        x(4)= 0.861136312; 
    % Five point integral
    case 5
        c(1)= 0.2369269;
        c(2)= 0.4786287;
        c(3)= 0.5688889;
        c(4)= 0.4786287;
        c(5)= 0.2369269;
        x(1)= -0.906179846;
        x(2)= -0.538469310;
        x(3)= 0.0;
        x(4)= 0.538469310;
        x(5)= 0.906179846; 
 end

% Change of variables
xm = 0.5*(b+a);
xr = 0.5*(b-a);

% Intialization of algorithim
sum = 0; 

% For loop used to do Gauss Quadrature Sum
for j = 1:n
    % Transform the x, apply a function and sum
    sum = sum + c(j)*(func(xm+xr*x(j)));
end
result = xr*sum;
end