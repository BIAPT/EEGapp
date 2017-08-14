function ste_struct = ste_eegapp(EEG,winsize,NumWin,from,to,bandpass,dim,tau)

%   ste_eegapp  calculate symbolic transfer entropy
%   ste_struct = ste_eegapp(EEG,winsize,NumWin,from,to) calculate symbolic
%   transfer entropy and return a structure of the result.
%   ste_struct = ste_eegapp(EEG,winsize,NumWin,from,to,bandpass) same but
%   with filtering.
%   ste_struct = ste_eegapp(EEG,winsize,NumWin,from,to,bandpass,dim,tau)
%   same bute with filtering and custom dim and tau.
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   winsize = size of the windows to calculate ste. 
%   NumWin = number of windows to calculate ste.
%   from = a vector containing channels number
%   to = a vector containing channels number
%   bandpass = a string : full,alpha,beta,gamma,theta,delta with which you
%   wish to filter the data
%   dim and tau = see documentation.
%
%   Output:
%   ste_struct = structure containing the ste data. Will be equal to 0 if
%   there was an error.
% 

    %default is 0 for all bandpass
    full = 0;
    delta = 0;
    theta = 0;
    alpha = 0;
    beta = 0;
    gamma = 0;
 
    switch nargin
         case 5
             full = 1;
             dim = 3;
             tau = 1:2:30;
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
                 ste_struct = 0;
                 display('Error!');
                 display('bandpass argument need to be: full, delta, theta, alpha, beta or gamma');
                 return
             end
             
             dim = 3;
             tau = 1:2:30;
        case 7
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
                 ste_struct = 0;
                 display('Error!');
                 display('bandpass argument need to be: full, delta, theta, alpha, beta or gamma');
                 return
             end
             tau = 1:2:30;
        case 8
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
                 ste_struct = 0;
                 display('Error!');
                 display('bandpass argument need to be: full, delta, theta, alpha, beta or gamma');
                 return
             end
         otherwise
             ste_struct = 0;
             return
     end    
    
    %Preparing the EEG data
    samp_freq = EEG.srate;
    data = double(EEG.data);
    data = data';
    [m, num_comp] = size(data);
    
    %set up the variables needed for ste analysis
    winsize= winsize*samp_freq;% 
    TotalWin=floor(length(data)/winsize); % Total number of window
    RanWin=randperm(TotalWin); % Randomize the order
    UsedWin=RanWin(1:NumWin); % Randomly pick-up the windows
    UsedWin=sort(UsedWin);
    
    %Set up the waitbar and its parameters
    h = waitbar(0,'Please wait...','Name',sprintf('Symbolic Transfer Entropy Analysis'));
    totalTime = NumWin*length(from)*length(to);
    currentTime = 1;
    
        % Here we choose the low pass and high pass values for this iteration        
        if full == 1
            lp = 1.0; 
            hp = 50.0;
            current_ste = 'Fullband';
            display(['fullband(1-50Hz)']);
        elseif delta == 1
            lp = 1.0; 
            hp = 4.0;
            current_ste = 'Delta';
            display(['delta(1-4Hz)']);
        elseif theta == 1
            lp = 4.0; 
            hp = 8.0;
            current_ste = 'Theta';
            display(['theta(4-8Hz)']);
        elseif alpha == 1
            lp = 8.0; 
            hp = 13.0; 
            current_ste = 'Alpha';            
            display(['alpha(8-13Hz)']);
        elseif beta == 1
            lp = 13.0; 
            hp = 30.0;  
            current_ste = 'Beta';            
            display(['beta(13-30Hz)']);
        elseif gamma == 1
            lp = 30.0; 
            hp = 50.0;  
            current_ste = 'Gamma';            
            display(['gamma(30-50Hz)']);
        end     
    
        
        %Calculate STE for every source channels to every sink channels
        %And for every sink channels to every source channels
        for ch1=from(1):from(length(from))
            display(['From Channel: ', num2str(ch1)])
            for ch2=to(1):to(length(to))
                display(['To Channel: ', num2str(ch2)])
                for m=1:NumWin
                    win=UsedWin(m);
                    ini_point=(win-1)*winsize+1;
                    final_point=ini_point+winsize-1;
                    
                    x=data(ini_point:final_point,ch1);
                    y=data(ini_point:final_point,ch2);
                    
                    fdata1=bpfilter(lp,hp,samp_freq,x);
                    fdata2=bpfilter(lp,hp,samp_freq,y);
                    
                    delta=f_predictiontime(fdata1,fdata2,100);

                    for L=1:15
                        [STE(L,1:2), NSTE(L,1:2)] = f_nste([fdata1 fdata2], dim, tau(L), delta);
                    end
                                       
                    [mxNSTE, mxNTau]=max(NSTE);
                    [mxSTE, mxTau]=max(STE);
                    
                    ste.STE(m,ch2,ch1)=mxSTE(1);    % Sink to Source
                    ste.NSTE(m,ch2,ch1)=mxNSTE(1);
                    
                    ste.STE(m,ch1,ch2)=mxSTE(2);    % Source to Sink
                    ste.NSTE(m,ch1,ch2)=mxNSTE(2);
                           
                %Update the waitbar
                currentTime = currentTime+ 1;
                waitbar(currentTime/totalTime);
                end
            end
        end
        
        display(' ');
        display([current_ste ' band Symbolic Transfer Entropy Analysis :']);
        display('STE :')
        display(ste.STE)
        display('NSTE :')
        display(ste.NSTE);
        
        ste_struct = ste;
        close(h); %close the waitbar
end