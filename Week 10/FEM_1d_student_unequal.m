% example for mec3456
% by Zhe Liu, 7 Sep 2008
%------------------------------
% solves a one-dimensional heat conduction problem by FEM
% T_xx=-f in domain [0,10]
% bc's: one side T(0)=40, T(10)=200. 

clear all; close all;
format long;

% defining the element mesh
xmin=0.; xmax=10.0;  % defining domain
x=[xmin 2.5 5 6.25 7.5 8.75 xmax];  % defining uniform mesh
ns=length(x)-1;       % number of elements
dx=(xmax-xmin)/ns;   % grid spacing


% boundary condition
Te=zeros(ns+1,1) ;
Te(1)=40;      % The boundary condition at first node x=0.0
Te(ns+1)=200;  % The boundary condition at the end node x=10.0

% the heat source
ff=10;          % The heat source along the rod

% defining the matrix of whole system
K=zeros(ns+1,ns+1);    % the stiff matrix of whole system
F=zeros(ns+1,1);       

% construct the matrix of element governing equation
%     and assembly
st=[1,-1;-1,1] ;

for ii=1:ns
   c=1/(x(ii+1)-x(ii));      % length of the element, i.e., x2-x1
   s=st*c;      % the element matrix, Equation (31.26) in textbook
   % assembly
   for i=1:2
       k = ii - 1 + i ;    % the position of element matrix in system matrix
       for j=1:2
           m = ii - 1 + j ;   % the position of the element matrix in system matrix
           K(k,m) = K(k,m) + s(i,j);
       end
       
       F(k) = F(k) + ff*(x(ii+1)-x(ii))/2;  % the external effect.
   end
    
end

% Apply the Dirichlet boundary condition
d=K*Te ;
F=F-d;
K(1,1)=1;
K(2,1)=0;
K(ns+1,ns+1)=-1;
K(ns,ns+1)=0;

K
F

% Solving the equations
T=K\F;

% Display the results and compare with analytical solution
DTdxleft = T(1)
DTdxright = T(ns+1)
T(1)=Te(1);
T(ns+1)=Te(ns+1);
T

polysolution=[-5,66,40];
xx=[0:0.1:10];
analysolution=polyval(polysolution,xx);

plot(x, T,'-ro', xx, analysolution, 'LineWidth', 2)
xlabel ('x coordinate', 'FontSize', 16)
ylabel ('Temperature', 'FontSize', 16)
h = legend('FEM results','analytical solution',2,'Location','SouthEast');
set(h,'Interpreter','none')