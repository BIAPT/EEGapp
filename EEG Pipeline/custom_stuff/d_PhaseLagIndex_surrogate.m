function PLI=d_PhaseLagIndex_surrogate(X)
% Given a multivariate data, returns phase lag index matrix
% Modified the mfile of 'phase synchronization'
% PLI(ch1, ch2) : 
% if it is greater than 0.5, ch1->ch2
% if it is less than 0.5, ch2->ch1

ch=size(X,2); % column should be channel
splice = randi(length(X));  % determines random place in signal where it will be spliced

%%%%%% Hilbert transform and computation of phases
for i=1:ch
    x=X(:,i);
    %     phi0=angle(hilbert(x));  % only the phase component
    %     phi1(:,i)=unwrap(phi0);  % smoothing
    phi1(:,i)=angle(hilbert(x));
    phi2(:,i) = [phi1(splice:length(phi1),i); phi1(1:splice-1,i)];  % %This is the randomized signal
end

PLI=ones(ch,ch);

for ch1=1:ch
    for ch2=1:ch
        %%%%%% phase lage index
        PDiff=phi1(:,ch1)-phi2(:,ch2); % phase difference
%         PLI(ch1,ch2)=mean(sign(PDiff)); % only count the asymmetry
        PLI(ch1,ch2)=mean(heaviside(sin(PDiff)));
    end
end

% By definition,
% if PLI(ch1,ch2) is greater than 0.5, ch1 is leading ch2.
% if it is less than 0.5, ch1 is lagged by ch2.



