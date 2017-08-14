      function PLI=PhaseLagIndex(X)
% Given a multivariate data, returns phase lag index matrix
% Modified the mfile of 'phase synchronization'
ch=size(X,2); % column should be channel
%%%%%% Hilbert transform and computation of phases
% for i=1:ch
%     phi1(:,i)=angle(hilbert(X(:,i)));
% end
phi1=angle(hilbert(X));
PLI=ones(ch,ch);
for ch1=1:ch-1
    for ch2=ch1+1:ch
        %%%%%% phase lage index
        PDiff=phi1(:,ch1)-phi1(:,ch2); % phase difference
        PLI(ch1,ch2)=abs(mean(sign(sin(PDiff)))); % only count the asymmetry
        PLI(ch2,ch1)=PLI(ch1,ch2);
    end
end


