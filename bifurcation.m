function [X,Y] = bifurcation(x_label,rhs_ext_fcn,fcn_integrator,tstart,stept,tend,ystart,y_dest,cut_start)
%
%    Bifurcation diagram calcullation for ODE-system.
%
%    The alogrithm employed in this m-file for determining ifurcation
%    exponents was proposed in
%
%
%    Input parameters:
%      x_label - the paramter of the x label
%      rhs_ext_fcn - handle of function with right hand side of extended ODE-system.
%              This function must include RHS of ODE-system coupled with 
%              variational equation (n items of linearized systems, see Example).                   
%      fcn_integrator - handle of ODE integrator function, for example: @ode45                  
%      tstart - start values of independent value (time t)
%      stept - step on t-variable for Gram-Schmidt renormalization procedure.
%      tend - finish value of time
%      ystart - start point of trajectory of ODE system.
%      y_dest - intercept quadrant
%      cut_start - remove the previous transient state
%
%    Output parameters:
%      X - x label 
%      Y - the ordinate of the bifurcation diagram
%
%
% --------------------------------------------------------------------
% Copyright (C) 2017, Han Bao.
% bifurcation.m is free software. bifurcation.m is distributed in the hope that it 
% will be useful, but WITHOUT ANY WARRANTY. 
%

X = [];
Y = [];

tspan = tstart : stept : tend;

[t,y] = feval(fcn_integrator,rhs_ext_fcn,tspan,ystart);  

data = y(cut_start:end,y_dest);

N = length(data);

n_start = round(N/2);

a = data(n_start-2);
b = data(n_start-1);

for i = n_start:N
    c = data(i);
    
    if ((b>=a) & (b>=c))
       Y = [Y;b];
    end
    
    a = b;
    b = data(i);

end

X = ones(length(Y),1)*x_label;

%    Output parameters:
%      X - x label 
%      Y - the ordinate of the bifurcation diagram
