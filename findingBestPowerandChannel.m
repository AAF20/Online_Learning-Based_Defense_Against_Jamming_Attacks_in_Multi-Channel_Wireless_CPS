clear ; close all; clc;
% This code outputs the best power level and channel in the hindsight

K = 3 ; % number of channels
L = 5 ; % number of power levels
T = 20000; % time horizon
iteration = 10000; 
attack_power = 4; % choose attack power from the range of [1,5]
% build the attack on channels following i.i.d. Bernoulli 
%distributions with parameters of 0.8, 0.3, and 0.6
r1 = binornd(1,0.8*ones(T,1))'; %  channel 1
r2 = binornd(1,0.3*ones(T,1))'; %  channel 2
r3 = binornd(1,0.6*ones(T,1))'; %  channel 3
ch_data(:,:) = [r1;r2;r3]*attack_power; % build attack matrix on channels
eL = 3; % maximum power level avialble to the sensor
y = linspace(.01,eL,L);
for i = 1:L
    yy(i) = ((y(i)-y(1))/(y(L)-y(1))); % normalizing power levels
end
sigma = 1; % noise power;
A = 1.5; % maximum eigenvalue of matrix A
c = 1  ; % modulation parameter 
delta = 0.2; % trade off parameter 
beta_c = 1/(A^2); % packet error threshold 

Gmax = zeros(T,K*L,iteration); % maximum reward
for itr = 1:iteration
    ch = ch_data(:,:,itr) ;
    I = ones(K,L,T) ;
    for i = 2 % 1 : K 
        for j = 3 %1 : L
            for t= 1 : T
                prob = 2 * qfunc(((c*y(j))/(ch(i,t)+sigma)));
                if rand < prob
                   I(i,j,t)=0;
                end
                reward(i,j,t) = ((I(i,j,t) - (delta * yy(j))- abs(Bhat(t,i)-beta_c)+2))/3;;
                Gmax(t,j+((i-1)*L),itr)  = sum(reward(i,j,1:t));
                power(itr,t) 
            end
        end
    end
end
EGmax = mean(Gmax,3);
for i = 1 : T
    [M,I] = max(EGmax(i,:));
    GMAX(i) = M;
end
% find best channel and power level index
[M,I] = max(EGmax(T,:));
if mod(I/L,1)==0
    best_channel = I/L
    best_power = L
else
    best_channel = fix(I/L)+1
    best_power = I - fix(I/L)*L
end
