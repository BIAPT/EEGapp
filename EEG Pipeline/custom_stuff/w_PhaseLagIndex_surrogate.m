function surro_WPLI=PhaseLagIndex_surrogate(X)
% Given a multivariate data, returns phase lag index matrix
% Modified the mfile of 'phase synchronization'
ch=size(X,2); % column should be channel
splice = randi(length(X));  % determines random place in signal where it will be spliced

a_sig=hilbert(X);
a_sig2= [a_sig(splice:length(a_sig),:); a_sig(1:splice-1,:)];  % %This is the randomized signal
surro_WPLI=ones(ch,ch);

for c1=1:ch-1
    for c2=c1+1:ch
        c_sig=a_sig(:,c1).*conj(a_sig2(:,c2));
        
        numer=abs(mean(imag(c_sig))); % average of imaginary
        denom=mean(abs(imag(c_sig))); % average of abs of imaginary
        
        surro_WPLI(c1,c2)=numer/denom;
        surro_WPLI(c2,c1)=surro_WPLI(c1,c2);
    end
end 

