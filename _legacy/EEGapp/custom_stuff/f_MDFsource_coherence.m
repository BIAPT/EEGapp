function f_MDFsource_coherence

SF=500; % Sampling frequency
num_sources = 5;

for subject = 7;
%for subject = 1:29
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
            sname = '';
        case 10
            sname = '';
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
    
        file = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname statename ' 5 comp.txt']);

        for bp=1:6  
            switch bp
                case 1  % all 1
                    bpname='all'
                    lp = 1;
                    hp = 50;
                case 2 %delta
                    bpname='delta'
                    lp = 1;
                    hp = 4;
                case 3  %theta
                    bpname='theta'
                    lp = 4;
                    hp = 8;
                case 4 %alpha
                    bpname='alpha'
                    lp = 8;
                    hp = 13;
                case 5 %beta
                    bpname='beta'
                    lp = 13;
                    hp = 30;
                case 6 % low gamma
                    bpname='gamma'
                    lp = 30;
                    hp = 50;
            end
            
            data = bpfilter(lp, hp, SF, file');
            %data = eeglabFirws(lp, hp, 4, SF, file');
            plot(data)
            size(data)
            
            for ch1 = 1:num_sources
                for ch2 = 1:num_sources
                  d1 = data(:, ch1);
                  d2 = data(:, ch2);
                  [CXY, F] = mscohere(d1, d2, [], [], [], SF);
                  avgCXY{bp}(ch1, ch2) = mean(CXY);
%                    avgCXY(ch1,ch2) = mean(CXY);
                end
            end
%            meanCXY(subject) = (avgCXY(3,7) + avgCXY(3,8) + avgCXY(4,7) + avgCXY(4,8))/4;
        end

        avgCXYallfreqs = (avgCXY{2}(:,:) + avgCXY{3}(:,:) + avgCXY{4}(:,:) + avgCXY{5}(:,:) + avgCXY{6}(:,:))/5;
        avgCXY{1}(:,:) = avgCXYallfreqs;
        
        save(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname statename ' coherence.mat'], 'avgCXY');
     end
end
    
%    coherence_average = mean(meanCXY)
%    coherence_std = std(meanCXY)