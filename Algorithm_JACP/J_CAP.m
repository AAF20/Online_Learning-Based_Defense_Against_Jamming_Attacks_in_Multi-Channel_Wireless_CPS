clc ; clear ; close all ;

K = 3 ; % number of channels
L = 5 ; % number of power levels
T = 20000; % time horizon
iteration = 1000; 

attack_power = 4; % choose attack power from the range of [1,5]

% build the attack on channels following i.i.d. Bernoulli 
%distributions with parameters of 0.8, 0.3, and 0.6

r1 = binornd(1,0.8*ones(T,1))'; %  
r2 = binornd(1,0.3*ones(T,1))'; %  
r3 = binornd(1,0.6*ones(T,1))'; %  
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

Gama = sqrt ((K * L * log(K*L))/((K+L)*(exp(1)-1)*T)); % exploration parameter
omega = ones(K,1) ; u = ones(L,1) ; % initializing the vectors
pt1 = zeros(T,K) ; pt2 = zeros(T,L) ;
ppt1 = zeros(T,K,iteration); ppt2 = zeros(T,L,iteration);B = zeros(T+1,K,iteration) ;
ch = ch_data(:,:);
for i = 1 : iteration
    I = ones(K,L,T) ;hat_x1 = zeros(K,T);hat_x2 = zeros(L,T);m = zeros(K,1) ; n = zeros(K,1) ; Bhat=zeros(T,K);
    for t = 1 : T
        [ps,pr] = Probablity (omega,Gama,K) ; % channel selection probability 
        pt1(t,:) = pr ;
        [indx1,psel] = ChannelSelection(ps); % channel selection index 
        [ps2,pr2] = Probablity (u,Gama,L) ;
        pt2(t,:) = pr2 ;
        [indx2,pse2] = ChannelSelection(ps2);
        prob = 2 * qfunc(((c*y(indx2))/(ch(indx1,t)+sigma))); % set a threshold for packet error probability
        if rand < prob   % if packet is dropped
            I(indx1,indx2,t)=0;
            m(indx1) = m(indx1) + 1 ;
        end
        n(indx1) = n(indx1) + 1 ;
        Bhat(t,indx1) = m(indx1) / n(indx1) ;
        reward(t) = (I(indx1,indx2,t) - (delta*yy(indx2)) - abs(Bhat(t,indx1)-beta_c)+2)/3;
        hat_x1(indx1,t) = reward(t)/psel;
        hat_x2(indx2,t) = reward(t)/pse2;
        omega =  Weight (omega,Gama,K,hat_x1(:,t)) ; % update the weight
        u     =  Weight (u,Gama,L,hat_x2(:,t)) ;  % update the weight
        GHExp (i,t) = sum (reward(1:t)) ;
        Bhat(t+1,:) = Bhat(t,:);
    end
    omega = ones(K,1) ;
    u = ones(L,1) ;
    ppt1 (:,:,i) = pt1 ;
    pt1 = zeros(T,K) ;
    ppt2 (:,:,i) = pt2 ;
    pt2 = zeros(T,L) ;
end
EGHExp = mean (GHExp) ;
pt1 = mean(ppt1,3) ;
pt2 = mean(ppt2,3) ;
BH = mean(Bhat,3) ;
figure
xx = 1:200:2000;  vv = 2000:2000:6000; kk = 6000:2000:T;
f = [xx vv kk];
% plot probabilities over channel selection
plot(f,pt1(f,1),'-x',f,pt1(f,2),'-o',f,pt1(f,3),'->','LineWidth',1)

hold on
% plot probabilities over powe selection

plot(f,pt2(f,1),'--p',f,pt2(f,2),'--<',f,pt2(f,3),'--s',f,pt2(f,4),'--^',f,pt2(f,5),'--*','LineWidth',1)

axis([0 T 0 1]);xlabel('t'), ylabel('Probability');
legend('p_1','p_2','p_3','q_1','q_2','q_3','q_4','q_5');grid on ; box on ;

figure
plot(1:T+1,BH(:,1),'r',1:T+1,BH(:,2),'b',1:T+1,BH(:,3),'k')
axis([0 T 0 1])

mu = 1- sum (pt1.*BH(1:T,:),2) ; 
figure
x=1:T;
plot(x,mu,'k')
hold on
plot(x,ones(1,length(x))*(1-1/A^2),'r','LineWidth',2);grid on ; box on;
axis([1 T 0 1])