function errors = spectopo_function(EEG,spectopo_prp,workingDirectory,check_data,isWarning)
    %This function is called by the main function when the Spectopo is selected
    %and the launch analysis button is pressed
try
    errors = 0;
    
    % Preparing print/save for spectopo
    print_spect = spectopo_prp.print_spect;
    save_spect = spectopo_prp.save_spect; 
    print_topo = spectopo_prp.print_topo; 
    save_topo = spectopo_prp.save_topo; 
    
    % Spectrogram
    fp = spectopo_prp.fp;
    numberTaper = spectopo_prp.numberTaper;
    stepSize = spectopo_prp.stepSize; 
    timeBandwidth = spectopo_prp.timeBandwidth; 
    tso = spectopo_prp.tso; 
    windowLength = spectopo_prp.windowLength; 

    %Create a directory if it doesn't exist to save data        
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && (save_topo == 1 || save_spect == 1)
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %Compute Spectrogram
    data = EEG.data; 
    params.tapers = [timeBandwidth numberTaper];
    params.Fs = EEG.srate;
    params.fpass = [fp];
    params.trialave = 1;
    
    [S, t, f] = mtspecgramcWaitBar(data', [windowLength stepSize], params);

    y = medfilt1(S, tso, 2);  % This performs temporal smoothing with a median filter of order tso7
    set(0,'DefaultFigureVisible','off');%disable output to screen

    %Create the figure for the spectrogram
    spect_plot = figure;
    plot_matrix(y, t, f);
    title(strcat(EEG.filename,' Spectrogram(Average of all electrodes)'));
    ylabel('Frequency','fontsize',12);
    xlabel('Time','fontsize',12);
    movegui(spect_plot,'west');
    
    %Save it to right directory
    if save_spect == 1
       %we create the right directory and concatenaate the right name          
       if ~exist(strcat(savingDirectory,'/Spectrogram'),'dir')
            mkdir(savingDirectory,'Spectrogram');
       end
       figName = '/Spectrogram/';
       figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
       figName = strcat(figName,'_');
       figName = strcat(figName,datestr(now, 'HH-MM-SS'));
                   
       %Make the log string name
       logName = strcat(figName,'_input.txt');
       dataName = strcat(figName,'_data.mat');
       figName = strcat(figName,'.fig');
       
       set(spect_plot,'CreateFcn','set(gcf,''Visible'',''on'')');    
       saveas(spect_plot,[savingDirectory figName]);
       set(spect_plot,'CreateFcn','set(gcf,''Visible'',''off'')');
       data_path = [savingDirectory dataName];
       save(data_path,'y','t','f');
       
       %Log the inputs
       fid = fopen([savingDirectory logName],'w+');
       fprintf(fid,'File Name: %s\n',EEG.filename);    
       fprintf(fid,'Frequency Pass : [%.2fHZ %.2fHZ]\n',fp(1,1),fp(1,2));
       fprintf(fid,'Temporal Smoothing Median Filter : %d\n',tso);
       fprintf(fid,'Time-Bandwidth Product : %d\n',timeBandwidth);
       fprintf(fid,'Number of Tapers : %d\n',numberTaper);
       fprintf(fid,'Windows Length : %d seconds\n',windowLength);
       fprintf(fid,'Step size : %.2f\n',stepSize);
       fclose(fid);
    end
 
    
    %Here we load the variabes for Topographic map
    freqidx = spectopo_prp.freqidx; 
    frequencies = spectopo_prp.frequencies; 
    
    
    %Problem
   [eegspecdB,freqs,compeegspecdB,resvar,specstd] = spectopo(EEG.data,length(EEG.data),EEG.srate,'chanlocs', EEG.chanlocs,'freqfac',2,'plot','off');
    
    %Here we prepare warnings to be outputed to screen
    lfidx = length(freqidx);
    if lfidx > 4
        warningLabel = sprintf('Only the first 4 Frequencies are plotted.');
    lfidx = 4;
    else
        warningLabel = sprintf('');
    end
    
    %Here we prepare some more warnings
    for i = 1:lfidx
       if frequencies(i) > (EEG.srate)/2
          warningLabel =strcat(warningLabel,sprintf('\nFrequencies %.1fHz is higher than half the sampling rate! Rounding to %.1fHz.',frequencies(i),EEG.srate/2)); 
          set(findobj('Tag','Output'), 'String', warningLabel);
          frequencies(i) = EEG.srate/2;
          freqidx(i) = (2*frequencies(i)) + 1;
       end
       
       if mod(frequencies(i),0.5) ~= 0
           acc = 0.5;
           warningLabel =strcat(warningLabel,sprintf('\nOnly 0.5 increment are allowed %.1fHz will be rounded to nearest acceptable value.', frequencies(i)));
           frequencies(i) = round(frequencies(i)/acc)*acc;
           freqidx(i) = (2*frequencies(i)) + 1;
       end
    end
    
    %Here we calculate the topographic map
    for i=1:lfidx
        topodata(:,i) = eegspecdB(:,freqidx(1,i)) - mean(eegspecdB(:,freqidx(1,i)));
    end
    %This prepare the rows and columns needed for the subplots
    mapframes = 1:size(eegspecdB,1);
    if lfidx == 1
        rows = 1;
        cols = 1;
    elseif lfidx == 2
        rows = 1;
        cols = 2;
    else
       rows = 2;
       cols = 2;
    end
    
    % Here we make the plot
    topo_plot = figure;
    for i=1:lfidx
        subplot(rows,cols,i);
        disp(['Calculating Topographic Map #' num2str(i)])
        topoplot(topodata(mapframes,i),EEG.chanlocs,'maplimits','absmax', 'electrodes', 'off');
        title_text = num2str(frequencies(i));
        title([title_text 'Hz']);
        colorbar;
    end
    movegui(topo_plot,'east');
    
    %Here we save the topographic map in the right directory
    if save_topo == 1
       if ~exist(strcat(savingDirectory,'/TopographicMap'),'dir')
            mkdir(savingDirectory,'TopographicMap');
       end
       figName = '/topographicMap/';
       figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
       figName = strcat(figName,'_');
       figName = strcat(figName,datestr(now, 'HH-MM-SS'));
       
       %Make the log string name
       logName = strcat(figName,'_input.txt');
       dataName = strcat(figName,'_data.mat');
       figName = strcat(figName,'.fig');
       set(topo_plot,'CreateFcn','set(gcf,''Visible'',''on'')');   
       saveas(topo_plot,[savingDirectory figName]) ;
       set(topo_plot,'CreateFcn','set(gcf,''Visible'',''off'')');
       data_path = [savingDirectory dataName];
       save(data_path,'topodata');       
       
       fid = fopen([savingDirectory logName],'w+');
       fprintf(fid,'File Name: %s\n',EEG.filename);
       fprintf(fid,'Frequencies : ');
       if(size(frequencies) <= 4)
            fprintf(fid,' %d',frequencies(:,:));
       else
           fprintf(fid,' %d',frequencies(:,1:4));
       end
       fclose(fid);
    end
    
    %Here we show the output to the screen
    set(0,'DefaultFigureVisible','on');

    if print_spect == 1 || check_data == 1
        figure(spect_plot)
    end
    
    if print_topo == 1 || check_data == 1
        figure(topo_plot)
    end
    
    %Here we output a warning to the screen (only if there has been no
    %warning outputted to the screen)
    if isempty(warningLabel) == 0
        if isWarning == 0
            w = msgbox(warningLabel,'Warning!');
            movegui(w,'north');
            assignin('base','isWarning',1);
        end
    end
    
catch Exception
     errors = 1;
     disp(Exception.getReport());
     return
end    

end