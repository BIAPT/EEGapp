function corr_dPLI = create_sig_dPLI(corr_PLI,EEG_seg)

% This function takes the matrix of significant PLI connections and creates
% a matrix of dPLI connections where functional connectivity is non-zero

num_perms = 50;
sig = 0.05;

dPLI = d_PhaseLagIndex(EEG_seg);  % Generate dPLI matrix

% Generate num_perms surrogate dPLI matrix
for i = 1:num_perms
    surro_dPLI(:,:,i) = d_PhaseLagIndex_surrogate(EEG_seg);
end
group_mean = mean(surro_dPLI,3);

for i = 1:length(corr_PLI)
    for j = 1:length(corr_PLI)
        
        if (corr_PLI(i,j) == 0) % if no significant functional connection
            corr_dPLI(i,j) = 0.5; 
        else
            test_ch = dPLI(i,j);
            for n = 1:num_perms
                test_group(n) = surro_dPLI(i,j,n);
            end
                        
            p = signrank(test_group, test_ch);
            
            if p > sig || isnan(p)
                corr_dPLI(i,j) = 0.5;
            elseif p < sig
                %corr_dPLI(i,j) = dPLI(i,j) - group_mean(i,j);
                if dPLI(i,j) > 0.5
                    corr_dPLI(i,j) = dPLI(i,j) - (group_mean(i,j) - 0.5);
                elseif dPLI(i,j) < 0.5
                    corr_dPLI(i,j) = dPLI(i,j) + (0.5 - group_mean(i,j));
                elseif dPLI == 0.5
                    if group_mean(i,j) > 0.5
                        corr_dPLI(i,j) = dPLI(i,j) - (group_mean(i,j) - 0.5);
                    elseif group_mean(i,j) < 0.5
                        corr_dPLI(i,j) = dPLI(i,j) + (0.5 - group_mean(i,j));
                    elseif group_mean(i,j) == 0.5
                        corr_dPLI(i,j) = 0.5;
                    end
                end
            end
                      
        end
    end
end


            
            

