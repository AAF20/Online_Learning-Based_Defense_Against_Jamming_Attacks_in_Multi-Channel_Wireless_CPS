function  [p,pr] = Probablity (omega,Gama,K)
summ = sum(omega(:)) ;
p = ( (1-Gama) .* ( omega ./ summ ) ) + ( Gama / K ) ;  % probability assigning to each channel at time t
pr = p ;
p(K+1) = 0 ;