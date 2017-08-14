function errors = graph_theory_function(EEG,graph_prp,workingDirectory)
    %This function is called by the main function when Graph Theory is selected
    %and the launch analysis button is pressed
try    
    errors = 0;
    InterfaceObj=findobj(gcf,'Enable','on');
    
    %We load all variables needed for the analysis
    network_thresh = graph_prp.network_thresh; 
    win = graph_prp.win;  
    total_length = EEG.xmax - EEG.xmin;
    check_graph = graph_prp.check;  

    print_graph = graph_prp.print;
    save_graph = graph_prp.save;

    fullband_graph = graph_prp.full;
    delta_graph = graph_prp.delta; 
    theta_graph = graph_prp.theta; 
    alpha_graph = graph_prp.alpha;
    beta_graph = graph_prp.beta; 
    gamma_graph = graph_prp.gamma; 

    %Create a directory if it doesn't exist to save data
    if ~exist(strcat(workingDirectory,['/' EEG.filename]),'dir') && save_graph == 1
        mkdir(workingDirectory,EEG.filename);
    end
    savingDirectory = [workingDirectory '/' EEG.filename];
    
    %Calculating the number of plots needed
    plot_number = fullband_graph + delta_graph + theta_graph + alpha_graph + beta_graph + gamma_graph;

    %Create waitbar and initialize its parameters
    h = waitbar(0,'Please wait...','Name',sprintf('Graph Theory Analysis'));
    totalTime = plot_number*(floor((length(EEG.data))/(win*EEG.srate)));
    currentTime = 1;

    %Calculation of the dPLI will be done one bandpass after the other    
    for sub=1:plot_number

        already_checked = 0; %This check is needed for checking the graph
        
        %% Here we choose the low pass and high pass values for this iteration
        if fullband_graph == 1
            lp = 1;
            hp = 50;    
        elseif delta_graph == 1
            lp = 1;
            hp = 4;
        elseif theta_graph == 1
            lp = 4;
            hp = 8;    
        elseif alpha_graph == 1
            lp = 8;
            hp = 13;    
        elseif beta_graph == 1
            lp = 13;
            hp = 30;
        elseif gamma_graph == 1 
            lp = 30;
            hp = 50; 
        end

        display('Filtering the data: ');
        [dataset, ~, ~] = pop_eegfiltnew(EEG, lp, hp); %filtering EEG 
        filt_data = dataset.data';

        %% Set up
        %Here we create all the matrices
        b_charpath = zeros(1,floor(total_length/win));
        b_clustering = zeros(1,floor(total_length/win));
        b_geff = zeros(1,floor(total_length/win));
        bsw = zeros(1,floor(total_length/win));
        Q = zeros(1,floor(total_length/win));
        
        binary_matrix = zeros(1,EEG.nbchan,EEG.nbchan);
        degrees = zeros(1,EEG.nbchan);
        
        %% Graph Theory calculation
        for i = 1:(floor((length(filt_data))/(win*EEG.srate))) % Chunk data and calculate each part
            b_mat = zeros(EEG.nbchan,EEG.nbchan);
            EEG_seg = filt_data((i-1)*win*EEG.srate + 1:i*win*EEG.srate,:);% Select relevant channels
            PLI = w_PhaseLagIndex(EEG_seg); % Calculate PLI

            %--------Tresholding part----------------------
            A = sort(PLI); % sort pli
            B = sort(A(:)); % sort all value in A
            C = B(1:length(B)-EEG.nbchan); % Remove the 1.0 values from B

            index = floor(length(C)*(1-network_thresh)); 
            thresh = C(index);  % Values below which the graph will be assigned 0, above which, graph will be assigned 1    
            %----------------------------------------------

            % Create a network based on top network_thresh of PLI connections (binary matrix)    
            for m = 1:length(PLI)
                for n = 1:length(PLI)
                    if (m == n)
                        b_mat(m,n) = 0;
                    else
                        if (PLI(m,n) > thresh)
                            b_mat(m,n) = 1;
                        else
                            b_mat(m,n) = 0;
                        end
                    end
                end
            end                
            
            %If the check graph checkbox we call Brain net viewer
            if check_graph == 1  
                %This if statement is needed to make sure Brain Net viewer
                %isn't messing anything up
                if already_checked == 0 
                    
                    set(InterfaceObj,'Enable','off'); %Disabling Main
                    already_checked = 1;
                    display(' ');
                    display('This pipeline make use of BrainNet Viewer.');
                    %Writing the edge and node file
                    %NEED TO DO NODE FILE
                    
                    channelsLocation = EEG.chanlocs;
                    growth = 10; %By multiplying everything by growth we preserve the locations
                    
                    the_x = zeros(EEG.nbchan-1,1);
                    the_y = zeros(EEG.nbchan-1,1);
                    the_z = zeros(EEG.nbchan-1,1);
                    nodeMatrix = zeros(EEG.nbchan-1,5);
                    for j =1:EEG.nbchan -1
                        the_x(j,1) = channelsLocation(1,j).X;
                        the_y(j,1) = channelsLocation(1,j).Y;
                        the_z(j,1) = channelsLocation(1,j).Z;

                        mni_x = the_x(j,1)*growth-20;
                        mni_y = the_y(j,1)*growth;
                        mni_z = the_z(j,1)*growth+15;

                        nodeMatrix(j,:) = [mni_y mni_x mni_z 4 3];
                    end
                    
                    %option = load('option.mat');
                    dlmwrite('EEGNode.node',nodeMatrix(:,:),'delimiter','\t');
                    dlmwrite('EEGedge.edge',b_mat(1:length(PLI)-1,1:length(PLI)-1),'delimiter','\t');
                    
                    BrainNet_MapCfg('BrainMesh_ICBM152.nv','EEGNode.node','EEGedge.edge','option.mat');
                    display('*************PLEASE NOTE****************')
                    display('Analysis will resume once you exited BrainNet Viewer.')
                    display('Turning on or off BrainNet Viewer may take some time, please be patient.')
                    uiwait(gcf);
                    
                    delete('EEGedge.edge');
                    delete('EEGNode.node');
                    
                    run('continue_analysis.m'); %call the continue figure
                    movegui(gcf,'center');
                    uiwait(gcf);
                    set(InterfaceObj,'Enable','on');
                    
                    %If not continue then we abort else we stay
                    continue_value = evalin('base','continue_value');
                    if continue_value == 1
                        display('will carry on with the analysis'); 
                        evalin('base','clear continue_value');
                    else
                        display('will not continue with analysis');
                        evalin('base','clear continue_value');
                        close(h);
                        return
                    end 
                end 
            end

            % Find average path length                          
            D = distance_bin(b_mat);
            [b_lambda,geff,~,~,~] = charpath(D,0,0);   % binary charpath
            [W0,~] = null_model_und_sign(b_mat,10,0.1);    % generate random matrix user input for 10 (permutation)
            % Find clustering coefficient
            C = clustering_coef_bu(b_mat);  

            % Find properties for random network
            [rlambda,rgeff,~,~,~] = charpath(distance_bin(W0),0,0);   % charpath for random network
            rC = clustering_coef_bu(W0); % cc for random network

            b_clustering(i) = nanmean(C)/nanmean(rC); % binary clustering coefficient
            b_charpath(i) = b_lambda/rlambda;  % charpath
            b_geff(i) = geff/rgeff; % global efficiency

            bsw(i) = b_clustering/b_charpath; % binary smallworldness

            [~,modular] = community_louvain(b_mat,1); % community, modularity

            Q(i) = modular; %modularity
            binary_matrix(i,:,:) = b_mat(:,:); %binary_matrx
            degrees(i,:) = degrees_und(b_mat); %degree for each window 
            
            currentTime = currentTime + 1;
            waitbar(currentTime/totalTime); %Update the waitbar value 
        end
        
        %Here we turn off those the bandpass we already did
        if fullband_graph == 1
            fullband_graph = 0;
            current_graph = 'Fullband';
        elseif delta_graph == 1
            delta_graph = 0;
            current_graph = 'Delta';
        elseif theta_graph == 1
            theta_graph = 0;
            current_graph = 'Theta';
        elseif alpha_graph == 1
            alpha_graph = 0;
            current_graph = 'Alpha';
        elseif beta_graph == 1
            beta_graph = 0;
            current_graph = 'Beta';
        elseif gamma_graph == 1
            gamma_graph = 0;
            current_graph = 'Gamma';
        end

        %Creating the struct file to be saved or printed
        graphTheoryData = struct('b_clustering',b_clustering,'b_charpath',b_charpath,'b_geff',b_geff,'bsw',bsw,'modularity',Q,'binary_matrix',binary_matrix,'degrees',degrees);

        %Here we print the data to the screen
        if print_graph == 1
            display(' ');
            display([current_graph ' band Graph Theory Analysis :']);
            display(graphTheoryData)
        end

        %Here we save the structure
        if save_graph == 1
           if ~exist(strcat(savingDirectory,'/Graph Theory'),'dir')
                mkdir(savingDirectory,'Graph Theory');
           end
           structName = '/Graph Theory/';
           structName = strcat(structName,current_graph);
           structName = strcat(structName,datestr(now, 'dd-mmm-yyyy'));
           structName = strcat(structName,'_');
           structName = strcat(structName,datestr(now, 'HH-MM-SS'));
           
           
           %Make the log string name
           logName = strcat(structName,'_graphTheroyInput.txt');
            
           structName = strcat(structName,'_graphTheoryData');

           save([savingDirectory structName],'graphTheoryData'); %Long Term save

           structName = '/Graph Theory/';
           structName = strcat(structName,current_graph);
           structName = strcat(structName,'graphData');
           save([savingDirectory structName],'graphTheoryData'); %Short term save
           
           %Log the inputs
            fid = fopen([savingDirectory logName],'w+');
            fprintf(fid,'File Name: %s\n',EEG.filename);
            fprintf(fid,'Bandpass filetring: %s\n',current_graph);
            fprintf(fid,'Network Treshold : %d%%\n',floor(network_thresh*100));
            fprintf(fid,'Windows length : %d',win);
            fclose(fid);
        end

    end

    close(h); %Close the waitbar
    
catch Exception
    close(h);
    warndlg('Graph Theory ran into some trouble, please click help->documentation for more information on Graph Theory.','Errors')
    disp(Exception.getReport());
    errors = 1;
    return
end

end