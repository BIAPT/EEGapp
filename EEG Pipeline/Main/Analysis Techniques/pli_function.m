function errors = pli_function(EEG,pli_prp,workingDirectory,orderType,newOrder)
    %This function is called by the main function when the PLI is selected
    %and the launch analysis button is pressed
try
    errors = 0;

    %If there was an ordering specified by the Reorder program
    %We rearrenge the EEG data so to have them in the correct ordering
    originalData = EEG.data;
    if strcmp(orderType,'custom') == 1
       for i=1:EEG.nbchan
           EEG.data(i,:) = originalData(newOrder(i,1),:);
       end
    end

    %We load all variables needed for the analysis    
    data_length = pli_prp.data_length;  
    number_permutation = pli_prp.permutation;  
    p_value = pli_prp.p_value;  

    print_pli = pli_prp.print; 
    save_pli = pli_prp.save; 

    fullband_pli = pli_prp.full; 
    delta_pli = pli_prp.delta; 
    theta_pli = pli_prp.theta; 
    alpha_pli = pli_prp.alpha; 
    beta_pli = pli_prp.beta; 
    gamma_pli = pli_prp.gamma; 

    %Create a directory if it doesn't exist to save data    
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_pli == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %Calculating the number of plots needed
    plot_number = fullband_pli + delta_pli + theta_pli + alpha_pli + beta_pli + gamma_pli;

    %Convert from seconds to points    
    conversion = EEG.srate;
    pts_length = floor(data_length*conversion);
    
    %Calculate the maximum number of segment to calculate    
    maximum = floor(EEG.pnts / pts_length);


    PLIcorr = zeros(maximum,EEG.nbchan, EEG.nbchan); % initialize matrix

    %Create waitbar and initialize its parameters    
    h = waitbar(0,'Please wait...','Name',sprintf('Pli Analysis'));
    totalTime = plot_number*maximum;
    currentTime = 1;

    %Calculation of the PLI will be done one bandpass after the other    
    for sub=1:plot_number
        set(0,'DefaultFigureVisible','off'); %Disabling printing to screen
        
        for i = 1:maximum
            
            PLI_surr = zeros(number_permutation,EEG.nbchan,EEG.nbchan); %initialize the matrix

            %Here we check which band we have
            %and we filter accordingly
            if fullband_pli == 1
                data_eeg = bpfilter(1.0,50.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['fullband(1-50Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif delta_pli == 1
                data_eeg = bpfilter(1.0,4.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['delta(1-4Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif theta_pli == 1
                data_eeg = bpfilter(4.0,8.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['theta(4-8Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif alpha_pli == 1
                data_eeg = bpfilter(8.0,13.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['alpha(8-13Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif beta_pli == 1
                data_eeg = bpfilter(13.0,30.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['beta(13-30Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif gamma_pli == 1
                data_eeg = bpfilter(30.0,50.0,EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['gamma(30-50Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            end
            
            PLI = w_PhaseLagIndex(data_eeg); %calculate weighted pli
            
            %Calculating the surrogate
            display('Calculating surrogate:');
            parfor j = 1:number_permutation
                display([num2str(j),'/',num2str(number_permutation)]);
                PLI_surr(j,:,:) = w_PhaseLagIndex_surrogate(data_eeg);
            end

            %Here we compare the calculated dPLI versus the surrogate
            %and test for significance            
            for m = 1:length(PLI)
                for n = 1:length(PLI)
                    test = PLI_surr(:,m,n);
                    p = signrank(test, PLI(m,n));       
                    if p < p_value
                        if PLI(m,n) - median(test) < 0 %Special case to make sure no PLI is below 0
                            PLIcorr(i,m,n) = 0;
                        else
                            PLIcorr(i,m,n) = PLI(m,n) - median(test);
                        end
                    else
                        PLIcorr(i,m,n) = 0;
                    end          
                end
            end
            currentTime = currentTime + 1;
            waitbar(currentTime/totalTime); %Here we update the waitbar
        end

        %The z_score is the average of all segments        
        z_score = zeros(EEG.nbchan, EEG.nbchan);
        for a = 1:maximum
            for i = 1:length(PLI)
                for j = 1:length(PLI)
                    z_score(i,j) = z_score(i,j) + PLIcorr(a,i,j);
                end
            end
        end
        z_score = z_score/maximum;

        %Here we turn off those the bandpass we already did
        if fullband_pli == 1
            fullband_pli = 0;
            current_pli = 'Fullband';
        elseif delta_pli == 1
            delta_pli = 0;
            current_pli = 'Delta';
        elseif theta_pli == 1
            theta_pli = 0;
            current_pli = 'Theta';
        elseif alpha_pli == 1
            alpha_pli = 0;
            current_pli = 'Alpha';
        elseif beta_pli == 1
            beta_pli = 0;
            current_pli = 'Beta';
        elseif gamma_pli == 1
            gamma_pli = 0;
            current_pli = 'Gamma';
        end

        %Make the plot of the PLI
        pli_plot = figure;
        colormap('jet')
        imagesc(z_score);
        title(sprintf('PLI(%0.0fx%0.0f) of %s at Bandpass: %s',EEG.nbchan,EEG.nbchan,EEG.filename,current_pli));
        colorbar;
        %caxis([0 1]); NOT REALLY NEEDED
        
        %Here we save the dPLI at the right place        
        if save_pli == 1
           %we create the right directory and concatenaate the right name            
            if ~exist(strcat(savingDirectory,'/Phase Lag Index'),'dir')
                mkdir(savingDirectory,'Phase Lag Index');
            end
            figName = '/Phase Lag Index/';
            figName = strcat(figName,current_pli);
            figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
            figName = strcat(figName,'_');
            figName = strcat(figName,datestr(now, 'HH-MM-SS'));
            
            %Make the log string name
            logName = strcat(figName,'_input.txt');
            dataName = strcat(figName,'_data.mat');
            figName = strcat(figName,'.fig');

            set(pli_plot,'CreateFcn','set(gcf,''Visible'',''on'')');    
            saveas(pli_plot,[savingDirectory figName]); 
            set(pli_plot,'CreateFcn','set(gcf,''Visible'',''off'')');
            data_path = [savingDirectory dataName];
            save(data_path,'z_score');
            
           %Log the inputs
           fid = fopen([savingDirectory logName],'w+');
           fprintf(fid,'File Name: %s\n',EEG.filename);
           fprintf(fid,'Bandpass filetring: %s\n',current_pli);
           fprintf(fid,'Length of Analysis Segment: %d seconds\n',data_length);
           fprintf(fid,'Number of Permutations : %d \n',number_permutation);
           fprintf(fid,'p value for surrogate data analysis : %.2f\n',p_value);
           fclose(fid);            
        end
        set(0,'DefaultFigureVisible','on');%Here we turn plotting on
        %Print to the screen        
        if print_pli == 1
            figure(pli_plot);
        end
        pli_plot = 0; % Reset the pli_plot to nothing
    end
    close(h); %close waitbar
    
catch Exception
    close(h);
    warndlg('Phase Lag Index ran into some trouble, please click help->documentation for more information on Phase Lag Index.','Errors')
    disp(Exception.getReport());
    errors = 1;
    return
end

return    
end