function errors = coherence_function(EEG,coherence_prp,workingDirectory)
    %This function is called by the main function when the coherence is selected
    %and the launch analysis button is pressed
try
    errors = 0;
    SF = EEG.srate;
    
    % Preparing print/save for spectopo
    print_coherence = coherence_prp.print; 
    save_coherence = coherence_prp.save; 
    
    full_coherence = coherence_prp.full; 
    delta_coherence = coherence_prp.delta;
    theta_coherence = coherence_prp.theta;
    alpha_coherence = coherence_prp.alpha; 
    beta_coherence = coherence_prp.beta; 
    gamma_coherence = coherence_prp.gamma; 
    
    from = coherence_prp.source; 
    to = coherence_prp.sink; 
    
    
    %Create a directory if it doesn't exist to save data        
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_coherence == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    
    %Calculating the number of plots needed
    plot_number = full_coherence + delta_coherence + theta_coherence + alpha_coherence + beta_coherence + gamma_coherence;
    h = waitbar(0,'Please wait...','Name',sprintf('Coherence Analysis'));
    totalTime = plot_number*length(from)*length(to);
    currentTime = 1;
     for sub=1:plot_number
        set(0,'DefaultFigureVisible','off');%disable output to screen
        
        % Here we choose the low pass and high pass values for this iteration        
        if full_coherence == 1
            lp = 1.0; 
            hp = 50.0;
            display('Computing coherence at fullband(1-50Hz)');
        elseif delta_coherence == 1
            lp = 1.0; 
            hp = 4.0;
            display('Computing coherence at delta(1-4Hz)');
        elseif theta_coherence == 1
            lp = 4.0; 
            hp = 8.0;    
            display('Computing coherence at theta(4-8Hz)');
        elseif alpha_coherence == 1
            lp = 8.0; 
            hp = 13.0;    
            display('Computing coherence at alpha(8-13Hz)');
        elseif beta_coherence == 1
            lp = 13.0; 
            hp = 30.0;    
            display('Computing coherence at beta(13-30Hz)');
        elseif gamma_coherence == 1
            lp = 30.0; 
            hp = 50.0;    
            display('Computing coherence at gamma(30-50Hz)');
        end
        
        data = bpfilter(lp, hp, SF, double(EEG.data'));
        index_ch1 = 1;
        avgCXY = zeros(length(from),length(to));
        
        for ch1 = 1:length(from);%from(1):from(length(from));
            index_ch2 = 1;
            for ch2 = 1:length(to);%to(1):to(length(to));
                d1 = data(:, from(ch1));
                d2 = data(:, to(ch2));
                [CXY, ~] = mscohere(d1, d2, [], [], [], SF);
                avgCXY(index_ch1, index_ch2) = mean(CXY);
            
                %Update the waitbar
                currentTime = currentTime+ 1;
                waitbar(currentTime/totalTime);
                index_ch2 = index_ch2 + 1;
            end
            index_ch1 = index_ch1 + 1;
        end
        
        %Here we turn off those the bandpass we already did
        if full_coherence == 1
            full_coherence = 0;
            current_coherence = 'Fullband';
        elseif delta_coherence == 1
            delta_coherence = 0;
            current_coherence = 'Delta';
        elseif theta_coherence == 1
            theta_coherence = 0;
            current_coherence = 'Theta';
        elseif alpha_coherence == 1
            alpha_coherence = 0;
            current_coherence = 'Alpha';
        elseif beta_coherence == 1
            beta_coherence = 0;
            current_coherence = 'Beta';
        elseif gamma_coherence == 1
            gamma_coherence = 0;
            current_coherence = 'Gamma';
        end
        
        coherence_plot = figure;
        sub_plot = subplot(1,1,1);
        imagesc([1 10],1,avgCXY,'Parent',sub_plot,'CDataMapping','scaled');
        title(sprintf('Coherence of %s at Bandpass: %s',EEG.filename,current_coherence));
        
        %Good enough, but still a bit weird
        xlabel('Channels set 2');
        NumTicks = length(to);
        L = get(gca,'XLim');
        set(gca,'XTick',linspace(L(1),L(2),NumTicks))
        set(gca,'XTickLabel',to)
        
        ylabel('Channels set 1');
        NumTicks = length(from);
        L = get(gca,'YLim');
        set(gca,'YTick',linspace(L(1),L(2),NumTicks))
        set(gca,'YTickLabel',from)
        %}
        colorbar('peer',sub_plot);
        
        %print
        set(0,'DefaultFigureVisible','on');
        if print_coherence == 1
            figure(coherence_plot);
        end
        
        if save_coherence == 1
           %we create the right directory and concatenaate the right name             
            if ~exist(strcat(savingDirectory,'/Coherence'),'dir')
                mkdir(savingDirectory,'Coherence');
            end
            
            %Make the output string name
            figName = '/Coherence/';
            figName = strcat(figName,current_coherence);
            figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
            figName = strcat(figName,'_');
            figName = strcat(figName,datestr(now, 'HH-MM-SS'));
            
            %Make the log string name
            logName = strcat(figName,'_input.txt');
            dataName = strcat(figName,'_data.mat');
            figName = strcat(figName,'.fig');
            
            set(coherence_plot,'CreateFcn','set(gcf,''Visible'',''on'')');    
            saveas(coherence_plot,[savingDirectory figName]); 
            set(coherence_plot,'CreateFcn','set(gcf,''Visible'',''off'')'); 
            data_path = [savingDirectory dataName];
            save(data_path,'avgCXY');            
            
            %Log the inputs
            fid = fopen([savingDirectory logName],'w+');
            fprintf(fid,'File Name: %s\n',EEG.filename);
            fprintf(fid,'Bandpass filetring: %s\n',current_coherence);
            fprintf(fid,'Set channels #1 :');
            fprintf(fid,' %d',from(:,:));
            fprintf(fid,'\nSet channels #2 : ');
            fprintf(fid,' %d',to(:,:));
            fclose(fid);
            
        end
     end
     close(h);
     
catch Exception
   close(h);
   warndlg('Coherence ran into some trouble, please click help->documentation for more information on Coherence.','Errors')
   disp(Exception.getReport());
   errors = 1;
   return
end

return

end