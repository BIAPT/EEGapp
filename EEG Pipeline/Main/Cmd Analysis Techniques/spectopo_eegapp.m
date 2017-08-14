function errors = spectopo_eegapp(EEG,fp,tso,frequencies,timeBandwidth,numberTaper,windowLength,stepSize)

%   coherence_eegapp  calculate coherence.
%   errors = spectopo_eegapp(EEG,fp,tso,frequencies) calculate spectrogram
%   and topographic map using default value for time bandwidth, number of
%   taper, windows length and step size
%   errors = spectopo_eegapp(EEG,fp,tso,frequencies,timeBandwidth,numberTaper,windowLength,stepSize)
%   custom value for the four optional parameters
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   fp = frequency pass, two numbers corresponding to a low pass and an
%   high pass given like this [a b]
%   tso = temporal smoothing median filter order, used to reduce the noise in the spectrogram 
%   frequencies = used to plot the topographic map, will plot up to 4
%   frequencies.
%   timeBandwith and numberTaper = see documentation
%   windowLength = length of the window over which the spectrum will be
%   calculated
%   stepSize = the step length over which to move thw window.
%
%   Output:
%   errors = 0 if a error occurred and 1 if not.
%   Will also print a plot of the spectrogram and of the topographic map.
%

    switch nargin
       case 4
            timeBandwidth = 2;
            numberTaper = 3;
            windowLength = 2;
            stepSize = 0.1;
       case 5
            numberTaper = 3;
            windowLength = 2;
            stepSize = 0.1; 
       case 6
            windowLength = 2;
            stepSize = 0.1;    
       case 7
            stepSize = 0.1;
       case 8
            %do nothing we are good
       otherwise
            errors = 0;
       return 
    end
    
    freqidx = (2*frequencies) + 1; 
    
    
    spectopo_prp = struct('fp',fp,'tso',tso,'timeBandwidth',timeBandwidth,...
   'numberTaper',numberTaper,'windowLength',windowLength,'stepSize',stepSize,...
   'freqidx',freqidx,'frequencies',frequencies,'print_spect',1,...
   'save_spect',0,'print_topo',1,'save_topo',0);
  
    check_data = 0;
    isWarning = 0;
    
    errors = spectopo_function(EEG,spectopo_prp,pwd,check_data,isWarning);
    evalin('base','clear check_data isWarning');
end