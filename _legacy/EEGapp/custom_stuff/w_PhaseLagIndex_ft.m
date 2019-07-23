function [WPLI, f]=w_PhaseLagIndex_ft(data, segsize, segmove, fs)
% INPUT:
%   data: time by channel
%   segsize: segment size (unit: data bin) which determines frequenc res.
%   segmove: segment move size
%   fs: sampling frequency
%
% OUTPUT:
%   WPLI: channel by channel by frequency
%   f: frequency vector
%
% note that the diagonal component of WPLI is zero (not 1).

ch=size(data,2); % number of channels
segnum=floor((length(data)-segsize)/segmove+1); % number of segments
% hw = f_hanning(segsize)';
hw = hanning(segsize);
hw=repmat(hw,1,ch);

for u=1:segnum
    segdata=data(segmove*(u-1)+1:segmove*(u-1)+segsize,:); % segment data
    segdata_hw=detrend(segdata).*hw; % hanning windowed segment data
    y=fft(segdata_hw);
    y=y(1:end/2+1,:);
    for ff=1:size(y,1)
        yij(:,:,ff,u)=conj(y(ff,:)'*y(ff,:)); % cross-spectra: S
    end
end

numer=abs(mean(imag(yij),4)); % average of imaginary
denom=mean(abs(imag(yij)),4); % average of abs of imaginary
WPLI=numer./(denom+eps); % to prevent NaN in diagonal components

f=linspace(0, fs/2, segsize/2+1);