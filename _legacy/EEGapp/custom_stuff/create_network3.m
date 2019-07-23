function create_network2(network_thresh)

% This function takes a network threshold based on the PLI values calcuated
% across all 10 resting states

%network_thresh = 0.3;

for subject = 9
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

    for state = 1:10
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
        end
        
        file = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname statename '_PLI.mat']);
        
        bpPLI = file.PLI{4};    % 4 gives me alpha
        
        % Take only the channels that record EEG
        for i = 1:length(EEG_chan)
            for j = 1:length(EEG_chan)
                EEG_bpPLI(i,j) = bpPLI(EEG_chan(i),EEG_chan(j));
            end
        end
                
        A = sort(EEG_bpPLI);
        B = sort(A(:));
        
        C(state,:) = B(1:length(B)-length(EEG_chan)); % Remove the 1.0 values from B
        
    end
    
    D = sort(C(:));
       
    index = floor(length(D)*(1-network_thresh));
    thresh = D(index);       % Values below which the graph will be assigned 0, above which, graph will be assigned 1        

    for state = 1:10
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
        end
        
        file = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname statename '_PLI.mat']);
        bpPLI = file.PLI{4};    % 4 gives me alpha
    
        % Take only the channels that record EEG
        for i = 1:length(EEG_chan)
            for j = 1:length(EEG_chan)
                EEG_bpPLI(i,j) = bpPLI(EEG_chan(i),EEG_chan(j));
            end
        end
                
        for i = 1:length(EEG_bpPLI)
          for j = 1:length(EEG_bpPLI)
              if (EEG_bpPLI(i,j) > thresh)
                  network(i,j) = 1;
              else
                  network(i,j) = 0;
              end
          end
      end
      
      dlmwrite(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\Resting state analysis\' sname statename '_PLI network.txt'], network);
         
    end
end