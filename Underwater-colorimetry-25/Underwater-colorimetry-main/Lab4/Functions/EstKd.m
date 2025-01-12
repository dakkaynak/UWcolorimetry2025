function estKd = EstKd(KdPlusC, Kw, M, Lambda0)

estKd = M*abs( KdPlusC(Lambda0) - Kw(Lambda0) ) + Kw;

end



% function estKd = EstKd(KdPlusC, Kw, M, Lambda0)
% k_plus_c = 0.5*(KdPlusC(Lambda0) + KdPlusC(15));
% k_w = 0.5*(Kw(14) + Kw(15));
% 
% estKd = ( M'/M(14) )*( (k_plus_c - (k_plus_c-0.04)/1.2) - k_w ) + Kw;
% 
% end