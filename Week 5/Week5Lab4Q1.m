% Declare the functionns
laminar = @(x) 2*pi* x * (1 - x / 0.25)^(2) * 10;
turbulent = @(x) 2*pi* x * (1 - x / 0.25)^(1/5) * 10;
% Laminar Solutions
for n = 2:5
    fprintf('n = %2d, laminar = %6.8f\n', n, GaussQuad(laminar, 0, 0.25, n));
end
% Turbulent Solutions
for n = 2:5
    fprintf('n = %2d, turbulent = %6.8f\n', n, GaussQuad(turbulent, 0, 0.25, n));
end