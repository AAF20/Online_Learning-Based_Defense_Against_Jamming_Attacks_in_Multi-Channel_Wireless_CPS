function [indx,psel] = ChannelSelection(p)

[p_prim,dim] = sort(p) ;
d = rand ;
s = sum( d > cumsum(p_prim) ) ;
indx = dim(s+1) ;  % The channel selected to be played
psel = p(indx);