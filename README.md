# Bifurcation

Bifurcation diagram calcullation for ODE-system.

### Input parameters:

    x_label - the paramter of the x label
    rhs_ext_fcn - handle of function with right hand side of extended ODE-system.
    This function must include RHS of ODE-system coupled with 
    variational equation (n items of linearized systems, see Example).                   
    fcn_integrator - handle of ODE integrator function, for example: @ode45                  
    tstart - start values of independent value (time t)
    stept - step on t-variable for Gram-Schmidt renormalization procedure.
    tend - finish value of time
    ystart - start point of trajectory of ODE system.
    y_dest - intercept quadrant
    cut_start - remove the previous transient state

### Output parameters:
    X - x label 
    Y - the ordinate of the bifurcation diagram

---

## main bifur phase:

    clc;clear all;close all;
    tic;
    W1 = [];
    W2 = [];
    W3 = [];
    W4 = [];

    d =-1:0.01:1;

    N = length(d);
    matlabpool local 4
    parfor i = 1:N
    % for i = 1:N
        fprintf('i = %d\n',i);
        [x,y]= bifurcation(d(i),@(t,y)JM1(t,y),@ode23,0,1e-2,1000,[1 0 0 d(i)],3,5000);
        W1 = [W1;x];
        W2 = [W2;y];

        [x,y]= bifurcation(d(i),@(t,y)JM1(t,y),@ode23,0,1e-2,1000,[-1 0 0 d(i)],3,5000);
        W3 = [W3;x];
        W4 = [W4;y];
    end
    save bifur
    matlabpool close
    toc;
    figure(1);
    plot(W1,W2,'b.','markersize',0.5); hold on
    plot(W3,W4,'r.','markersize',0.5);

## JM1

    function dy=JM1(t,y)
    dy=zeros(3,1);
    a=0.6;c=2;a1=1;b1=0.1;b=1.3;

    dy(1)=abs(y(2))-b;
    dy(2)=(a1-b1*abs(y(4)))*y(3);
    dy(3)=abs(y(1))-y(2)-a*y(3)-c;
    dy(4)=y(3);
