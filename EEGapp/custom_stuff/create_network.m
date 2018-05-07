function create_network

network_thresh = 0.3;
EEG_chan = [2,3,4,5,6,7,9,10,11,12,13,15,16,18,19,20,22,23,24,26,27,28,29,30,31,33,34,35,36,37,39,40,41,42,45,46,47,50,51,52,53,54,55,58,59,60,61,62,65,66,67,70,71,72,75,76,77,78,79,80,83,84,85,86,87,90,91,92,93,96,97,98,101,102,103,104,105,106,108,109,110,111,112,116,117,118,122,123,129];

for subject = 2
   switch subject
        case 1
            sname = 'MDFA03';
        case 2
            sname = 'MDFA05';
        case 3
            sname = 'MDFA06';
        case 4
            sname = 'MDFA07';
        case 5
            sname = 'MDFA10';
        case 6
            sname = 'MDFA11';
        case 7
            sname = 'MDFA12';
       case 8 
           sname = 'MDFA15';
       case 9
           sname = 'MDFA17';
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
        
        B = B(1:length(B)-length(EEG_chan)); % Remove the 1.0 values from B
        
        index = floor(length(B)*(1-network_thresh));
        thresh = B(index);       % Values below which the graph will be assigned 0, above which, graph will be assigned 1        
        
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