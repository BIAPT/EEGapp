function [pli_plot] = make_default_plot( EEG )
%MAKE_DEFAULT_PLOT Summary of this function goes here
%   Detailed explanation goes here

%% Make the default plot for PLI / dPLI
        %Make the plot of the PLI
        pli_plot = figure;
        colormap('jet')
        random_matrix = randi(30,EEG.nbchan,EEG.nbchan);
        imagesc(random_matrix);
        title(sprintf('PLI of %s at Bandpass: X',EEG.filename));
        colorbar;
        movegui(pli_plot,'center')

end

