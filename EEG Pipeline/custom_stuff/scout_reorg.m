function new_EEG = scout_reorg(EEG)

% Takes the 66 scouts of the Desikan-Killany atlas created from brainstorm
% and reorders everything from anterior to posterior sources.

% Order of sources:
% 1) Frontal Pole [11,12]
% 2) Medial orbiofrontal [29,30]
% 3) Lateral orbiotofrontal [25,26]
% 4) Rostral middle frontal [53,54]
% 5) Parsoritalis [39,40]
% 6) Parsangularis [41,42]
% 7) Parsopercularis [37,38]
% 8) Superior frontal [55,56]
% 9) Caudal middle frontal [5,6]
% 10) Precentral [47,48]
% 11) Paracentral [33,34]
% 12) Rostral anterior cingulate [51,52]
% 13) Caudal anterior cingulate [3,4]
% 14) Posterior cingulate [45,46]
% 15) Isthmuscingulate [21,22]
% 16) Supramarginal [61,62]
% 17) Superior parietal [57,58]
% 18) Inferior parietal [15,16]
% 19) Precuneus [49,50]
% 20) Cuneus [7,8]
% 21) Superior temporal [59,60]
% 22) Banksts [1,2]
% 23) Middle temporal [31,32]
% 24) Inferior temporal [17,18]
% 25) Transverse temporal [65,66]
% 26) Fusiform [13,14]
% 27) Entrohinal [9,10]
% 28) Temporal pole [63,64]
% 29) Pericalcarine [43,44]
% 30) Lateral occipital [23,24]
% 31) Insula [19,20]
% 32) Parahippocampal [35,36]
% 33) Lingual [27,28]

new_EEG(1,:) = EEG(11,:); new_EEG(2,:) = EEG(12,:);
new_EEG(3,:) = EEG(29,:); new_EEG(4,:) = EEG(30,:);
new_EEG(5,:) = EEG(25,:); new_EEG(6,:) = EEG(26,:);
new_EEG(7,:) = EEG(53,:); new_EEG(8,:) = EEG(54,:);
new_EEG(9,:) = EEG(39,:); new_EEG(10,:) = EEG(40,:);
new_EEG(11,:) = EEG(41,:); new_EEG(12,:) = EEG(42,:);
new_EEG(13,:) = EEG(37,:); new_EEG(14,:) = EEG(38,:);
new_EEG(15,:) = EEG(55,:); new_EEG(16,:) = EEG(56,:);
new_EEG(17,:) = EEG(5,:); new_EEG(18,:) = EEG(6,:);
new_EEG(19,:) = EEG(47,:); new_EEG(20,:) = EEG(48,:);
new_EEG(21,:) = EEG(33,:); new_EEG(22,:) = EEG(34,:);
new_EEG(23,:) = EEG(51,:); new_EEG(24,:) = EEG(52,:);
new_EEG(25,:) = EEG(3,:); new_EEG(26,:) = EEG(4,:);
new_EEG(27,:) = EEG(45,:); new_EEG(28,:) = EEG(46,:);
new_EEG(29,:) = EEG(21,:); new_EEG(30,:) = EEG(22,:);
new_EEG(31,:) = EEG(61,:); new_EEG(32,:) = EEG(62,:);
new_EEG(33,:) = EEG(57,:); new_EEG(34,:) = EEG(58,:);
new_EEG(35,:) = EEG(15,:); new_EEG(36,:) = EEG(16,:);
new_EEG(37,:) = EEG(49,:); new_EEG(38,:) = EEG(50,:);
new_EEG(39,:) = EEG(7,:); new_EEG(40,:) = EEG(8,:);
new_EEG(41,:) = EEG(59,:); new_EEG(42,:) = EEG(60,:);
new_EEG(43,:) = EEG(1,:); new_EEG(44,:) = EEG(2,:);
new_EEG(45,:) = EEG(31,:); new_EEG(46,:) = EEG(32,:);
new_EEG(47,:) = EEG(17,:); new_EEG(48,:) = EEG(18,:);
new_EEG(49,:) = EEG(65,:); new_EEG(50,:) = EEG(66,:);
new_EEG(51,:) = EEG(13,:); new_EEG(52,:) = EEG(14,:);
new_EEG(53,:) = EEG(9,:); new_EEG(54,:) = EEG(10,:);
new_EEG(55,:) = EEG(63,:); new_EEG(56,:) = EEG(64,:);
new_EEG(57,:) = EEG(43,:); new_EEG(58,:) = EEG(44,:);
new_EEG(59,:) = EEG(23,:); new_EEG(60,:) = EEG(24,:);
new_EEG(61,:) = EEG(19,:); new_EEG(62,:) = EEG(20,:);
new_EEG(63,:) = EEG(35,:); new_EEG(64,:) = EEG(36,:);
new_EEG(65,:) = EEG(27,:); new_EEG(66,:) = EEG(28,:);