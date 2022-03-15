rat = importdata('../../data_processed/output/gp_between.mat');
human = importdata('../../data_processed/output/gp_human.mat');
humanf = importdata('../../data_processed/output/gp_human_full.mat');
%% figure
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'between','fig_saveformat','emf');
plt.setuserparam('param_setting', 'isshow', 1);
%% colors
col_rat = {'AZcactus', 'AZred', 'AZblue'};
leg_rat = strcat("H = ",rat.gp.group_analysis.cond_horizon);
col_human = {'AZcactus', 'AZred', 'AZsky','AZblue'};
leg_human = strcat("H = ",human.gp.group_analysis.cond_horizon);
%% contrast - behavior
plt.figure(2,2,'istitle','gap',[0.07 0.1], 'margin', [0.1 0.13 0.05 0.02]);
plt.setfig('color', {col_human, col_human, col_rat , col_rat}, ...
    'xlabel', {'','','trial number','trial number'}, 'legord', 'reverse', ...
    'ylabel', {{'human';'p(high reward)'}, 'p(switch)',{'rat';'p(high reward)'},'p(switch)'}, 'legloc', 'NorthEast', ...
    'legend', {leg_human, leg_human, leg_rat, leg_rat}, ...
    'xlim', [0.5 15.5], 'ylim', {[0.5 1],[0 1],[0.5 1],[0 1]}, ...
    'ytick', {0.5:0.1:1, 0:0.2:1, 0.5:0.1:1, 0:0.2:1});
plt.new;
plt.lineplot(ff(human.gp.av_av_cc_best), ff(human.gp.ste_av_cc_best));
plt.new;
plt.lineplot(ff(human.gp.av_av_cc_switch), ff(human.gp.ste_av_cc_switch));
plt.new;
plt.lineplot(ff(rat.gp.av_av_cc_best), ff(rat.gp.ste_av_cc_best));
plt.new;
plt.lineplot(ff(rat.gp.av_av_cc_switch), ff(rat.gp.ste_av_cc_switch));
plt.addABCs([-0.07 0.05],'ABCD');
plt.update;
plt.save('ac_sw');
%% R curve
plt.figure(2,2,'istitle','gap',[0.07 0.1], 'margin', [0.1 0.13 0.05 0.02]);
% plt.figure(2,3,'gap',{[0.08], [0.1 0.08]}, 'margin', [0.12, 0.13, 0.05, 0.02], ...
%     'rect', [0.12 0.05 0.65 0.7]);
plt.setup_pltparams('fontsize_face', 20);
% plt.setfig([1:3 4:6],'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
%     'ylim', [0 1], 'ytick', 0:0.2:1, ...
%     'legord', 'reverse', 'legloc', 'SouthWest',...
%     'color',{col_human,col_human,col_human,col_rat,col_rat,col_rat}, ...
%     'legend',{leg_human,leg_human,leg_human,leg_rat,leg_rat,leg_rat}, ...
%     'xlabel', {'','','','guided reward', 'guided reward','guided reward'}, ...
%     'ylabel', {{'human','p(high reward)','last choice'},{'p(high reward)','1st choice'},'p(explore)',...
%         {'rat','p(high reward)','last choice'},{'p(high reward)','1st choice'},'p(explore)'});
plt.setfig([2 1 4 3],'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, ...
    'legord', 'reverse', 'legloc', 'SouthWest',...
    'color',{col_human,col_human,col_rat,col_rat}, ...
    'legend',{leg_human,leg_human,leg_rat,leg_rat}, ...
    'xlabel', {'','','guided reward', 'guided reward'}, ...
    'ylabel', {{'p(high reward)','last choice'},{'human','p(high reward)','1st choice'},...
        {'p(high reward)','last choice'},{'rat','p(high reward)','1st choice'}});
