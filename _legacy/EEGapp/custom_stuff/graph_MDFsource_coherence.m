function graph_MDFsource_coherence

SF=500; % Sampling frequency
num_sources = 5;
bp = 4;         % bp: 3 is theta, 4 is alpha, 5 is beta

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
   
    file1 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 1 coherence.mat']);
    file2 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' induction first 5 min coherence.mat']);
    file3 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' emergence first 5 min coherence.mat']);
    file4 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' emergence last 5 min coherence.mat']);
    file5 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 3 coherence.mat']);
    file6 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 4 coherence.mat']);
    file7 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 5 coherence.mat']);
    file8 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 6 coherence.mat']);
    file9 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 7 coherence.mat']);
    file10 = load(['/Volumes/Data/McDonnell Foundation study/University of Michigan/Anesthesia/' sname '/Resting state analysis/' sname ' eyes closed 8 coherence.mat']);
    
    band1 = file1.avgCXY{bp};
    band2 = file2.avgCXY{bp};
    band3 = file3.avgCXY{bp};
    band4 = file4.avgCXY{bp};
    band5 = file5.avgCXY{bp};
    band6 = file6.avgCXY{bp};
    band7 = file7.avgCXY{bp};
    band8 = file8.avgCXY{bp};
    band9 = file9.avgCXY{bp};
    band10 = file10.avgCXY{bp};

    % Plot source 1 vs. all other sources
    
    source12 = [band1(1,2), band2(1,2), band3(1,2), band4(1,2), band5(1,2), band6(1,2), band7(1,2), band8(1,2), band9(1,2), band10(1,2)];
    source13 = [band1(1,3), band2(1,3), band3(1,3), band4(1,3), band5(1,3), band6(1,3), band7(1,3), band8(1,3), band9(1,3), band10(1,3)];
    source14 = [band1(1,4), band2(1,4), band3(1,4), band4(1,4), band5(1,4), band6(1,4), band7(1,4), band8(1,4), band9(1,4), band10(1,4)];
    source15 = [band1(1,5), band2(1,5), band3(1,5), band4(1,5), band5(1,5), band6(1,5), band7(1,5), band8(1,5), band9(1,5), band10(1,5)];
    
        % Plot source 1
        figure1 = figure('Name','Ventromedical PFC','Color',[1 1 1]);
        subplot1 = subplot(4,1,1,'Parent',figure1,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot1,'on');
        hold(subplot1,'all');
        imagesc([1 10],1,source12,'Parent',subplot1,'CDataMapping','scaled');
        ylabel('Posterior cingulate','FontSize',14);
        subplot2 = subplot(4,1,2,'Parent',figure1,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot2,'on');
        hold(subplot2,'all');
        imagesc([1 10],1,source13,'Parent',subplot2,'CDataMapping','scaled');
        ylabel('Precuneus','FontSize',14);
        subplot3 = subplot(4,1,3,'Parent',figure1,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot3,'on');
        hold(subplot3,'all');
        imagesc([1 10],1,source14,'Parent',subplot3,'CDataMapping','scaled');
        ylabel('Occipital','FontSize',14);
        subplot4 = subplot(4,1,4,'Parent',figure1,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot4,'on');
        hold(subplot4,'all');
        imagesc([1 10],1,source15,'Parent',subplot4,'CDataMapping','scaled');
        title({''});
        ylabel('Anterior cingulate','FontSize',14);
        colorbar('peer',subplot4);
        colorbar('peer',subplot3,'CLim',[1 64]);
        colorbar('peer',subplot2,'CLim',[1 64]);
        colorbar('peer',subplot1,'CLim',[1 64]);     
        
    % Plot source 2 vs. all other sources
    
    source21 = [band1(2,1), band2(2,1), band3(2,1), band4(2,1), band5(2,1), band6(2,1), band7(2,1), band8(2,1), band9(2,1), band10(2,1)];
    source23 = [band1(2,3), band2(2,3), band3(2,3), band4(2,3), band5(2,3), band6(2,3), band7(2,3), band8(2,3), band9(2,3), band10(2,3)];
    source24 = [band1(2,4), band2(2,4), band3(2,4), band4(2,4), band5(2,4), band6(2,4), band7(2,4), band8(2,4), band9(2,4), band10(2,4)];
    source25 = [band1(2,5), band2(2,5), band3(2,5), band4(2,5), band5(2,5), band6(2,5), band7(2,5), band8(2,5), band9(2,5), band10(2,5)];
    
        % Plot source 2
        figure2 = figure('Name','Posterior Cingulate','Color',[1 1 1]);
        subplot1 = subplot(4,1,1,'Parent',figure2,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot1,'on');
        hold(subplot1,'all');
        imagesc([1 10],1,source21,'Parent',subplot1,'CDataMapping','scaled');
        ylabel('vmPFC','FontSize',14);
        subplot2 = subplot(4,1,2,'Parent',figure2,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot2,'on');
        hold(subplot2,'all');
        imagesc([1 10],1,source23,'Parent',subplot2,'CDataMapping','scaled');
        ylabel('Precuneus','FontSize',14);
        subplot3 = subplot(4,1,3,'Parent',figure2,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot3,'on');
        hold(subplot3,'all');
        imagesc([1 10],1,source24,'Parent',subplot3,'CDataMapping','scaled');
        ylabel('Occipital','FontSize',14);
        subplot4 = subplot(4,1,4,'Parent',figure2,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot4,'on');
        hold(subplot4,'all');
        imagesc([1 10],1,source25,'Parent',subplot4,'CDataMapping','scaled');
        title({''});
        ylabel('Anterior cingulate','FontSize',14);
        colorbar('peer',subplot4);
        colorbar('peer',subplot3,'CLim',[1 64]);
        colorbar('peer',subplot2,'CLim',[1 64]);
        colorbar('peer',subplot1,'CLim',[1 64]);       

