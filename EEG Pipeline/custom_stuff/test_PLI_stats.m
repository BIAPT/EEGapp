function [corr_PLI, conn_ratio] = test_PLI_stats(PLI, EEGseg)

num_perms = 50;
sig = 0.05;
x = length(EEGseg);
ch = size(EEGseg,2);
no_conn = 0;
conn = 0;

% Hilbert transform and computation of phases
phi1 = angle(hilbert(EEGseg));

for i = 1:num_perms
    cut = randi(x-1);
    first_part = phi1(1:cut);
    second_part = phi1(cut:(length(phi1)-1));
    phi2 = [second_part, first_part];   % This is the randomized signal
    surro_PLI = ones(ch,ch);
    for ch1 = 1:ch-1
        for ch2 = ch1+1:ch
            %%% Phase lag index
            PDiff = phi1(:,ch1)-phi2(:,ch2); % phase difference
            surro_PLI(ch1,ch2) = abs(mean(sign(sin(PDiff))));   % only count the asymmetry
            surro_PLI(ch2,ch1) = surro_PLI(ch1,ch2);
        end
    end
    
    group_surro(:,:,i) = surro_PLI;
    
end

for i = 1:length(PLI)
    for j = 1:length(PLI)
        
        test_ch = PLI(i,j);
        for n = 1:num_perms
            test_group(n) = group_surro(i,j,n);
        end
        group_mean = mean(group_surro,3);
        
        %p = ranksum(test_ch, test_group);
        p = signrank(test_group, test_ch);
        
        if p > sig || isnan(p)
            corr_PLI(i,j) = 0;
            no_conn = no_conn + 1;
        elseif p < sig
            y = PLI(i,j) - group_mean(i,j);
            if y > 0            
                corr_PLI(i,j) = PLI(i,j) - group_mean(i,j);
                conn = conn + 1;
            else
                corr_PLI(i,j) = 0;
                no_conn = no_conn + 1;
            end
        end
    end
end

conn_ratio = conn/(no_conn + conn);
 
    