plt.new;
plt.lineplot(human.gp.av_bin_all_c1_cc_best, human.gp.ste_bin_all_ce_cc_best);
plt.new;
plt.lineplot(human.gp.av_bin_all_ce_cc_best, human.gp.ste_bin_all_c1_cc_best);
% plt.new;
% plt.lineplot(human.gp.av_bin_all_c1_cc_explore, human.gp.ste_bin_all_c1_cc_explore);

% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', {'human', 'p(high reward)','last choice'}, 'xtick',1:4, 'xticklabel', [1 2 5 10],...
%     'color', col_human(end:-1:1), 'xlim', [],'ylim',[.5 1]);
% plt.barplot(W.nan_get(human.gp.av_av_cc_best(end:-1:1,:),1),W.nan_get(human.gp.ste_av_cc_best(end:-1:1,:),1));
% 
% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', {'p(high reward)','1st choice'}, 'xtick',1:4, 'xticklabel', [1 2 5 10],...
%     'color',col_human(end:-1:1),'xlim', [],'ylim',[.5 1]);
% plt.barplot(human.gp.av_av_cc_best(end:-1:1,1)',human.gp.ste_av_cc_best(end:-1:1,1)');
% 
% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', 'p(explore)', 'xtick',1:4, 'xticklabel', [1 2 5 10],...
%     'color',col_human(end:-1:1),'xlim', [],'ylim',[.4 .8],'ytick',0.4:.2:.8);
% plt.barplot(human.gp.av_av_cc_explore(end:-1:1,1)',human.gp.ste_av_cc_explore(end:-1:1,1)');


plt.new;
plt.lineplot(rat.gp.av_bin_all_c1_cc_best, rat.gp.ste_bin_all_ce_cc_best);
plt.new;
plt.lineplot(rat.gp.av_bin_all_ce_cc_best, rat.gp.ste_bin_all_c1_cc_best);
% plt.new;
% plt.lineplot(rat.gp.av_bin_all_c1_cc_explore, rat.gp.ste_bin_all_c1_cc_explore);


% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', {'rat', 'p(high reward)','last choice'}, 'xtick',[1 2 3], 'xticklabel', [1 6 15],...
%     'color', col_rat(end:-1:1), 'xlim', [],'ylim',[.5 1]);
% plt.barplot(W.nan_get(rat.gp.av_av_cc_best(end:-1:1,:),1),W.nan_get(rat.gp.ste_av_cc_best(end:-1:1,1),1),[1 2 3]);
% 
% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', {'p(high reward)','1st choice'}, 'xtick',[1 2 3], 'xticklabel', [1 6 15],...
%     'color', col_rat(end:-1:1),'xlim', [],'ylim',[.5 1]);
% plt.barplot(rat.gp.av_av_cc_best(end:-1:1,1)',rat.gp.ste_av_cc_best(end:-1:1,1)',[1 2 3]);
% 
% plt.new;
% plt.setfig_ax('xlabel', 'horizon', 'ylabel', 'p(explore)', 'xtick',[1 2 3], 'xticklabel', [1 6 15],...
%     'color', col_rat(end:-1:1),'xlim', [],'ylim',[.4 .8],'ytick',0.4:.2:.8);
% plt.barplot(rat.gp.av_av_cc_explore(end:-1:1,1)',rat.gp.ste_av_cc_explore(end:-1:1,1)',[1 2 3]);

plt.update;
plt.addABCs([-0.05, 0.04]);
plt.save('rcurve');
%% split by good/bad
% compute t-stat
tstat_ratcb = ratlinetstat(rat.sub.gp_av_cc_best, rat.sub.cond_horizon);
tstat_ratcb = tstat_ratcb(:, 1:15);
tstat_humancb = ratlinetstat(human.sub.gp_av_cc_best, human.sub.cond_horizon);
tstat_ratsw = ratlinetstat(rat.sub.gp_av_cc_switch, rat.sub.cond_horizon);
tstat_ratsw = tstat_ratsw(:, 1:15);
tstat_humansw = ratlinetstat(human.sub.gp_av_cc_switch, human.sub.cond_horizon);
tylm = [0 1.05];
plt.figure(4,4,'matrix_hole',[1 1 1 1; 1 0 1 1;1 1 1 1; 1 0 1 1],'rect',[0 0 0.6 0.9], ...
    'gap',{[0.05 0.14 0.05],[0.05 0.05 0.05]}, 'margin', [0.1 0.1 0.05 0.02],...
    'ax_ratio', [1 2 6 15;1 2 6 15;1 2 6 15;1 2 6 15]);
