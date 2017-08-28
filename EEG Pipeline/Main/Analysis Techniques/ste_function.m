 function errors = ste_function(EEG,ste_prp,workingDirectory)
    %This function is called by the main function when the STE is selected
    %and the launch analysis button is pressed
    
    %Set up the waitbar and its parameters
    h = waitbar(0,'Please wait...','Name',sprintf('Symbolic Transfer Entropy Analysis'));    
try 
    errors = 0;
    %Preparing the EEG data
    samp_freq = EEG.srate;
    data = double(EEG.data);
    data = data';
    %[m, num_comp] = size(data);
    
    %set up the variables needed for ste analysis
    winsize=(ste_prp.winsize)*samp_freq;% 
    TotalWin=floor(length(data)/winsize); % Total number of window
    NumWin= ste_prp.numberwin ;
    RanWin=randperm(TotalWin); % Randomize the order
    UsedWin=RanWin(1:NumWin); % Randomly pick-up the windows
    UsedWin=sort(UsedWin);
    
    dim= ste_prp.dim;
    tau=ste_prp.tau;
                    
    
    %Here we load the rest of the variables
    print_ste = ste_prp.print;
    save_ste = ste_prp.save;
        
    full_ste = ste_prp.full;
    delta_ste = ste_prp.delta;
    theta_ste = ste_prp.theta;
    alpha_ste = ste_prp.alpha;
    beta_ste = ste_prp.beta;
    gamma_ste = ste_prp.gamma;
    
    from = ste_prp.fromchan;
    to = ste_prp.tochan;

    %Create a directory if it doesn't exist to save data    
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_ste == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %Calculating the number of plots needed
    plot_number = full_ste + delta_ste + theta_ste + alpha_ste + beta_ste + gamma_ste;
    
    totalTime = plot_number*NumWin*length(from)*length(to);
    currentTime = 1;
    
    %Calculation of the STE will be done one bandpass after the other
    for sub=1:plot_number

        % Here we choose the low pass and high pass values for this iteration        
        if full_ste == 1
            lp = 1.0; 
            hp = 50.0;
            display('fullband(1-50Hz)');
        elseif delta_ste == 1
            lp = 1.0; 
            hp = 4.0;
            display('delta(1-4Hz)');
        elseif theta_ste == 1
            lp = 4.0; 
            hp = 8.0;    
            display('theta(4-8Hz)');
        elseif alpha_ste == 1
            lp = 8.0; 
            hp = 13.0;    
            display('alpha(8-13Hz)');
        elseif beta_ste == 1
            lp = 13.0; 
            hp = 30.0;    
            display('beta(13-30Hz)');
        elseif gamma_ste == 1
            lp = 30.0; 
            hp = 50.0;    
            display('gamma(30-50Hz)');
        end     
    
        %Calculate STE for every source channels to every sink channels
        %And for every sink channels to every source channels
        

        ste.STE = NaN(NumWin,EEG.nbchan,EEG.nbchan);
        ste.NSTE = NaN(NumWin,EEG.nbchan,EEG.nbchan);
        
        for ch1=1:EEG.nbchan
            %If ch1 is in from then do this loop
            if(any(ch1==from))
            display(['From Channel: ', num2str(ch1)])
            
            for ch2=1:EEG.nbchan
                %if ch2 is in to then do this loop
                if(any(ch2==to))
                display(['To Channel: ', num2str(ch2)])
                STE = NaN(15,2);
                NSTE = NaN(15,2);
                              
                for m=1:NumWin
                    win=UsedWin(m);
                    ini_point=(win-1)*winsize+1;
                    final_point=ini_point+winsize-1;
                    
                    x=data(ini_point:final_point,ch1);
                    y=data(ini_point:final_point,ch2);
                    
                    fdata1=bpfilter(lp,hp,samp_freq,x);
                    fdata2=bpfilter(lp,hp,samp_freq,y);
                    
                    delta=f_predictiontime(fdata1,fdata2,50);%100); %Maybe something here

                    for L=1:15
                        [STE(L,1:2), NSTE(L,1:2)] = f_nste([fdata1 fdata2], dim, tau(L), delta);
                    end
                                       
                    [mxNSTE, ~]=max(NSTE); %mxNSTE and mxNTau
                    [mxSTE, ~]=max(STE); 
                    
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
            end
        end
        
        %Here we turn off those the bandpass we already did
        if full_ste == 1
            full_ste = 0;
            current_ste = 'Fullband';
        elseif delta_ste == 1
            delta_ste = 0;
            current_ste = 'Delta';
        elseif theta_ste == 1
            theta_ste = 0;
            current_ste = 'Theta';
        elseif alpha_ste == 1
            alpha_ste = 0;
            current_ste = 'Alpha';
        elseif beta_ste == 1
            beta_ste = 0;
            current_ste = 'Beta';
        elseif gamma_ste == 1
            gamma_ste = 0;
            current_ste = 'Gamma';
        end

        %Here we print the STE result to the screen
        if print_ste == 1
            display(' ');
            display([current_ste ' band Symbolic Transfer Entropy Analysis :']);
            display('STE :')
            display(ste.STE)
            display('NSTE :')
            display(ste.NSTE);
        end
    
        %Here we save the STE to the correct directory
        if save_ste == 1
           %we create the right directory and concatenaate the right name             
            if ~exist(strcat(savingDirectory,'/Symbolic Transfer Entropy'),'dir')
                mkdir(savingDirectory,'Symbolic Transfer Entropy');
            end
            structName = '/Symbolic Transfer Entropy/';
            structName = strcat(structName,current_ste);
            structName = strcat(structName,datestr(now, 'dd-mmm-yyyy'));
            structName = strcat(structName,'_');
            structName = strcat(structName,datestr(now, 'HH-MM-SS'));

            %Make the log string name
            logName = strcat(structName,'_steinput.txt');
            
            structName = strcat(structName,'_ste');
            save([savingDirectory structName],'ste'); %Long Term save
            
            structName = '/Symbolic Transfer Entropy/';
            structName = strcat(structName,current_ste);
            structName = strcat(structName,'ste');
            save([savingDirectory structName],'ste'); %Short term save
            
            %Log the inputs
            fid = fopen([savingDirectory logName],'w+');
            fprintf(fid,'File Name: %s\n',EEG.filename);
            fprintf(fid,'Bandpass filetring: %s\n',current_ste);
            fprintf(fid,'Windows size : %d seconds\n',winsize/samp_freq);
            fprintf(fid,'Number of Windows : %d\n',NumWin);
            fprintf(fid,'Source Channels : ');
            fprintf(fid,' %d',from);
            fprintf(fid,'\nSink Channels : ');
            fprintf(fid,' %d',to);
            fprintf(fid,'\nDim : %d\n',dim);
            fprintf(fid,'Tau : ');
            fprintf(fid,' %d',tau);
            fclose(fid);
        
        end
    end
    close(h); %close the waitbar
    
catch Exception
    close(h);
    warndlg('Symbolic Transfer Entropy ran into some trouble, please click help->documentation for more information on Symbolic Transfer Entropy.','Errors')
    disp(Exception.getReport());
    errors = 1;
    return
end

return        
 end