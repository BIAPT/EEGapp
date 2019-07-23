function plot_cog_scores

scorenum = '6';
scores = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\test' scorenum 'scores.txt']);

for g_var = 5
    switch g_var
        case 1
            gvariable = 'Lnorm';
        case 2
            gvariable = 'Cnorm';
        case 3
            gvariable = 'Qnorm';
        case 4
            gvariable = 'bsw';
        case 5
            gvariable = 'geffnorm';
    end
         
    for snum = 1:9
        switch snum
            case 1
                subject = 'MDFA03';
                cog_score = scores(1,:);
            case 2
                subject = 'MDFA05';
                cog_score = scores(2,:);
            case 3
                subject = 'MDFA06';
                cog_score = scores(3,:);
            case 4
                subject = 'MDFA07';
                cog_score = scores(4,:);
            case 5
                subject = 'MDFA10';
                cog_score = scores(5,:);
            case 6
                subject = 'MDFA11';
                cog_score = scores(6,:);
            case 7
                subject = 'MDFA12';
                cog_score = scores(7,:);
            case 8
                subject = 'MDFA15';
                cog_score = scores(8,:);
            case 9
                subject = 'MDFA17';
                cog_score = scores(9,:);
        end
        
    theta = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\group_analysis_ theta_' gvariable '.txt']);
    alpha = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\group_analysis_ alpha_' gvariable '.txt']);
    beta = load(['F:\McDonnell Foundation study\University of Michigan\Anesthesia\group_analysis_ beta_' gvariable '.txt']);

    st = theta(snum,:);
    sa = alpha(snum,:);
    sb = beta(snum,:);

    s_theta = [st(1), st(4), st(5), st(6), st(7), st(8), st(9), st(10)];
    s_alpha = [sa(1), sa(4), sa(5), sa(6), sa(7), sa(8), sa(9), sa(10)];
    s_beta = [sb(1), sb(4), sb(5), sb(6), sb(7), sb(8), sb(9), sb(10)];

    [r_theta, p_theta] = corrcoef(s_theta, cog_score);
    [r_alpha, p_alpha] = corrcoef(s_alpha, cog_score);
    [r_beta, p_beta] = corrcoef(s_beta, cog_score);

    theta_stats(snum,1) = r_theta(1,2); theta_stats(snum,2) = p_theta(1,2);
    alpha_stats(snum,1) = r_alpha(1,2); alpha_stats(snum,2) = p_alpha(1,2);
    beta_stats(snum,1) = r_beta(1,2); beta_stats(snum,2) = p_beta(1,2);
    
    x = [1,2,3,4,5,6,7,8];

    figure1 = figure('Color', [1 1 1]);
    axes1 = axes('Parent', figure1, 'XTickLabel',{'Baseline','Emergence','30 min','60 min','90 min','120 min','150 min','180 min'});
    box(axes1,'on');
    hold(axes1,'all');

    plot1 = plotyy(x, s_alpha, x, cog_score);
    plot(x, s_theta, 'color', 'g', 'LineWidth', 2);
    plot(x, s_beta, 'color', 'r', 'LineWidth', 2);

    end
    
end

theta_stats
alpha_stats
beta_stats