plt.setup_pltparams('fontsize_leg', 7, 'fontsize_face', 20,'legend_linewidth', [18 10]);
plt.setfig('gap_sigstarx', -0.2, 'gap_sigstary', 0.03);
colall = {'AZblue50','AZblue','AZsky50','AZsky','AZred50','AZred','AZcactus50','AZcactus'};
plt.setfig([1:4 8:11],'ylabel', {{'human';'(high reward)'},'','','',...
    {'human';'p(switch)'},'','',''}, ...
    'ylim', {tylm,tylm,tylm,tylm,tylm,tylm,tylm,tylm}, ...
    'xlabel', {'','trial #','','','','trial #','',''}, ...
    'xlim', {[0.5 1.5],[0.5 2.5],[0.5 6.5],[0.5 15.5],[0.5 1.5],[0.5 2.5],[0.5 6.5],[0.5 15.5]}, ...
    'color', {{'AZblue50','AZblue'},{'AZsky50','AZsky'},{'AZred50','AZred'},{'AZcactus50','AZcactus'},...
    {'AZblue50','AZblue'},{'AZsky50','AZsky'},{'AZred50','AZred'},{'AZcactus50','AZcactus'}},...
    'legloc', {'SouthEast','SouthEast','SouthEast','SouthEast','NorthEast','NorthEast','NorthEast','NorthEast'}, ...
    'title', {'H = 1', 'H = 2', 'H = 5', 'H = 10','H = 1', 'H = 2', 'H = 5', 'H = 10'}, ...
    'xtick',{1, 1:2, 2:2:6, 5:5:15, 1, 1:2, 2:2:6, 5:5:15},'xticklabel',{{},{1:2},{},{},{},{1:2},{},{}});
plt.setfig([5:7 12:14], 'ylabel', {{'rat';'p(high reward)'},'','',...
    {'rat';'p(switch)'},'',''}, ...
    'ylim', {tylm,tylm,tylm,tylm,tylm,tylm}, ...
    'xlabel', 'trial #', ...
    'xlim', {[0.5 1.5],[0.5 6.5],[0.5 15.5],[0.5 1.5],[0.5 6.5],[0.5 15.5]}, ...
    'color', {{'AZblue50','AZblue'},{'AZred50','AZred'},{'AZcactus50','AZcactus'},...
    {'AZblue50','AZblue'},{'AZred50','AZred'},{'AZcactus50','AZcactus'}},...
    'legloc', {'SouthEast','SouthEast','SouthEast','NorthEast','NorthEast','NorthEast'}, ...
    'title', {'H = 1', 'H = 6', 'H = 15','H = 1', 'H = 6', 'H = 15'}, ...
    'xtick', {1, 2:2:6, 5:5:15, 1, 2:2:6, 5:5:15},'xticklabel',{1, 2:2:6, 5:5:15, 1, 2:2:6, 5:5:15});
