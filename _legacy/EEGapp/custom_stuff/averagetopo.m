function [h grid plotrad, xmesh, ymesh] = averagetopo(EEG)

%freqidx = 3;     % This gives me a frequency 0.98 Hz
freqidx = 10.5*2 + 1;   % This gives me frequency = 9.8 Hz

[eegspecdB,freqs,compeegspecdB,resvar,specstd] = spectopo(EEG.data,length(EEG.data),500,'chanlocs', EEG.chanlocs,'freqfac',2);
%[eegspecdB,freqs,compeegspecdB,resvar,specstd] = spectopo(EEG.data,length(EEG.data),500, 'freq', 1, 'chanlocs', EEG.chanlocs);
%eegspecdB = sqrt(mean(g.mapnorm.^4)) * eegspecdB;
%eegspecdB = 10*log10(eegspecdB);

freqs(22)

topodata = eegspecdB(:,freqidx);
size(topodata)
topodata = eegspecdB(:,freqidx)- mean(eegspecdB(:,freqidx));
%g.mapframes = 1:size(eegspecdB,1); % default to plotting all chans
mapframes = 1:size(eegspecdB,1); % default to plotting all chans
figure
[h grid plotrad, xmesh, ymesh] = topoplot(topodata(mapframes),EEG.chanlocs,'maplimits','absmax', 'electrodes', 'off');