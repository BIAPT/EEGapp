function errors = pac_eegapp(EEG,channels,window_length,numberOfBin,LFO_bp,HFO_bp)

%   pac_eegapp  calculate phase amplitude coupling.
%   errors = pac_eegapp(EEG,channels,window_length,numberOfBin,LFO_bp,HFO_bp)
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   channels = a vector containing all channels to analyze
%   windows_length = length of the windows of data to calculate the pac. 
%   numberOfBin = number of bins to categorize the different phases.
%   LFO_bp = Low Frequencies Oscillation bandpass. Two numbers a low pass
%   and an high pass given like this [a b]
%   HFO_bp = High Frequencies Oscillation bandpass. Two numbers a low pass
%   and an high pass given like this [a b]
%
%   Output:
%   errors = 0 if a error occurred and 1 if not.
%   Will also print a plot of the phase amplitude coupling using imagesc.
%

    %Will need to carry some test to see if input is legal, but we assume
    %the user know what to do for now.

    pac_prp = struct('window_length',window_length,'numberOfBin',numberOfBin,...
    'channels',channels,'LFO_bp',LFO_bp,'HFO_bp',HFO_bp,'print',1,'save',0);
    assignin('base','pac_prp',pac_prp);
    
    errors = phase_amplitude_coupling_function(EEG,pac_prp,pwd);
end