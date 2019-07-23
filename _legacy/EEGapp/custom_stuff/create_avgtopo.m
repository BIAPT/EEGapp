function create_avgtopo

for i = 10
    switch i
        case 1
            s_name = 'eyes closed 1';
        case 2
            s_name = 'induction first 5 min';
        case 3
            s_name = 'emergence first 5 min';
        case 4
            s_name = 'emergence last 5 min';
        case 5
            s_name = 'eyes closed 3';
        case 6
            s_name = 'eyes closed 4';
        case 7
            s_name = 'eyes closed 5';
        case 8
            s_name = 'eyes closed 6';
        case 9
            s_name = 'eyes closed 7';
        case 10
            s_name = 'eyes closed 8';
    end

EEG1 = pop_loadset('filename',['MDFA03 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA03\Resting state analysis\');
EEG2 = pop_loadset('filename',['MDFA05 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA05\Resting state analysis\');
EEG3 = pop_loadset('filename',['MDFA06 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA06\Resting state analysis\');
EEG4 = pop_loadset('filename',['MDFA07 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA07\Resting state analysis\');
EEG5 = pop_loadset('filename',['MDFA10 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA10\Resting state analysis\');
EEG6 = pop_loadset('filename',['MDFA11 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA11\Resting state analysis\');
EEG7 = pop_loadset('filename',['MDFA12 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA12\Resting state analysis\');
EEG8 = pop_loadset('filename',['MDFA15 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA15\Resting state analysis\');
EEG9 = pop_loadset('filename',['MDFA17 ' s_name '.set'], 'filepath', 'F:\McDonnell Foundation study\University of Michigan\Anesthesia\MDFA17\Resting state analysis\');

[h, grid1, plotrad, xmesh, ymesh] = averagetopo(EEG1);
[h, grid2, plotrad, xmesh, ymesh] = averagetopo(EEG2);
[h, grid3, plotrad, xmesh, ymesh] = averagetopo(EEG3);
[h, grid4, plotrad, xmesh, ymesh] = averagetopo(EEG4);
[h, grid5, plotrad, xmesh, ymesh] = averagetopo(EEG5);
[h, grid6, plotrad, xmesh, ymesh] = averagetopo(EEG6);
[h, grid7, plotrad, xmesh, ymesh] = averagetopo(EEG7);
[h, grid8, plotrad, xmesh, ymesh] = averagetopo(EEG8);
[h, grid9, plotrad, xmesh, ymesh] = averagetopo(EEG9);

sumgrid = grid1 + grid2 + grid3 + grid4 + grid5 +grid6 + grid7 + grid8 + grid9;
avggrid = sumgrid / 9;
figure; [hfig val] = toporeplot(avggrid, 'plotrad', 1, 'intrad', 1, 'maplimits', 'minmax');

end