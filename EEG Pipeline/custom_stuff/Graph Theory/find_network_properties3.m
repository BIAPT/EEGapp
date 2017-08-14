function find_network_properties3

%   This function defines a network like Joon's paper, but normalizes
%   properties according to random networks

samp_freq = 500;
network_thresh = 0.3;
win = 10;   % number of seconds of EEG window
total_length = 1680;    % total number of seconds of EEG epoch

for subject = 2
    switch subject
        case 1
            sname = 'MDFA03';
            EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,101,102,103,104,105,106,108,109,110,111,112,116,117,118,122,123,129];
        case 2
            sname = 'MDFA05';
            EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,101,102,103,104,105,106,108,109,110,111,112,116,117,118,122,123,129];
        case 3
            sname = 'MDFA06';
            EEG_chan = [2,3,4,5,6,7,8,9,10,11,13,14,16,17,18,20,21,23,24,25,26,27,28,30,31,32,33,34,36,37,38,39,42,43,46,47,48,49,50,51,52,53,54,55,56,58,59,60,63,64,65,68,69,70,71,72,73,76,77,78,79,80,83,84,85,86,89,90,91,94,95,96,97,98,99,100,101,102,103,104,107,108,109,113,114,120];
        case 4
            sname = 'MDFA07';
            EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,17,18,20,21,23,24,25,26,27,28,30,31,32,33,34,36,37,38,40,41,42,45,46,47,48,49,50,52,53,54,55,56,59,60,61,63,65,66,69,70,71,72,73,74,77,78,79,80,81,84,85,86,87,90,91,92,94,95,96,97,98,99,100,101,102,103,104,108,109,110,114,120];
        case 5
            sname = 'MDFA10';
            EEG_chan = [2,3,4,5,6,8,9,10,12,13,15,16,17,19,20,21,23,24,25,26,27,28,30,31,32,33,34,36,37,38,39,42,43,46,47,48,49,50,51,54,54,55,56,57,60,61,62,65,68,69,70,71,72,73,76,77,78,79,80,83,84,85,86,89,90,91,94,95,96,97,98,100,101,102,106,107,108,112,113,118];
        case 6
            sname = 'MDFA11';
            EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,48,49,50,51,52,55,56,57,58,59,62,63,64,67,68,69,72,73,74,75,76,77,80,81,82,83,84,87,88,89,90,93,94,95,98,99,100,101,102,103,105,106,107,108,109,113,114,115,119,120,126];
        case 7
            sname = 'MDFA12';
            EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,101,102,103,104,105,106,108,109,110,111,112,116,117,118,122,123,129];
       case 8 
           sname = 'MDFA15';
           EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,100,101,102,103,104,105,107,108,109,110,111,115,116,117,121,122,128];
       case 9
           sname = 'MDFA17';
           EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,101,102,103,104,105,106,108,109,110,111,112,116,117,118,122,123,129];
    end
    
%     Larray = zeros(10,total_length/win);
%     Carray = zeros(10,total_length/win);
%     geffarray = zeros(10,total_length/win);
%     bswarray = zeros(10,total_length/win);
%     Qarray = zeros(10,total_length/win);

     Larray = zeros(1,total_length/win);
     Carray = zeros(1,total_length/win);
     geffarray = zeros(1,total_length/win);
     bswarray = zeros(1,total_length/win);
     Qarray = zeros(1,total_length/win);

    
    for bp = [1:5]
        switch bp
            case 1
                bpname = ' all';
                lp = 1;
                hp = 30;
            case 2
                bpname = ' delta';
                lp = 1;
                hp = 4;
            case 3
                bpname = ' theta';
                lp = 4;
                hp = 8;
            case 4
                bpname = ' alpha';
                lp = 8;
                hp = 13;
            case 5
                bpname = ' beta';
                lp = 13;
                hp = 30;
        end
    
        for state = 11
            switch state
                case 1
                    statename = ' eyes closed 1';
                case 2
                    statename = ' induction first 5 min';
                case 3
                    statename = ' emergence first 5 min';
                case 4
                    statename = ' emergence last 5 min';
                case 5
                    statename = ' eyes closed 3';
                case 6
                    statename = ' eyes closed 4';
                case 7 
                    statename = ' eyes closed 5';
                case 8
                    statename = ' eyes closed 6';
                case 9
                    statename = ' eyes closed 7';
                case 10
                    statename = ' eyes closed 8';
                case 11
                    statename = ' unconscious epoch 1';
            end
        
            state
%           EEG = pop_loadset('filename', [sname statename '.set'],'filepath',['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis']);
            EEG = pop_loadset('filename', [sname statename '.set'],'filepath',['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\cleaned data']);

                
            [dataset, com, b] = pop_eegfiltnew(EEG, lp, hp);    
            filt_data = dataset.data';
        
            b_charpath = zeros(1,total_length/win);
            b_clustering = zeros(1,total_length/win);
            b_geff = zeros(1,total_length/win);
            bsw = zeros(1,total_length/win);
            Q = zeros(1,total_length/win);
            
            for i = 1:(floor((length(filt_data))/(win*samp_freq)))
                
                EEG_seg = filt_data((i-1)*win*samp_freq + 1:i*win*samp_freq, EEG_chan);      % Only take win seconds length from channels that actually have EEG
            
                PLI = w_PhaseLagIndex(EEG_seg);
                      
                A = sort(PLI);
                B = sort(A(:));
                C = B(1:length(B)-length(EEG_chan)); % Remove the 1.0 values from B
            
                index = floor(length(C)*(1-network_thresh));
                thresh = C(index);  % Values below which the graph will be assigned 0, above which, graph will be assigned 1
            
            
            % Create a network based on top network_thresh% of PLI connections    
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
                [b_lambda,geff,~,~,~] = charpath(D);   % binary charpath
                [W0,R] = null_model_und_sign(b_mat,10,0.1);    % generate random matrix
                
                  % Find clustering coefficient

                C = clustering_coef_bu(b_mat);  
                
                % Find properties for random network
                
                [rlambda,rgeff,~,~,~] = charpath(distance_bin(W0));   % charpath for random network
                rC = clustering_coef_bu(W0); % cc for random network
                                  
                b_clustering(i) = nanmean(C)/nanmean(rC); % binary clustering coefficient
                b_charpath(i) = b_lambda/rlambda;  % charpath
                b_geff(i) = geff/rgeff; % global efficiency
                
                bsw(i) = b_clustering/b_charpath; % binary smallworldness
                
                [M,modular] = community_louvain(b_mat,1); % community, modularity
                Q(i) = modular;
                    
            end
            
%             Larray(state,:) = b_charpath; 
%             Carray(state,:) = b_clustering;
%             geffarray(state,:) = b_geff;
%             bswarray(state,:) = bsw;
%             Qarray(state,:) = Q;

             Larray = b_charpath; 
             Carray = b_clustering;
             geffarray = b_geff;
             bswarray = bsw;
             Qarray = Q;
                     
        end
    
        dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname ' emergence ' bpname '_Lnorm.txt'], Larray);
        dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname ' emergence ' bpname '_Cnorm.txt'], Carray);
        dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname ' emergence ' bpname '_geffnorm.txt'], geffarray);
        dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname ' emergence ' bpname '_bsw.txt'], bswarray);
        dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname ' emergence ' bpname '_Qnorm.txt'], Qarray);
       
    end
    
end

 %figure; plot(Lnorm)
                
