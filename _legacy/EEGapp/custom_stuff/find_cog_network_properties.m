function find_cog_network_properties

%   This function defines a network like Joon's paper, but normalizes
%   properties according to random networks

samp_freq = 500;
network_thresh = 0.3;
win = 10;   % number of seconds of EEG window

params.tapers = [3 5];
params.Fs = 500;
params.fpass = [0.5 30];
params.trialave = 1;

for subject = 1
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

%      Larray = zeros(1,total_length/win);
%      Carray = zeros(1,total_length/win);
%      geffarray = zeros(1,total_length/win);
%      bswarray = zeros(1,total_length/win);
%      Qarray = zeros(1,total_length/win);

    for state = 1:8
        switch state
            case 1
                statename = ' cognitive test 1';
            case 2
                statename = ' cognitive test 2';
            case 3
                statename = ' cognitive test 3';
            case 4
                statename = ' cognitive test 4';
            case 5
                statename = ' cognitive test 5';
            case 6
                statename = ' cognitive test 6';
            case 7 
                statename = ' cognitive test 7';
            case 8
                statename = ' cognitive test 8';
        end

        for ctest = 1:2
            switch ctest
                case 1
                    ctestname = ' AM';
                case 2
                    ctestname = ' PVT';
            end

        state
        %EEG = pop_loadset(['filename', [sname statename '.set'],'filepath',['D:\My Documents\Post-doc\CIHR postdoc\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\cleaned data']);
        EEG = load(['D:\Documents\McDonnell Foundation\' sname '\cognitive tests\' sname statename ctestname '.txt']);
        EEG = EEG'; % row is data, column is channel
        new_EEG = EEG(:,EEG_chan); % Only take the channels that are actually recording EEG

%         [S,t,f] = mtspecgramc(new_EEG, [2 0.1], params);
%         figure; plot_matrix(S,t,f); title([sname statename ctestname]);
%         [d1, t1, a1, b1] = plot_spectrogram_power(S);
%         
%         delta(state,ctest) = mean(d1);
%         theta(state,ctest) = mean(t1);
%         alpha(state,ctest) = mean(a1);
%         beta(state,ctest) = mean(b1);
        
             
%         figure('Color', [1 1 1]); 
%         subplot(2,2,1); plot(delta, 'LineWidth', 3); legend('AM', 'PVT');
%         subplot(2,2,2); plot(theta, 'LineWidth', 3); legend('AM', 'PVT');
%         subplot(2,2,3); plot(alpha, 'LineWidth', 3); legend('AM', 'PVT');
%         subplot(2,2,4); plot(beta, 'LineWidth', 3); legend('AM', 'PVT');
       
        
    for bp = 4
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
            
        filt_data = bpfilter(lp, hp, samp_freq, EEG);
        tl_a = length(EEG);
        tl_b = tl_a/10;
        tl_c = floor(tl_b);
        total_length = tl_c*10;
        
        b_charpath = zeros(1,total_length/win);
        b_clustering = zeros(1,total_length/win);
        b_geff = zeros(1,total_length/win);
        bsw = zeros(1,total_length/win);
        Q = zeros(1,total_length/win);
            
        for i = 1:(floor((length(filt_data))/(win*samp_freq)))

            EEG_seg = filt_data((i-1)*win*samp_freq + 1:i*win*samp_freq, EEG_chan);      % Only take win seconds length from channels that actually have EEG

            % Generate PLI network of significant connections
            
            PLI = w_PhaseLagIndex(EEG_seg);
            [corr_PLI,conn_ratio] = test_PLI_stats(PLI,EEG_seg); % Only keep connections that are not random
            PLI_array(:,:,i) = corr_PLI;
            
            %total_conn(i) = conn_ratio;
                      
            % Now create dPLI network based on the PLI connections that are
            % significant

            corr_dPLI = create_sig_dPLI(corr_PLI,EEG_seg);
            dPLI_array(:,:,i) = corr_dPLI;
            
            % Now create a binary correlation matrix of top 30% of PLI
            % connections            
            
            A = sort(corr_PLI);
            B = sort(A(:));
            C = B(1:length(B)-length(EEG_chan)); % Remove the 1.0 values from B

            index = floor(length(C)*(1-network_thresh));
            thresh = C(index);  % Values below which the graph will be assigned 0, above which, graph will be assigned 1
            
            % Create a network based on top network_thresh% of PLI connections    
            for m = 1:length(corr_PLI)
                for n = 1:length(corr_PLI)
                    if (m == n)
                        b_mat(m,n) = 0;
                    else
                        if (corr_PLI(m,n) > thresh)
                            b_mat(m,n) = 1;
                        else
                            b_mat(m,n) = 0;
                        end
                    end
                end
            end                
                
            % Find degrees

            deg(:,i) = degrees_und(b_mat);

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

        degarray = deg;             
        Larray = b_charpath; 
        Carray = b_clustering;
        geffarray = b_geff;
        bswarray = bsw;
        Qarray = Q;
                     
    end
    
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03\' sname statename bpname ctestname '_PLI.txt'], PLI_array);      
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03\' sname statename bpname ctestname '_dPLI.txt'], dPLI_array);      
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03\' sname statename bpname ctestname '_degree.txt'], degarray);
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03\' sname statename bpname ctestname '_Lnorm.txt'], Larray);
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03' sname statename bpname ctestname '_Cnorm.txt'], Carray);
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03\' sname statename bpname ctestname '_geffnorm.txt'], geffarray);
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03' sname statename bpname ctestname '_bsw.txt'], bswarray);
    dlmwrite(['D:\Documents\McDonnell Foundation\MDFA03' sname statename bpname ctestname '_Qnorm.txt'], Qarray);

    clear PLI_array dPLI_array degarray Larray Carray geffarray bswarray Qarray deg b_charpath b_clustering b_geff bsw Q
    
    end
    
    end

end


 %figure; plot(Lnorm)
                
