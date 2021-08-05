clc; clear ; close all; 

% This code implements the discrete Kalman filter:
% CPS paramters A, C, Q, R is given as inputs, the outputs of
% steady state covariance error, beta_c is computed.

s.x = [0.2 ; 0.1]; % states intial values
s.A = 1.5 ; % matrix A [1 0.5 ; 0 1.5]
s.C = 0.7; % 
s.Q = 0.8; %
s.R = 0.8; % 
s.B = 0;
s.u = 0;
s.P = 0 ; %[0 0 ; 0 0];
s.z = [0];
   for i = 1 :1000 
   % Prediction for state vector and covariance:
   s.x = s.A*s.x + s.B*s.u;
   s.P = s.A * s.P * s.A' + s.Q;
   % Compute Kalman gain factor:
   K = s.P*s.C'*inv(s.C*s.P*s.C'+s.R);
   % Correction based on observation:
   s.x = s.x + K*(s.z-s.C*s.x);
   s.P = s.P - K*s.C*s.P;
   end
SteadyStateCovarianc= s.P
MaximumEigen= eigs(s.A)
beta_c = 1/MaximumEigen^2
