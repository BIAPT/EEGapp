function [T, T_s] = f_nste(data, dim, lag, delta)
% only applied for bivrate data
% (c1,c2): c2 -> c0
% That is, Column to Row
ch=size(data,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part1. STE of original data %%%%%%%%%%%%%%%%%%

Ddata=delayRecons(data, lag, dim); % embedding
for c=1:ch
    INT(:,c)=F_Symb2Int(Ddata(:,:,c)); % transform to symbol
end
Int_future=INT(1+delta:end,:);
Int_past=INT(1:end-delta,:);

% compute probability
[P1, P2, P3, P4] = f_Integer2prob(Int_future(:,1), Int_past(:,1), Int_past(:,2));
T(1) = sum( P1 .* (log2( P1.*P4 ) - log2(P2.*P3)) );
[P1, P2, P3, P4] = f_Integer2prob(Int_future(:,2), Int_past(:,2), Int_past(:,1));
T(2) = sum( P1 .* (log2( P1.*P4 ) - log2(P2.*P3)) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part2. STE of shuffled data %%%%%%%%%%%%%%%%%%
% second data is shuffled
data2=data(:,2);
len=length(data2);halflen=floor(len/2);
shuffled_data2 = [data2(halflen+1:end,1); data2(1:halflen)];

Ddata=delayRecons([data(:,1) shuffled_data2], lag, dim);
clear INT;
for c=1:ch
    INT(:,c)=F_Symb2Int(Ddata(:,:,c));
end
Int_future=INT(1+delta:end,:);
Int_past=INT(1:end-delta,:);

[P1, P2, P3, P4] = f_Integer2prob(Int_future(:,1), Int_past(:,1), Int_past(:,2));
sft_T = sum( P1 .* (log2( P1.*P4 ) - log2(P2.*P3)) );
%H_XY =  sum ( P1.*(log2(P2) - log2(P1.*P2))); *** SEE BOTTOM OF CODE
H_XY = -sum ( P3./P4.*(log2(P3) - log2(P4))) 
T_s(1) = (T(1) - sft_T)/H_XY;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% Part3. STE of shuffled data %%%%%%%%%%%%%%%%%%
% first data is shuffled
data1=data(:,1);
len=length(data2);halflen=floor(len/2);
shuffled_data1 = [data1(halflen+1:end,1); data1(1:halflen)];

Ddata=delayRecons([shuffled_data1 data(:,2)], lag, dim);
clear INT;
for c=1:ch
    INT(:,c)=F_Symb2Int(Ddata(:,:,c));
end
Int_future=INT(1+delta:end,:);
Int_past=INT(1:end-delta,:);

[P1, P2, P3, P4] = f_Integer2prob(Int_future(:,2), Int_past(:,2), Int_past(:,1));
sft_T = sum( P1 .* (log2( P1.*P4 ) - log2(P2.*P3)) );
%H_XY =  sum ( P1.*(log2(P2) - log2(P1.*P2))); *** SEE BOTTOM OF CODE
H_XY = -sum ( P3./P4.*(log2(P3) - log2(P4))) 
T_s(2) = (T(2) - sft_T)/H_XY;

%*** NSTE didn't give the right output with this line of code
% we redid the derivation and we found out that this line should be
% replaced by the one below (as suggested by Dr. Chang)
display('new version running!')


















