function errors = coherence_eegapp(EEG,from,to,bandpass)

%   coherence_eegapp  calculate coherence.
%   errors = coherence_eegapp(EEG,from,to) calculate coherence between channels set from and to.
%   errors = coherence_eegapp(EEG,from,to,bandpass) same, but filter first the
%   data
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   from = a vector containing channels number
%   to = a vector containing channels number
%   bandpass = a string : full,alpha,beta,gamma,theta,delta with which you
%   wish to filter the data
%
%   Output:
%   errors = 0 if a error occured and 1 if not error
%   Will also print a plot of the coherence between channels from and to.
%
%   See also mscohere.

    %default is 0 for all bandpass
    full = 0;
    delta = 0;
    theta = 0;
    alpha = 0;
    beta = 0;
    gamma = 0;
             
     switch nargin
         case 3
             full = 1;
         case 4
             if(strcmpi(bandpass,'full') == 1)
                 full = 1;
             elseif(strcmpi(bandpass,'delta') == 1)
                 delta = 1;
             elseif(strcmpi(bandpass,'theta') == 1)
                 theta = 1;
             elseif(strcmpi(bandpass,'alpha') == 1)
                 alpha = 1;
             elseif(strcmpi(bandpass,'beta') == 1)
                 beta = 1;
             elseif(strcmpi(bandpass,'gamma') == 1)
                 gamma = 1;
             else
                 errors = 0;
                 display('Error!');
                 display('bandpass argument need to be: full, delta, theta, alpha, beta or gamma');
                 return
             end
         otherwise
             errors = 0;
             return
     end
     
     coherence_prp = struct('source',from,'sink',to,...
    'full',full,'delta',delta,...
    'theta',theta,'alpha',alpha,...
    'beta',beta,'gamma',gamma,...
    'print',1,'save',0);

    errors = coherence_function(EEG,coherence_prp,pwd);
end
