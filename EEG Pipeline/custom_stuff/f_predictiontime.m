function predtime = f_predictiontime(x,y,maxlag)
% Select the prediction time in STE as the time lag for the maximum
% cross-correlation between two signals
% if it is 0, then replace it with 1, otherwise, use the time lag.
% UCLEE, April 20th, 2012.


res=xcorr(x,y,maxlag);
xval = -maxlag:maxlag;

[vk,ik]=max(res);

tlag_max_cc=xval(ik);

if tlag_max_cc <= 1
    predtime =1;
else
    predtime = tlag_max_cc;
end


