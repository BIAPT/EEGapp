function f_MDF_maxNSTE

samp_freq = 500;

for subject = 1:8
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

    for state = 1:8
        switch state
            case 1
                statename = 'Cognitive test 1';
            case 2
                statename = 'Cognitive test 2';
            case 3
                statename = 'Cognitive test 3';
            case 4
                statename = 'Cognitive test 4';
            case 5
                statename = 'Cognitive test 5';
            case 6
                statename = 'Cognitive test 6';
            case 7 
                statename = 'Cognitive test 7';
            case 8
                statename = 'Cognitive test 8';
        end
        
        for ctest = 1:2
            switch ctest
                case 1
                    cname = 'AM';
                case 2
                    cname = 'PVT';
            end

            for bp=4 
                switch bp
                    case 1  % all 1
                        bpname='all'
                        lp=1;
                        hp=30;
                    case 2 %delta
                        bpname='delta'
                        lp=1;
                        hp=4;
                    case 3  %theta
                        bpname='theta'
                        lp=4;
                        hp=8;
                    case 4 %alpha
                        bpname='alpha'
                        lp=8;
                        hp=13;
                    case 5 %beta
                        bpname='beta'
                        lp=13;
                        hp=30;
                    case 6 % low gamma
                        bpname='gamma'
                        lp=30;
                        hp=50;
                end
    
        data = load(['D:\My Documents\Post-doc\CIHR postdoc\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\scouts\' statename ' ' cname '.mat']);
        data = data.Value;
        data = data';
        
        
        [m, num_comp] = size(data);
                    
        winsize=(10)*samp_freq;% 10 seconds
        NumWin=7; % Fix the number of windows
        TotalWin=floor(length(data)/winsize); % Total number of windows
        RanWin=randperm(TotalWin); % Randomize the order
        UsedWin=RanWin(1:NumWin); % Randomly pick-up the windows
        UsedWin=sort(UsedWin);
      
        
        for ch1=11:18       
            for ch2=11:18                
                for m=1:NumWin
                    win=UsedWin(m);
                    ini_point=(win-1)*winsize+1;
                    final_point=ini_point+winsize-1;
                    
                    x=data(ini_point:final_point,ch1);
                    y=data(ini_point:final_point,ch2);
                    
                    fdata1=bpfilter(lp,hp,samp_freq,x);
                    fdata2=bpfilter(lp,hp,samp_freq,y);
                    
                    delta=f_predictiontime(fdata1,fdata2,100);

                    dim=3;
                    tau = 1:2:30;
                    for L=1:15
                        [STE(L,1:2), NSTE(L,1:2)] = f_nste([fdata1 fdata2], dim, tau(L), delta);
                    end
                                       
                    [mxNSTE, mxNTau]=max(NSTE);
                    [mxSTE, mxTau]=max(STE);
                    
                    ste.STE(m,ch2,ch1)=mxSTE(1);    % Y to X
                    ste.NSTE(m,ch2,ch1)=mxNSTE(1);
                    
                    ste.STE(m,ch1,ch2)=mxSTE(2);    % X to Y
                    ste.NSTE(m,ch1,ch2)=mxNSTE(2);
             
              
                    fprintf([statename '_ch' num2str(ch1) '_ch' num2str(ch2) '_win' num2str(m) '/' num2str(NumWin) '\n']);
                end
            end
        end
        
        save(['D:\My Documents\Post-doc\CIHR postdoc\McDonnell Foundation study\University of Michigan\Anesthesia\' sname '\scouts\' sname ' ' statename ' ' cname ' ' bpname '_maxNSTE.mat'],'ste');
           
            end % bp
        end % ctest
    end % state
end % subject





