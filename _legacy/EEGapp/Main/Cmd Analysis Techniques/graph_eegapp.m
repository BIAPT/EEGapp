function graph_struct = graph_eegapp(EEG,network_thresh,win,bandpass)
%   graph_eegapp  calculate modularity, binary clustering, binary charpath,
%   global efficiency,binary smallworldness.
%   graph_struct = graph_eegapp(EEG,network_thresh,win) calculate graph
%   properties.
%   graph_struct = graph_eegapp(EEG,network,thresh,bandpass) same, but filter first the
%   data
%
%   Input:
%   EEG = eeg structure file coming from eeglab
%   network_thresh = number ranging from 0 to 100, used to construct a
%   binary matrix
%   win = The length in seconds of the each segments that will be used to 
%   calculate the relevant component of the graph theory analysis.r
%   bandpass = a string : full,alpha,beta,gamma,theta,delta with which you
%   wish to filter the data
%
%   Output:
%   graph_struct = a structure containing 5 properties of the graph. Will
%   return a 0 if there was an error.
%

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
                 graph_struct = 0;
                 display('Error!');
                 display('bandpass argument need to be: full, delta, theta, alpha, beta or gamma');
                 return
             end
         otherwise
             graph_struct = 0;
             return
     end

    %We load all variables needed for the analysis 
    total_length = EEG.xmax - EEG.xmin;

    %Create waitbar and initialize its parameters
    h = waitbar(0,'Please wait...','Name',sprintf('Graph Theory Analysis'));
    totalTime = floor((length(EEG.data))/(win*EEG.srate));
    currentTime = 1;

        
        %% Here we choose the low pass and high pass values for this iteration
        if full == 1
            lp = 1;
            hp = 50;    
        elseif delta == 1
            lp = 1;
            hp = 4;
        elseif theta == 1
            lp = 4;
            hp = 8;    
        elseif alpha == 1
            lp = 8;
            hp = 13;    
        elseif beta == 1
            lp = 13;
            hp = 30;
        elseif gamma == 1 
            lp = 30;
            hp = 50; 
        end

        display('Filtering the data: ');
        [dataset, com, b] = pop_eegfiltnew(EEG, lp, hp); %filtering EEG 
        filt_data = dataset.data';

        %% Set up
        %Here we create all the matrices
        b_charpath = zeros(1,floor(total_length/win));
        b_clustering = zeros(1,floor(total_length/win));
        b_geff = zeros(1,floor(total_length/win));
        bsw = zeros(1,floor(total_length/win));
        Q = zeros(1,floor(total_length/win));

        %% Graph Theory calculation
        for i = 1:(floor((length(filt_data))/(win*EEG.srate))) % Chunk data and calculate each part
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
           

            % Find average path length                          
            D = distance_bin(b_mat);
            [b_lambda,geff,~,~,~] = charpath(D,0,0);   % binary charpath
            [W0,R] = null_model_und_sign(b_mat,10,0.1);    % generate random matrix user input for 10 (permutation)

            % Find clustering coefficient
            C = clustering_coef_bu(b_mat);  

            % Find properties for random network
            [rlambda,rgeff,~,~,~] = charpath(distance_bin(W0),0,0);   % charpath for random network
            rC = clustering_coef_bu(W0); % cc for random network

            b_clustering(i) = nanmean(C)/nanmean(rC); % binary clustering coefficient
            b_charpath(i) = b_lambda/rlambda;  % charpath
            b_geff(i) = geff/rgeff; % global efficiency

            bsw(i) = b_clustering/b_charpath; % binary smallworldness

            [M,modular] = community_louvain(b_mat,1); % community, modularity

            Q(i) = modular; %modularity
            currentTime = currentTime + 1;
            waitbar(currentTime/totalTime); %Update the waitbar value 
        end
        
        %Creating the struct file to be saved or printed
        graph_struct = struct('b_clustering',b_clustering,'b_charpath',b_charpath,'b_geff',b_geff,'bsw',bsw,'modularity',Q);
        close(h);
end