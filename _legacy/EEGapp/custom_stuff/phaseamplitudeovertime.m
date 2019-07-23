function[plotamp, EEGpac] = phaseamplitudeovertime(EEG)

samp_freq = 500;
%analysis_epoch = 2*60*samp_freq;   % 2 minute epochs

% Divide EEG into one minute epochs

%for i = 1:40
for i = 1:4
    mintime = (i-1)*60;
    maxtime = i*60;
    EEG_segment = pop_select(EEG, 'time', [mintime maxtime]);
%    EEG_segment_frontal = pop_select(EEG_segment, 'channel', [3 4 6 8 9]);
%    EEG_segment_parietal = pop_select(EEG_segment, 'channel', [33 34 36 38]);
    
    % Find phase amplitude coupling of minute epoch

     EEG_withpac = pac_man(EEG_segment, 'lfoPhase', [0.1,1], 'hfoAmp', [8 14],...
               'hfoTopRatio', 100, 'hfoPool', 1, 'whichMarker', 1, 'windowLength', [], 'alpha', 0.05, 'numSurro', 2000,...
               'numPhaseBin', 18);
 %   EEG_withpac_parietal = pac_man(EEG_segment_parietal, 'lfoPhase', [0.1,1], 'hfoAmp', [8 14],...
 %              'hfoTopRatio', 100, 'hfoPool', 1, 'whichMarker', 1, 'windowLength', [], 'alpha', 0.05, 'numSurro', 2000,...
 %              'numPhaseBin', 18);
     phase(i,:) = EEG_withpac.pac.phaseProbability;
     amp(i,:) = EEG_withpac.pac.phaseSortedAmp;
     mi(i,:) = EEG_withpac.pac.mi;
     mipval(i,:) = EEG_withpac.pac.Bonferroni.MIpval;
 
 
 %  This will give plot a "modulogram" - i.e. the distribution of
 %  amplitudes over the phases 
     [plotamp(i,:)] = plot_peaktroughmax(EEG_withpac);
     
end

 EEGpac.phase = phase;
 EEGpac.amp = amp;
 EEGpac.mi = mi;
 EEGpac.mipval = mipval;