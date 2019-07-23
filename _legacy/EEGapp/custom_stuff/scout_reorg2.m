function new_EEG = scout_reorg2(EEG)

% Takes the 24 scouts of the cognitive test atlas created from brainstorm
% and reorders everything from anterior to posterior sources.

% Order of sources:
% 1) Front_mid_orb [9,10]
% 2) Front_sup_orb [3,4]
% 3) Frontal_sup_medial [7,8]
% 4) Frontal_sup [1,2]
% 5) Frontal_mid [5,6]
% 6) Cingulum_Ant [11,12]
% 7) Cingulum_Mid [13,14]
% 8) Cingulum_Post [15,16]
% 9) Precuneus [23,24]
% 10) Parietal_Sup [21,22]
% 11) Cuneus [17,18]
% 12) Occipital_Sup [19,20]

new_EEG(1,:) = EEG(9,:); new_EEG(2,:) = EEG(10,:);
new_EEG(3,:) = EEG(3,:); new_EEG(4,:) = EEG(4,:);
new_EEG(5,:) = EEG(7,:); new_EEG(6,:) = EEG(8,:);
new_EEG(7,:) = EEG(1,:); new_EEG(8,:) = EEG(2,:);
new_EEG(9,:) = EEG(5,:); new_EEG(10,:) = EEG(6,:);
new_EEG(11,:) = EEG(11,:); new_EEG(12,:) = EEG(12,:);
new_EEG(13,:) = EEG(13,:); new_EEG(14,:) = EEG(14,:);
new_EEG(15,:) = EEG(15,:); new_EEG(16,:) = EEG(16,:);
new_EEG(17,:) = EEG(23,:); new_EEG(18,:) = EEG(24,:);
new_EEG(19,:) = EEG(21,:); new_EEG(20,:) = EEG(22,:);
new_EEG(21,:) = EEG(17,:); new_EEG(22,:) = EEG(18,:);
new_EEG(23,:) = EEG(19,:); new_EEG(24,:) = EEG(20,:);