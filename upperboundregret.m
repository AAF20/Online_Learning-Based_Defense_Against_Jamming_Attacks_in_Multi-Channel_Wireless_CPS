clc; clear all; close all;

% plot upper bound overall regret 

load('Exp3upper.mat');load('JCAPupper.mat'); %
T = 20000; K = 3; L = 5;
for t = 1:T
    rExp(t)= 2* sqrt(exp(1)-1)*sqrt(K*L*t*log(K*L)); % upper bound Exp3
    rJCAP(t)= 2* sqrt(exp(1)-1)* sqrt(((K*L)/(K+L))*t*log(K*L)); % upper bound J-CAP
    LExp(t)=0.3 * sqrt(K*L*t); % lower bound Exp3
end
figure('rend','painters','pos',[300 300 300 260])
xx = 1:200:2000;  vv = 2000:800:6000; kk = 6000:2000:T;
xx = [xx vv kk];
plot(xx,rExp(xx),'b-d',xx,Exp3upper(xx),'bx',xx,rJCAP(xx),'k-o',xx,JCAPupper(xx),'k*',xx,LExp(xx),'r-s','LineWidth',1)
axis([0 T 0 2500]);xlabel('t'), ylabel('Overall regret');
legend('(Exp3)-analytical-UB','(Exp3)-simulation-UB','(J-CAP)-analytical-UB','(J-CAP)-simulation-UB','analytical-LB')
grid on

