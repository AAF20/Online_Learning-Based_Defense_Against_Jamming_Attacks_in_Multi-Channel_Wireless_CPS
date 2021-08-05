function   omega =  Weight (omega,Gama,K,Xhat)
omega = omega .* (exp ((Gama .* Xhat) ./ K) )  ;