% Plot source 3 vs. all other sources
    
    source31 = [band1(3,1), band2(3,1), band3(3,1), band4(3,1), band5(3,1), band6(3,1), band7(3,1), band8(3,1), band9(3,1), band10(3,1)];
    source32 = [band1(3,2), band2(3,2), band3(3,2), band4(3,2), band5(3,2), band6(3,2), band7(3,2), band8(3,2), band9(3,2), band10(3,2)];
    source34 = [band1(3,4), band2(3,4), band3(3,4), band4(3,4), band5(3,4), band6(3,4), band7(3,4), band8(3,4), band9(3,4), band10(3,4)];
    source35 = [band1(3,5), band2(3,5), band3(3,5), band4(3,5), band5(3,5), band6(3,5), band7(3,5), band8(3,5), band9(3,5), band10(3,5)];
    
        % Plot source 3
        figure3 = figure('Name','Precuneus','Color',[1 1 1]);
        subplot1 = subplot(4,1,1,'Parent',figure3,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot1,'on');
        hold(subplot1,'all');
        imagesc([1 10],1,source31,'Parent',subplot1,'CDataMapping','scaled');
        ylabel('vmPFC','FontSize',14);
        subplot2 = subplot(4,1,2,'Parent',figure3,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot2,'on');
        hold(subplot2,'all');
        imagesc([1 10],1,source32,'Parent',subplot2,'CDataMapping','scaled');
        ylabel('Posterior cingulate','FontSize',14);
        subplot3 = subplot(4,1,3,'Parent',figure3,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot3,'on');
        hold(subplot3,'all');
        imagesc([1 10],1,source34,'Parent',subplot3,'CDataMapping','scaled');
        ylabel('Occipital','FontSize',14);
        subplot4 = subplot(4,1,4,'Parent',figure3,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot4,'on');
        hold(subplot4,'all');
        imagesc([1 10],1,source35,'Parent',subplot4,'CDataMapping','scaled');
        title({''});
        ylabel('Anterior cingulate','FontSize',14);
        colorbar('peer',subplot4);
        colorbar('peer',subplot3,'CLim',[1 64]);
        colorbar('peer',subplot2,'CLim',[1 64]);
        colorbar('peer',subplot1,'CLim',[1 64]);       
        
% Plot source 4 vs. all other sources
    
    source41 = [band1(4,1), band2(4,1), band3(4,1), band4(4,1), band5(4,1), band6(4,1), band7(4,1), band8(4,1), band9(4,1), band10(4,1)];
    source42 = [band1(4,2), band2(4,2), band3(4,2), band4(4,2), band5(4,2), band6(4,2), band7(4,2), band8(4,2), band9(4,2), band10(4,2)];
    source43 = [band1(4,3), band2(4,3), band3(4,3), band4(4,3), band5(4,3), band6(4,3), band7(4,3), band8(4,3), band9(4,3), band10(4,3)];
    source45 = [band1(4,5), band2(4,5), band3(4,5), band4(4,5), band5(4,5), band6(4,5), band7(4,5), band8(4,5), band9(4,5), band10(4,5)];
    
        % Plot source 4
        figure4 = figure('Name','Occipital','Color',[1 1 1]);
        subplot1 = subplot(4,1,1,'Parent',figure4,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot1,'on');
        hold(subplot1,'all');
        imagesc([1 10],1,source41,'Parent',subplot1,'CDataMapping','scaled');
        ylabel('vmPFC','FontSize',14);
        subplot2 = subplot(4,1,2,'Parent',figure4,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot2,'on');
        hold(subplot2,'all');
        imagesc([1 10],1,source42,'Parent',subplot2,'CDataMapping','scaled');
        ylabel('Posterior cingulate','FontSize',14);
        subplot3 = subplot(4,1,3,'Parent',figure4,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot3,'on');
        hold(subplot3,'all');
        imagesc([1 10],1,source43,'Parent',subplot3,'CDataMapping','scaled');
        ylabel('Precuneus','FontSize',14);
        subplot4 = subplot(4,1,4,'Parent',figure4,'YTickLabel',{' ',' ',' '},...
        'YDir','reverse',...
        'XTick', [1,2,3,4,5,6,7,8,9,10],'XLim', [0.5 10.5],...
        'XTickLabel',{'Base','Induc','Uncon','Emerg','30','60','90','120','150','180'},...
        'Layer','top',...
        'CLim',[0 0.3]);
        box(subplot4,'on');
        hold(subplot4,'all');
        imagesc([1 10],1,source45,'Parent',subplot4,'CDataMapping','scaled');
        title({''});
        ylabel('Anterior cingulate','FontSize',14);
        colorbar('peer',subplot4);
        colorbar('peer',subplot3,'CLim',[1 64]);
        colorbar('peer',subplot2,'CLim',[1 64]);
        colorbar('peer',subplot1,'CLim',[1 64]);       
        
end