tav = ff(human.gp.av_gp_av_cc_best);
tse = ff(human.gp.ste_gp_av_cc_best);
for i = 1:4
    rid = [((5-i) * 2 -1),(5-i) * 2];
    plt.new;
    if i == 4
        plt.setfig_ax('color',colall);
        for j = 1:6
            plt.lineplot(100,1);
        end
    end
    plt.lineplot(tav(rid,:), tse(rid,:));%,[],[],tstat_humancb(i,:));
    if i == 4 
        [lgd] = columnlegend(4,  {" "," "," "," "," "," ",'guided = bad', 'guided = good'}');
        lgd.Position = [0.6519 0.6111 0.3681 0.2525];
        lgd.FontSize = plt.param_figsetting.fontsize_leg;
    end
end
tav = ff(rat.gp.av_gp_av_cc_best);
tse = ff(rat.gp.ste_gp_av_cc_best);
for i = 1:3
    rid = [((4-i) * 2 -1),(4-i) * 2];
    plt.new;
    if i == 3
        plt.setfig_ax('color',[{'white','white'},colall([1 2 5:8])]);
        for j = 1:6
            plt.lineplot(100,1);
        end
    end
    plt.lineplot(tav(rid,:), tse(rid,:));%,[],[],tstat_ratcb(i,:));
    if i == 3
        [lgd] = columnlegend(4,  {" "," "," "," "," "," ",'guided = bad', 'guided = good'}');
        lgd.Position = [0.6519 0.4111 0.3681 0.2525];
        lgd.FontSize = plt.param_figsetting.fontsize_leg;
    end
end
tav = ff(human.gp.av_gp_av_cc_switch);
tse = ff(human.gp.ste_gp_av_cc_switch);
for i = 1:4
    rid = [((5-i) * 2 -1),(5-i) * 2];
    plt.new;
    if i == 4
        plt.setfig_ax('color',colall);
        for j = 1:6
            plt.lineplot(100,1);
        end
    end
    plt.lineplot(tav(rid,:), tse(rid,:));%,[],[],tstat_humansw(i,:));
    if i == 4 
        [lgd] = columnlegend(4,  {" "," "," "," "," "," ",'guided = bad', 'guided = good'}');
        lgd.Position = [0.6519 0.2011 0.3681 0.2525];
        lgd.FontSize = plt.param_figsetting.fontsize_leg;
    end
end
tav = ff(rat.gp.av_gp_av_cc_switch);
tse = ff(rat.gp.ste_gp_av_cc_switch);
for i = 1:3
    rid = [((4-i) * 2 -1),(4-i) * 2];
    plt.new;
    if i == 3
        plt.setfig_ax('color',[{'white','white'},colall([1 2 5:8])]);
        for j = 1:6
            plt.lineplot(100,1);
        end
    end
    plt.lineplot(tav(rid,:), tse(rid,:));%,[],[],tstat_ratsw(i,:));
    if i == 3
        [lgd] = columnlegend(4,  {" "," "," "," "," "," ",'guided = bad', 'guided = good'}');
        lgd.Position = [0.6519 0.0011 0.3681 0.2525];
        lgd.FontSize = plt.param_figsetting.fontsize_leg;
%         lgd. = plt.param_figsetting.fontsize_leg;
    end
end
plt.update;
plt.addABCs([-0.09, 0.04],'A   B  C   D  ');
plt.save('split_gb');
%%
plt.figure(2,2,'istitle','gap',[0.07 0.1], 'margin', [0.1 0.13 0.05 0.02]);

plt.setfig([1 3],'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, ...
    'legord', 'reverse', 'legloc', 'SouthWest',...
    'color',{col_human, col_rat}, ...
    'legend',{leg_human, leg_rat}, ...
    'xlabel', {'','guided reward'}, ...
    'ylabel', {{'human','p(explore)'},...
        {'rat','p(explore)'}});


plt.new;
plt.lineplot(human.gp.av_bin_all_c1_cc_explore, human.gp.ste_bin_all_c1_cc_explore);

plt.new;
plt.setfig_ax('xlabel', '', 'ylabel', 'p(explore)', 'xtick',1:4, 'xticklabel', [1 2 5 10],...
    'color',col_human(end:-1:1),'xlim', [],'ylim',[.4 .8],'ytick',0.4:.2:.8);
plt.barplot(human.gp.av_av_cc_explore(end:-1:1,1)',human.gp.ste_av_cc_explore(end:-1:1,1)');

cc = human.sub.av_cc_explore(:,1);
hh = human.sub.cond_horizon;
% [~,pp]=ttest(cc(hh==1 & gg==0)-cc(hh==6 & gg==0))
% [~,pp]=ttest(cc(hh==1 & gg==1)-cc(hh==6 & gg==1))
% [~,pp]=ttest(cc(hh==1 & gg==3)-cc(hh==6 & gg==3))
rid = arrayfun(@(x) find(ismember(unique(human.sub.rat), x)),human.sub.rat);
anovan(cc, [hh rid], 'random', 2)



plt.new;
plt.lineplot(rat.gp.av_bin_all_c1_cc_explore, rat.gp.ste_bin_all_c1_cc_explore);


plt.new;
plt.setfig_ax('xlabel', 'horizon', 'ylabel', 'p(explore)', 'xtick',[1 2 3], 'xticklabel', [1 6 15],...
    'color', col_rat(end:-1:1),'xlim', [],'ylim',[.4 .8],'ytick',0.4:.2:.8);
plt.barplot(rat.gp.av_av_cc_explore(end:-1:1,1)',rat.gp.ste_av_cc_explore(end:-1:1,1)',[1 2 3]);

cc = rat.sub.av_cc_explore(:,1);
hh = rat.sub.cond_horizon;
rid = arrayfun(@(x) find(ismember(unique(rat.sub.rat), x)),rat.sub.rat);
anovan(cc, [hh rid], 'random', 2)


plt.update;
plt.addABCs([-0.06, 0.04]);
plt.save('rcurve_explore');
%% load samples
hbidir = '../../result_bayes';
file = fullfile(hbidir, 'HBI_model_simple_between_all_samples.mat');
sp1 = importdata(file);
file = fullfile(hbidir, 'HBI_model_simple_human_samples.mat');
sp2 = importdata(file);
file = fullfile(hbidir, 'HBI_model_simple_between_all_stat.mat');
st1 = importdata(file).stats;
file = fullfile(hbidir, 'HBI_model_simple_human_stat.mat');
st2 = importdata(file).stats;
%%
% plt.figure(2,2, 'istitle','margin',[0.1 0.13 0.05 0.02]);
plt.figure(2,4, 'istitle','gap',[0.15 0.06]);
rgr = {[0 5], [0 10], [0 5], [0 10]};
rgr2 = -1:.01:21;
plt.setfig_new;
plt.setfig([1 3 5 7],'color', {{'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},...
    {'AZblue', 'AZred','AZcactus'},{'AZblue', 'AZred','AZcactus'}}, ...
    'legend',{{'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},...
    {'H = 1','H = 6','H = 15'},{'H = 1','H = 6','H = 15'}}, 'xlim', rgr, ...
    'legloc', {'NorthWest','NorthEast','NorthWest','NorthEast'}, ...
    'xlabel', {'threshold','noise',...
    'threshold','noise'}, ...
    'ylabel',{{'human','density'},'density',{'rat','density'},'density'});
% plt.setfig('color', {{'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},...
%     {'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},...
%     {'AZblue', 'AZred','AZcactus'},{'AZblue', 'AZred','AZcactus'},{'AZblue', 'AZred','AZcactus'}}, ...
%     'legend',{{'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},...
%     {'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},...
%     {'H = 1','H = 6','H = 15'},{'H = 1','H = 6','H = 15'},{'H = 1','H = 6','H = 15'}}, 'xlim', rgr, ...
%     'legloc', {'NorthWest','NorthEast','NorthEast','NorthWest','NorthEast','NorthEast','NorthWest','NorthEast','NorthEast'}, ...
%     'xlabel', {'threshold - human','noise - human','bias - human',...
%     'threshold - human (1-5)','noise - human (1-5)','bias - human (1-5)',...
%     'threshold - rat','noise - rat','bias - rat'}, ...
%     'ylabel',{'density','','','density','','','density','',''});
% plt.new;
% [ty, tm] = W_plt_JAGS.density(sp3.thres, [-1:0.1:100])
% plt.lineplot(ty ,[],tm);
% plt.new;
% [ty, tm] = W_plt_JAGS.density(sp3.noise, [-1:0.1:100])
% plt.lineplot(ty,[],tm);
% plt.new;
% [ty, tm] = W_plt_JAGS.density(sp3.bias_mu, [-100:0.1:100])
% plt.lineplot(ty,[],tm);

plt.new;
[ty, tm] = W_plt_JAGS.density(sp2.thres, rgr2);
plt.lineplot(ty ,[],tm);

plt.new;
plt.setfig_ax('color', col_human(end:-1:1),'ylim', [0 5], 'xlabel', 'horizon', 'ylabel','threshold',...
    'xtick',1:4,'xticklabel',[1 2 5 10]);
[tav,tse] = W.avse(st2.mean.tthres');
tall = [reshape(st2.mean.tthres',[],1),reshape(ones(40,1) * [1 2 3 4],[],1), repmat(1:40,1,4)'];
anovan(tall(:,1), tall(:,2:3), 'random', 2)

plt.barplot(tav*5, tse*5);

plt.new;
[ty, tm] = W_plt_JAGS.density(sp2.noise, rgr2);
plt.lineplot(ty,[],tm);
% plt.new;
% [ty, tm] = W_plt_JAGS.density(sp2.bias_mu, [-6:0.1:6])
% plt.lineplot(ty,[],tm);

plt.new;
plt.setfig_ax('color', col_human(end:-1:1),'ylim', [0 10], 'xlabel', 'horizon', 'ylabel','noise',...
    'xtick',1:4,'xticklabel',[1 2 5 10]);
[tav,tse] = W.avse(st2.mean.tnoise');
tall = [reshape(st2.mean.tnoise',[],1),reshape(ones(40,1) * [1 2 3 4],[],1), repmat(1:40,1,4)'];
anovan(tall(:,1), tall(:,2:3), 'random', 2)
plt.barplot(tav, tse);


plt.new;
[ty, tm] = W_plt_JAGS.density(sp1.thres, -1:.01:21);
plt.lineplot(ty ,[],tm);


plt.new;
plt.setfig_ax('color', col_rat(end:-1:1),'ylim', [0 5], 'xlabel', 'horizon', 'ylabel','threshold',...
    'xtick',1:3,'xticklabel',[1 6 15],'ytick',0:5);
[tav,tse] = W.avse(st1.mean.tthres');
plt.barplot(tav*5, tse*5);
tall = [reshape(st1.mean.tthres',[],1),reshape(ones(6,1) * [1 2 3],[],1), repmat(1:6,1,3)'];
% tall = tall(~(tall(:,2) == 3 & ismember(tall(:,3),[2 5])),:);
anovan(tall(:,1), tall(:,2:3), 'random', 2)

plt.new;
[ty, tm] = W_plt_JAGS.density(sp1.noise, -1:.05:21);
plt.lineplot(ty,[],tm);


plt.new;
plt.setfig_ax('color', col_rat(end:-1:1),'ylim', [0 10], 'xlabel', 'horizon', 'ylabel','noise',...
    'xtick',1:3,'xticklabel',[1 6 15]);
[tav,tse] = W.avse(st1.mean.tnoise');

tall = [reshape(st1.mean.tnoise',[],1),reshape(ones(6,1) * [1 2 3],[],1), repmat(1:6,1,3)'];
anovan(tall(:,1), tall(:,2:3), 'random', 2)
plt.barplot(tav, tse);
% plt.new;
% [ty, tm] = W_plt_JAGS.density(sp1.bias_mu, [-6:0.1:6])
% plt.lineplot(ty,[],tm);
plt.update;
plt.addABCs([-0.04, 0.05]);
plt.save('bayes_density');
