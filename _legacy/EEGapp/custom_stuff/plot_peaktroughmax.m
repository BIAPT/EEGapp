function [plotamp] = plot_peaktroughmax(EEG)
% 
%EEG = pop_loadset('filename','Subject 2 HMM unconscious notch.set','filepath','C:\\Users\\Stefanie\\Documents\\Frontoparietal mechanisms study\\Subject 2\\HMM\\');

analyticEEG = EEG.pac.analyticEEG;
phase = angle(analyticEEG);
amp = abs(analyticEEG);

%ch = [6, 34]; % Channels that you want to analyze
binsize = pi/9;

for n = 1:EEG.nbchan    % Find average over all channels

    ch_phase = phase(n,:);
    ch_amp = amp(n,:);
    
    %   Sort amplitudes according to phase.  Sortamp adds the amplitude in
    %   (:,1) and keeps track of the total numbers added in (:,2)

    sortamp = zeros([18, 2]);

    for i = 1:length(ch_phase)
        if ch_phase(i) > -pi && ch_phase(i) < -pi + binsize
            sortamp(1,1) = sortamp(1) + ch_amp(i);
            sortamp(1,2) = sortamp(1,2) + 1;
        elseif ch_phase(i) > -pi + binsize && ch_phase(i) < -pi + 2*binsize
            sortamp(2,1) = sortamp(2) + ch_amp(i);
            sortamp(2,2) = sortamp(2,2) + 1;
        elseif ch_phase(i) > -pi + 2*binsize && ch_phase(i) < -pi + 3*binsize
            sortamp(3) = sortamp(3) + ch_amp(i);
            sortamp(3,2) = sortamp(3,2) + 1;
        elseif ch_phase(i) > -pi + 3*binsize && ch_phase(i) < -pi + 4*binsize
            sortamp(4) = sortamp(4) + ch_amp(i);
            sortamp(4,2) = sortamp(4,2) + 1;
        elseif ch_phase(i) > -pi + 4*binsize && ch_phase(i) < -pi + 5*binsize
            sortamp(5) = sortamp(5) + ch_amp(i);
            sortamp(5,2) = sortamp(5,2) + 1;
        elseif ch_phase(i) > -pi + 5*binsize && ch_phase(i) < -pi + 6*binsize
            sortamp(6) = sortamp(6) + ch_amp(i);
            sortamp(6,2) = sortamp(6,2) + 1;
        elseif ch_phase(i) > -pi + 6*binsize && ch_phase(i) < -pi + 7*binsize
            sortamp(7) = sortamp(7) + ch_amp(i);
            sortamp(7,2) = sortamp(7,2) + 1;
        elseif ch_phase(i) > -pi + 7*binsize && ch_phase(i) < -pi + 8*binsize
            sortamp(8) = sortamp(8) + ch_amp(i);
            sortamp(8,2) = sortamp(8,2) + 1;
        elseif ch_phase(i) > -pi + 8*binsize && ch_phase(i) < -pi + 9*binsize
            sortamp(9) = sortamp(9) + ch_amp(i);
            sortamp(9,2) = sortamp(9,2) + 1;
        elseif ch_phase(i) > -pi + 9*binsize && ch_phase(i) < -pi + 10*binsize
            sortamp(10) = sortamp(10) + ch_amp(i);
            sortamp(10,2) = sortamp(10,2) + 1;
        elseif ch_phase(i) > -pi + 10*binsize && ch_phase(i) < -pi + 11*binsize
            sortamp(11) = sortamp(11) + ch_amp(i);
            sortamp(11,2) = sortamp(11,2) + 1;
        elseif ch_phase(i) > -pi + 11*binsize && ch_phase(i) < -pi + 12*binsize
            sortamp(12) = sortamp(12) + ch_amp(i);
            sortamp(12,2) = sortamp(12,2) + 1;
        elseif ch_phase(i) > -pi + 12*binsize && ch_phase(i) < -pi + 13*binsize
            sortamp(13) = sortamp(13) + ch_amp(i);
            sortamp(13,2) = sortamp(13,2) + 1;
        elseif ch_phase(i) > -pi + 13*binsize && ch_phase(i) < -pi + 14*binsize
            sortamp(14) = sortamp(14) + ch_amp(i);
            sortamp(14,2) = sortamp(14,2) + 1;
        elseif ch_phase(i) > -pi + 14*binsize && ch_phase(i) < -pi + 15*binsize
            sortamp(15) = sortamp(15) + ch_amp(i);
            sortamp(15,2) = sortamp(15,2) + 1;
        elseif ch_phase(i) > -pi + 15*binsize && ch_phase(i) < -pi + 16*binsize
            sortamp(16) = sortamp(16) + ch_amp(i);
            sortamp(16,2) = sortamp(16,2) + 1;
        elseif ch_phase(i) > -pi + 16*binsize && ch_phase(i) < -pi + 17*binsize
            sortamp(17) = sortamp(17) + ch_amp(i);
            sortamp(17,2) = sortamp(17,2) + 1;
        elseif ch_phase(i) > -pi + 17*binsize && ch_phase(i) < -pi + 18*binsize
            sortamp(18) = sortamp(18) + ch_amp(i);
            sortamp(18,2) = sortamp(18,2) + 1;
        end
    end

end
    
    %   Calculate average amplitude;

    for i = 1:18
        if sortamp(i,2) == 0
            avgsortamp(i) = 0;
        else
            avgsortamp(i) = (sortamp(i,1)/sortamp(i,2));
        end
    end
    
    avgamp = mean(avgsortamp);
    
    for i = 1:18
        plotamp(i) = (avgsortamp(i)-avgamp)/avgamp + 1;
    end
    
    plotamp = plotamp - 1;            % Do this because median filter assumes 0 on each side
    plotamp = medfilt1(plotamp, 2);   % January 16, 2014
    plotamp = plotamp + 1;
    
    set(gca, 'XTick', [1, 9, 20], 'XtickLabel', [-pi, 0, pi], 'XLim', [0 21]);
    xlabel('Phase');
    ylabel('Average amplitude');
    %str = ['-p', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'p'];
    %xlabel(str);
    %set(gca, 'xticklabel', str, 'fontname', 'symbol');
%end