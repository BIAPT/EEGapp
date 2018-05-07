function surro_PLI=PhaseLagIndex_surrogate(X)
% Given a multivariate data, returns phase lag index matrix
% Modified the mfile of 'phase synchronization'
ch=size(X,2); % column should be channel
%%%%%% Hilbert transform and computation of phases
% for i=1:ch
%     phi1(:,i)=angle(hilbert(X(:,i)));
% end
phi1=angle(hilbert(X));
length(phi1)
first_half = phi1(1:(length(phi1)/2));
second_half = phi1(length(phi1)/2:(length(phi1)-1));
phi2= [second_half, first_half];  % %This is the randomized signal
length(phi2)
surro_PLI=ones(ch,ch);
for ch1=1:ch-1
    for ch2=ch1+1:ch
        %%%%%% phase lage index
        PDiff=phi1(:,ch1)-phi2(:,ch2); % phase difference
        surro_PLI(ch1,ch2)=abs(mean(sign(sin(PDiff)))); % only count the asymmetry
        surro_PLI(ch2,ch1)=surro_PLI(ch1,ch2);
    end
end


