function root = false_pos(func,xl,xu,toler)

%Written by Ali Al-Alawi August 2013
%To find the roots of a function using the false position method
%func: the function in which the roots are to be found
%xl: lower bound of the bracket
%xu: upper bound of the bracket
%toler: Tolerance of the final result


%Finding fxl and fxu, the intial values
fxl = func(xl);

fxu = func(xu);

fxr = 100;

loop = 1;


%While loop to loop through the false position method
while (abs(fxr) > toler)
    
    
    %Estimating the next guess
    xr = xu - (fxu*(xl - xu))/(fxl - fxu);
    
    
    fxr = func(xr);
    
    
    
    %Find which side xr is on and set new bracket for next iteration
    if ((fxl*fxr) < 0)
        
        xu = xr;
        
        fxu = fxr;
        
    else
        
        xl = xr;
        
        fxl = fxr;
        
    end
    
    
    %fprintf('%5d %10.4f\n',loop,xr)
    loop = loop +1;
    
end

root = xr;

end
