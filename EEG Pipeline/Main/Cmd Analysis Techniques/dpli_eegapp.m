function errors = dpli_eegapp(EEG,data_length,permutation,p_value,bandpass,custom_order)

%   dpli_eegapp  calculate directed phase lag index.
%   errors = dpli_eegapp(EEG,data_length,permutation,p_value) calculate dpli.
%   errors = dpli_eegapp(EEG,data_length,permutation,p_value,bandpass)
%   same, but filter first the data
%   errors = dpli_eegapp(EEG,data_length,permutation,p_value,bandpass,custom_order)
%   same but also provide a custom ordering of the channels
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   data_length = length of the windows of data to calculate the dpli. 
%   permutation = number of permutation to do the surrogate data analysis.
%   p_value = ranging from 0 to 1, the p value that is required to make the dpli analysis
%   bandpass = a string : full,alpha,beta,gamma,theta,delta with which you
%   wish to filter the data
%   custom_order = a vector containing all channels in a particular
%   ordering
%
%   Output:
%   errors = 0 if a error occured and 1 if not error
%   Will also print a plot of the dpli.
%
%   See also pli_eegapp.

%default is 0 for all bandpass
    full = 0;
    delta = 0;
    theta = 0;
    alpha = 0;
    beta = 0;
    gamma = 0;
    orderType = 'default';
    
     switch nargin
         case 4
             full = 1;
         case 5
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
         case 6
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
             
             orderType = 'custom';
             newOrder = custom_order;
         otherwise
             errors = 0;
             return
     end


    dpli_prp = struct('data_length',data_length,'permutation',permutation,...
    'p_value',p_value,'full',full,'delta',delta,...
    'theta',theta,'alpha',alpha,'beta',beta,'gamma',gamma,...
    'print',1,'save',0);

    if(strcmp(orderType,'default') == 1)
       newOrder = 1:EEG.nbchan; 
    end
    dpli_function(EEG,dpli_prp,pwd,orderType,newOrder);

end