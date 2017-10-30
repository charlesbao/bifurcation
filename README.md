# bifurcation

'''
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
'''
