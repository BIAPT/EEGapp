function errors = phase_amplitude_coupling_function(EEG,pac_prp,workingDirectory)
    %This function is called by the main function when PAC is selected
    %and the launch analysis button is pressed
    
    h = waitbar(0,'Please wait...','Name',sprintf('PAC Analysis'));%waitbar    
try    
    errors = 0;
    set(0,'DefaultFigureVisible','off'); %here we make sure no figure is outputed until print
%    InterfaceObj=findobj(gcf,'Enable','on');%Not useful
    
    %Load variables
    print_pac = pac_prp.print; 
    save_pac = pac_prp.save; 
    channels_pac = pac_prp.channels; 
    numberOfBin = pac_prp.numberOfBin; 

    LFO_bp = pac_prp.LFO_bp; 
    LFO_lp = LFO_bp(1,1);
    LFO_hp = LFO_bp(1,2);
    HFO_bp = pac_prp.HFO_bp; 
    HFO_lp = HFO_bp(1,1);
    HFO_hp = HFO_bp(1,2);
    window_length = pac_prp.window_length; 

    %Create a directory if it doesn't exist to save data
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_pac == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %calculate total number of seconds to consider
    total_time = EEG.xmax - EEG.xmin; %in seconds
    total_pnts = EEG.pnts;
    
    %Checks to make sure we have reasonable segment numbers
    if(window_length <= total_time)
        segment_num = total_time/window_length;
    else
        segment_num = 1; 
    end
    
    %Here we calculate how much points there is in a segment 
    if(segment_num ~= 1)
        segment_pnts = floor(total_pnts/segment_num);
    else
        segment_pnts = total_pnts - 1;
    end

    %Calculate the size of the bins
    segment_num = floor(segment_num);
    binsize = 2*pi/(numberOfBin);
    
    %Keep the EEG data of only the selected channels
    %Discard the rest
    data_pac = zeros([length(channels_pac), EEG.pnts]);
    for i=1:length(channels_pac)
       data_pac(i,:) = EEG.data(channels_pac(i,1),:);
    end
    
    %LFO filtering
    display('Filtering in progress...');
    LFO=bpfilter(LFO_lp,LFO_hp,EEG.srate,double(data_pac'));
    LFO = LFO';
    %HFO filtering
    HFO=bpfilter(HFO_lp,HFO_hp,EEG.srate,double(data_pac'));
    HFO = HFO';
    display('Filtering done.')
    
    %Here we extract the phase and the amplitude from LFO and HFO
    display('calculating Hilbert transform');
    phase = angle(hilbert(LFO)); %Take the angle of the Hilbert to get the phase
    amp = abs(hilbert(HFO)); %calculating the amplitude by taking absolute value of hilber
    display('Hilbert transform done.');
    total_plot(segment_num,numberOfBin) = zeros();

    %Set up the waitbar
    totalTime = segment_num*length(channels_pac);
    currentTime = 1;
    
    %Repeat the calculation below for each segment
    for segment=1:segment_num
        for n = 1:length(channels_pac)    % Find average over all channels

            ch_phase = phase(n,:);
            ch_amp = amp(n,:);
    
            %   Sort amplitudes according to phase.  Sortamp adds the amplitude in
            %   (:,1) and keeps track of the total numbers added in (:,2)
            sortamp = zeros([numberOfBin, 2]);
            for i = (((segment-1)*segment_pnts)+1):((segment*segment_pnts)+1)
                for j = 1:numberOfBin 
                    if ch_phase(i) > (-pi+(j-1)*binsize) && ch_phase(i) < (-pi+(j*binsize))
                        sortamp(j,1) = sortamp(j,1) + ch_amp(i);
                        sortamp(j,2) = sortamp(j,2) + 1;
                        break;
                    end
                end
            end
            currentTime = currentTime + 1;
            waitbar(currentTime/totalTime); %Here we update the waitbar
        end
    
        %   Calculate average amplit%ude;
        avgsortamp = zeros(1,numberOfBin);
        for i = 1:numberOfBin
            if sortamp(i,2) == 0
                avgsortamp(i) = 0;
            else
                avgsortamp(i) = (sortamp(i,1)/sortamp(i,2));
            end
        end
        
        avgamp = mean(avgsortamp);
        plotamp = zeros(1,numberOfBin);
        %For each bins set the value at that position
        for i = 1:numberOfBin
            plotamp(i) = (avgsortamp(i)-avgamp)/avgamp + 1;
        end
        
    
        plotamp = plotamp - 1;            % Do this because median filter assumes 0 on each side
        plotamp = medfilt1(plotamp, 2);   % January 16, 2014
        plotamp = plotamp + 1;
    
        %Create the plot segment by segment
        for i = 1:numberOfBin
            total_plot(segment,i) = plotamp(1,i);
        end
    
    end
    
    %Make the figure
    pac_plot = figure;
    imagesc(total_plot'); 
    
    %Format the Y axis
    ylabel('Phase');
    L = get(gca,'YLim');
    set(gca,'YTick',linspace(L(1),L(2),3))
    set(gca,'YTicklabel',{'-Pi' '0' 'Pi'})
    
    %Format the X axis
    NumTicks = 3;%segment_num + 1;
    step = 3;
    L = get(gca,'XLim');
    xlabel('Seconds');
    set(gca,'XTick',linspace(L(1),L(2),NumTicks))
    max_time = segment_num*window_length;
    set(gca,'XTickLabel',linspace(0,max_time,step))%[0:step:max_time])

    %Make a title and a colorbar
    title(sprintf('PAC of %s at LFO(%s,%s) and HFO(%s,%s)',EEG.filename,num2str(LFO_lp),num2str(LFO_hp),num2str(HFO_lp),num2str(HFO_hp)));
    colorbar;
    
    %Here we save the PAC plot at the right place
    if save_pac == 1
       %we create the right directory and concatenate the right name
       if ~exist(strcat(savingDirectory,'/Phase Amplitude Coupling'),'dir')
           mkdir(savingDirectory,'Phase Amplitude Coupling');
       end
       figName = '/Phase Amplitude Coupling/';
       figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
       figName = strcat(figName,'_');
       figName = strcat(figName,datestr(now, 'HH-MM-SS'));

       %Make the log string name
       logName = strcat(figName,'_input.txt');       
       dataName = strcat(figName,'_data.mat');
       figName = strcat(figName,'.fig');

       set(pac_plot,'CreateFcn','set(gcf,''Visible'',''on'')');    
       saveas(pac_plot,[savingDirectory figName]);
       set(pac_plot,'CreateFcn','set(gcf,''Visible'',''off'')');  
       data_path = [savingDirectory dataName];
       save(data_path,'total_plot');       
       
       %Log the inputs into a file
       fid = fopen([savingDirectory logName],'w+');
       fprintf(fid,'File Name: %s\n',EEG.filename);
       fprintf(fid,'Set of Channels to Analyze :');
       fprintf(fid,' %d',channels_pac(:,:));
       fprintf(fid,'\nWindows Length : %d seconds\n',window_length);
       fprintf(fid,'Numbers of Bins: %d\n',numberOfBin);
       fprintf(fid,'Low Frequency bandpass : [%.2fHZ %.2fHZ]\n',LFO_lp,LFO_hp);
       fprintf(fid,'High Frequency bandpass : [%.2fHZ %.2fHZ]\n',HFO_lp,HFO_hp);
       fclose(fid);
   end

   set(0,'DefaultFigureVisible','on'); %Here we turn plotting on
   
   %Print to the screen
   if print_pac == 1
        figure(pac_plot);
   end
        
    close(h); %Close the waitbar
catch Exception
    %if the code didn't work we output an error
    close(h);
    warndlg('Phase amplitude coupling ran into some trouble, please click help->documentation for more information on Graph Theory.','Errors')
    disp(Exception.getReport());
    errors = 1;
    return
end

    
end