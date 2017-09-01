function errors = dpli_function(EEG,dpli_prp,workingDirectory,orderType,newOrder)
    %This function is called by the main function when the dPLI is selected
    %and the launch analysis button is pressed

    %Create waitbar and initialize its parameters
    h = waitbar(0,'Please wait...','Name',sprintf('dPli Analysis'));
    
try
    errors = 0;    
    settings = evalin('base','settings');
    full_bp = settings.options.full;
    alpha_bp = settings.options.alpha;
    beta_bp = settings.options.beta;
    delta_bp = settings.options.delta;
    theta_bp = settings.options.theta;
    gamma_bp = settings.options.gamma;
    %If there was an ordering specified by the Reorder program
    %We rearrenge the EEG data so to have them in the correct ordering
    originalData = EEG.data;
    if strcmp(orderType,'custom') == 1
        for i=1:EEG.nbchan
            EEG.data(i,:) = originalData(newOrder(i,1),:);
        end
    end
    
    %We load all variables needed for the analysis
    data_length = dpli_prp.data_length; 
    number_permutation = dpli_prp.permutation;
    p_value = dpli_prp.p_value; 

    print_dpli = dpli_prp.print;
    save_dpli = dpli_prp.save;

    fullband_dpli = dpli_prp.full;
    delta_dpli = dpli_prp.delta;
    theta_dpli = dpli_prp.theta;
    alpha_dpli = dpli_prp.alpha;
    beta_dpli = dpli_prp.beta;
    gamma_dpli = dpli_prp.gamma;

    
    %Create a directory if it doesn't exist to save data
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_dpli == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %Calculating the number of plots needed
    plot_number = fullband_dpli + delta_dpli + theta_dpli + alpha_dpli + beta_dpli + gamma_dpli;
    
    %Convert from seconds to points
    conversion = EEG.srate;
    pts_length = floor(data_length*conversion);
    
    %Calculate the maximum number of segment to calculate
    maximum = floor(EEG.pnts / pts_length); 


    dPLIcorr = zeros(maximum,EEG.nbchan, EEG.nbchan); % initialize matrix

    totalTime = plot_number*maximum;
    currentTime = 1;

    %Calculation of the dPLI will be done one bandpass after the other
    for sub=1:plot_number
        set(0,'DefaultFigureVisible','off'); %Disabling printing to screen
                
        for i = 1:maximum
            %Here we check which band we have
            %and we filter accordingly
            if fullband_dpli == 1
                data_eeg = bpfilter(full_bp(1,1),full_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['fullband(',num2str(full_bp(1,1)),'Hz-',num2str(full_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif delta_dpli == 1
                data_eeg = bpfilter(delta_bp(1,1),delta_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['delta(',num2str(delta_bp(1,1)),'Hz-',num2str(delta_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif theta_dpli == 1
                data_eeg = bpfilter(theta_bp(1,1),theta_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['theta(',num2str(theta_bp(1,1)),'Hz-',num2str(theta_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif alpha_dpli == 1
                data_eeg = bpfilter(alpha_bp(1,1),alpha_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['alpha(',num2str(alpha_bp(1,1)),'Hz-',num2str(alpha_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif beta_dpli == 1
                data_eeg = bpfilter(beta_bp(1,1),beta_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['beta(',num2str(beta_bp(1,1)),'Hz-',num2str(beta_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            elseif gamma_dpli == 1
                data_eeg = bpfilter(gamma_bp(1,1),gamma_bp(1,2),EEG.srate,double((EEG.data(1:EEG.nbchan,1+(i-1)*pts_length:i*pts_length))'));
                display(['gamma(',num2str(gamma_bp(1,1)),'Hz-',num2str(gamma_bp(1,2)),'Hz) pli segment ',num2str(i),' of ',num2str(maximum)]);
            end
            
            dPLI_surr = zeros(number_permutation,EEG.nbchan,EEG.nbchan); %Initialize surrogate matrix
            dPLI = d_PhaseLagIndex(data_eeg); %calculate the dPLI
            
            %Calculating the surrogate
            display('Calculating surrogate:');
            parfor j = 1:number_permutation
                display([num2str(j),'/',num2str(number_permutation)]);
                dPLI_surr(j,:,:) = d_PhaseLagIndex_surrogate(data_eeg);
            end
            
            %Here we compare the calculated dPLI versus the surrogate
            %and test for significance
            
            %if the result is significant then 4 conditions are possible
            %1.dPLI value is greater than 0.5 and the median of the surrogate
            %is greater than 0.5
            %2.dPLI value is smaller than 0.5 and the median of the surrogate
            %is smaller than 0.5
            %3.dPLI is greater than 0.5 and median of surrogate is smaller
            %than 0.5
            %4.dPLI is smaller than 0.5 and median of surrogate is greater
            %than 0.5
            for m = 1:length(dPLI)
                for n = 1:length(dPLI)
                    test = dPLI_surr(:,m,n);
                    p = signrank(test, dPLI(m,n)); 
                    if p < p_value % 4 Conditions 
                        if dPLI(m,n) > 0.5 && median(test) > 0.5
                            gap = dPLI(m,n) - median(test);
                                if(gap < 0)
                                    dPLIcorr(i,m,n) = 0.5; 
                                else
                                    dPLIcorr(i,m,n) = gap + 0.5; %Gap is positive here
                                end  
                        elseif dPLI(m,n) < 0.5 && median(test) < 0.5 % CASE 2
                            gap = dPLI(m,n) - median(test);
                            if(gap > 0)
                                dPLIcorr(i,m,n) = 0.5; 
                            else
                                dPLIcorr(i,m,n) = gap + 0.5; %Gap is negative here
                            end
                        elseif dPLI(m,n) > 0.5 && median(test) < 0.5 %CASE 3
                            extra = 0.5 - median(test);
                            dPLIcorr(i,m,n) = dPLI(m,n) + extra;
                        elseif dPLI(m,n) < 0.5 && median(test) > 0.5 %CASE 4
                            extra = median(test) - 0.5;
                            dPLIcorr(i,m,n) = dPLI(m,n) - extra;
                        end
                    else
                        dPLIcorr(i,m,n) = 0.5;
                    end
                end
            end         
            currentTime = currentTime + 1;
            waitbar(currentTime/totalTime); %Here we update the waitbar
        end
        
        %The z_score is the average of all segments
        z_score = zeros(EEG.nbchan, EEG.nbchan);
        for a = 1:maximum
            for i = 1:length(dPLI)
                for j = 1:length(dPLI)
                    z_score(i,j) = z_score(i,j) + dPLIcorr(a,i,j);
                end
            end
        end
        z_score = z_score/maximum;

        %Here we turn off those the bandpass we already did
        if fullband_dpli == 1
            fullband_dpli = 0;
            current_dpli = 'Fullband';
        elseif delta_dpli == 1
            delta_dpli = 0;
            current_dpli = 'Delta';
        elseif theta_dpli == 1
            theta_dpli = 0;
            current_dpli = 'Theta';
        elseif alpha_dpli == 1
            alpha_dpli = 0;
            current_dpli = 'Alpha';
        elseif beta_dpli == 1
            beta_dpli = 0;
            current_dpli = 'Beta';
        elseif gamma_dpli == 1
            gamma_dpli = 0;
            current_dpli = 'Gamma';
        end

        %Make the plot of the dPLI
        dpli_plot = figure;
        colormap('jet')
        imagesc(z_score);
        title(sprintf('dPLI of %s at Bandpass: %s',EEG.filename,current_dpli));
        colorbar;
        %caxis([0 1]); NOT REALLY NEEDED

        %Here we save the dPLI at the right place
        if save_dpli == 1
           %we create the right directory and concatenaate the right name
           if ~exist(strcat(savingDirectory,'/Directed Phase Lag Index'),'dir')
                mkdir(savingDirectory,'Directed Phase Lag Index');
           end
           figName = '/Directed Phase Lag Index/';
           figName = strcat(figName,current_dpli);
           figName = strcat(figName,datestr(now, 'dd-mmm-yyyy'));
           figName = strcat(figName,'_');
           figName = strcat(figName,datestr(now, 'HH-MM-SS'));
           
           %Make the log string name
           logName = strcat(figName,'_input.txt');
           dataName = strcat(figName,'_data.mat');
           figName = strcat(figName,'.fig');

           set(dpli_plot,'CreateFcn','set(gcf,''Visible'',''on'')');    
           saveas(dpli_plot,[savingDirectory figName]);
           set(dpli_plot,'CreateFcn','set(gcf,''Visible'',''off'')');
           data_path = [savingDirectory dataName];
           save(data_path,'z_score');
           
           %Log the inputs
           fid = fopen([savingDirectory logName],'w+');
           fprintf(fid,'File Name: %s\n',EEG.filename);
           fprintf(fid,'Bandpass filetring: %s\n',current_dpli);
           fprintf(fid,'Length of Analysis Segment: %d seconds\n',data_length);
           fprintf(fid,'Number of Permutations : %d \n',number_permutation);
           fprintf(fid,'p value for surrogate data analysis : %.2f\n',p_value);
           fclose(fid);
        end

        set(0,'DefaultFigureVisible','on'); %Here we turn plotting on
        %Print to the screen
        if print_dpli == 1
            set(0,'units','pixels');
            Pix_SS = get(0,'screensize');
            
            S.fh = figure('units','pixels',...
              'position',[1 1 Pix_SS(1,3)/3 Pix_SS(1,3) ],...
              'menubar','none',...
              'name','dPLI Interactive Plot',...
              'numbertitle','off',...
              'resize','off');
          
            s(2)=subplot(2,1,2);
            topoplot([],EEG.chanlocs,'style','blank','electrodes','labelpoint','chaninfo',EEG.chaninfo);

            s(1)=subplot(2,1,1);
            colormap('jet')
            imagesc(z_score,'hittest','off');
            title(sprintf('dPLI of %s at Bandpass: %s',EEG.filename,current_dpli));
            colorbar;

            S.ax = gca;
            set(S.ax,'unit','pix','position',[Pix_SS(1,3)/40 Pix_SS(1,4)/1.8 Pix_SS(1,3)/4 Pix_SS(1,3)/4]);
            S.XLM = get(S.ax,'xlim');
            S.YLM = get(S.ax,'ylim');
            S.AXP = get(S.ax,'pos');
            S.DFX = diff(S.XLM);
            S.DFY = diff(S.YLM);
            set(s(1),'buttondownfcn',{@topofunction,S,EEG,s});
        end
    end

    close(h) %close the waitbar
    
catch Exception
    close(h);
    warndlg('Directed Phase Lag Index ran into some trouble, please click help->documentation for more information on Directed Phase Lag Index.','Errors')
    disp(Exception.getReport());
    errors = 1;
    return
end

return
end

function [] = topofunction(varargin)
%TOPOFUNCTION Summary of this function goes here
%   Detailed explanation goes here
    S = varargin{3};  % Get the structure.
    s = varargin{5};
    current_EEG=varargin{4};
    
F = get(S.fh,'currentpoint');  % The current point w.r.t the figure.
% Figure out of the current point is over the axes or not -> logicals.
tf1 = S.AXP(1) <= F(1) && F(1) <= S.AXP(1) + S.AXP(3);
tf2 = S.AXP(2) <= F(2) && F(2) <= S.AXP(2) + S.AXP(4);

if tf1 && tf2
    % Calculate the current point w.r.t. the axes.
    Cx =  ceil(S.XLM(1) + (F(1)-S.AXP(1)).*(S.DFX/S.AXP(3)));
    Cy =  ceil(S.YLM(1) + (F(2)-S.AXP(2)).*(S.DFY/S.AXP(4)));
    Cy = current_EEG.nbchan - Cy + 1;
    display(['X electrode pos: ', num2str(Cx), ' and Y electrode pos: ', num2str(Cy)]);
end

for i = 1:current_EEG.nbchan
    
    if( i == Cx || i == Cy)
        %display(i);
    else
       current_EEG.chanlocs(i).labels = ' ';
    end
end

cla(s(2))
subplot(s(2))
topoplot([],current_EEG.chanlocs,'style','blank','electrodes','labelpoint','chaninfo',current_EEG.chaninfo);
end