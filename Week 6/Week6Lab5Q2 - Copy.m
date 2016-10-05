dvdt = @(t, v, y) -2.5 * v - 98.1 * y;
dydt = @(t, v, y) v;

d2ydt2 = @(t, v, y) [-2.5 * v - 98.1 * y; v];

t0 = 0;
v0 = 0;
y0 = 0.125;
h = 0.05;

k1v = dvdt(t0, v0, y0);
k1y = dydt(t0, v0, y0);
k2v = dvdt(t0 + h/2, v0 + h/2 * k1v, y0 + h/2 * k1y);
k2y = dydt(t0 + h/2, v0 + h/2 * k1v, y0 + h/2 * k1y);
k3v = dvdt(t0 + h/2, v0 + h/2 * k2v, y0 + h/2 * k2y);
k3y = dydt(t0 + h/2, v0 + h/2 * k2v, y0 + h/2 * k2y);
k4v = dvdt(t0, v0 + h * k3v, y0 + h * k3y);
k4y = dydt(t0, v0 + h * k3v, y0 + h * k3y);

v = v0 + h/6 * (k1v + 2*k2v + 2*k3v + k4v);
y = y0 + h/6 * (k1y + 2*k2y + 2*k3y + k4y);