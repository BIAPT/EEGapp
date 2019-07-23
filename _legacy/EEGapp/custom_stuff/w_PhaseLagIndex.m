function WPLI=w_PhaseLagIndex(bdata)
% INPUT:
%   bdata: band-pass filtered data

ch=size(bdata,2); % column should be channel
a_sig=hilbert(bdata);
WPLI=ones(ch,ch);

for c1=1:ch-1
    for c2=c1+1:ch
        c_sig=a_sig(:,c1).*conj(a_sig(:,c2));
        
        numer=abs(mean(imag(c_sig))); % average of imaginary
        denom=mean(abs(imag(c_sig))); % average of abs of imaginary
        
        WPLI(c1,c2)=numer/denom;
        WPLI(c2,c1)=WPLI(c1,c2);
    end
end 