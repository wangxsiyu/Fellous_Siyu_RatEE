gp = importdata('../../data_processed/output/gp_within.mat').gp;
%%
hbidir = '/Users/wang/WANG/Fellous_Siyu_RatEE/result_bayes';
file = fullfile(hbidir, 'HBI_model_rat_within_all_samples.mat');
sp = importdata(file);
file = fullfile(hbidir, 'HBI_model_rat_within_all_stat.mat');
st = importdata(file);
%%
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'within');
%% horizon difference
gds = [0 1 3];
tlt = W.arrayfun(@(x)sprintf('nGuided = %d', x), gds);
nfig = length(gds);
plt.figure(3,4, 'matrix_hole', [1 1 1 1; 1 1 1 1; 1 1 1 1], 'istitle','rect', [0 0 0.7 0.9],...
    'margin', [0.1 0.1 0.06 0.01],'gap',{[0.1 0.1], [0.07 0.07 0.07]});
plt.setup_pltparams('fontsize_face',20,'fontsize_leg',10);
% plt.setfig_new;
rgr = {[0 5], [0 5],[0 5], [0 20],[0 20],[0 20]};
plt.setfig([4:6, 8:10]+1,'color', {'AZblue','AZred'}, ...
    'legend',{'H = 1','H = 6'}, 'xlim', rgr, ...
    'xlabel', {'threshold', 'threshold', 'threshold', 'noise', 'noise', 'noise'}, ...
    'ylabel', 'density',...
    'legloc',{'NorthEast','NorthWest','NorthWest','NorthEast','NorthEast','NorthEast'});
% plt.setfig(8:10, 'ylim', {[0 0.3], [0 0.25], [0 0.4]});
plt.setfig(1:3,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', {'AZred', 'AZblue'}, ...
    'xlabel', 'guided reward', ...
    'ylabel', 'p(explore)', 'legend', {'H = 6', 'H = 1'}, ...
    'title', tlt);
% tp = gp.av_av_cc_switch;
% tp_se = gp.ste_av_cc_switch;
% for i = 1:length(gds)
%     plt.ax(1,i);
%     tid = gp.av_cond_guided == gds(i);
%     plt.lineplot(tp(tid,:), tp_se(tid,:));
% end




tp = gp.av_bin_all_c1_cc_explore;
tp_se = gp.ste_bin_all_c1_cc_explore;
for i = 1:length(gds)
    plt.new;
    tid = gp.av_cond_guided == gds(i);
    plt.lineplot(tp(tid,:), tp_se(tid,:));
end
tav = gp.av_av_cc_explore([5 2 4 1 6 3],1);
tse = gp.ste_av_cc_explore([5 2 4 1 6 3],1);
x = [1 2 4 5 7 8];
plt.ax(1,4);
plt.setfig_ax('xlabel','nGuided','ylabel','p(explore)',...
    'color',{'AZblue','AZred','AZblue','AZred','AZblue','AZred'}, ...
    'xtick',[1.5 4.5 7.5],'xticklabel', [0 1 3],'ylim', [0 0.7]);
plt.barplot(tav', tse', x);

% plt.figure(3,3,'rect', [0 0 0.6 0.7], 'gap', [0.2 0.1], 'margin', [0.15 0.1 0.05 0.05]);
plt.setup_pltparams('hold','linewidth',2)
[ty, tm] = W_plt_JAGS.density(sp.thres, -1:.01:21);
for i =  1:3
plt.ax(2,i);
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i} ,[],tm);
end
[ty, tm] = W_plt_JAGS.density(sp.noise, -1:.04:21);
for i = 1:3
plt.ax(3,i);
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i},[],tm);
end
% [ty, tm] = W_plt_JAGS.density(sp.bias_mu, -21:.04:21)
% for i = [3 2 1]
% plt.new;
% % plt.setfig_ax('xlabel','');
% plt.lineplot(ty{i},[],tm);
% end
% plt.update;
% plt.save('within_simple');
% %%
% % file = fullfile(hbidir, 'HBI_model_within_diff_within_all_samples.mat');
% % sp = importdata(file);
% %%
% plt.figure(2,1, 'istitle','rect', [0 0 0.2 0.6], 'gap', [0.2 0.15], ...
%     'margin', [0.15 0.25 0.05 0.05]);
rgr = {[-3 3], [-10 10]};
% str1 = sprintf('%.2f samples < 0', mean(sp.dthres(:,:,1) <= 0, 'all')*100)
% str2 = sprintf('%.2f samples < 0', mean(sp.dnoise <= 0, 'all')*100)
% plt.setfig_new;
plt.setup_pltparams('hold', 'fontsize_leg', 7);
plt.setfig([7,11]+1, 'color', {'AZsand','AZmesa','black'}, ...
    'xlim', rgr, ...
    'ylabel', 'density', 'xlabel', {'\Delta threshold','\Delta noise'},...
    'ylim', {[0 1], [0 0.25]},...
    'legend', {'nGuided = 0','nGuided = 1','nGuided = 3'});
plt.ax(2,4);
[ty, tm] = W_plt_JAGS.density(sp.dthres, -10:.01:10);
plt.lineplot(ty ,[],tm);
ylm1 = get(plt.fig.axes(7),'YLim');
hold on;
plot([0 0], ylm1,'--r');
plt.ax(3,4);
[ty, tm] = W_plt_JAGS.density(sp.dnoise, -11:.04:11);
plt.lineplot(ty,[],tm);
ylm2 = get(plt.fig.axes(11),'YLim');
hold on;
plot([0 0], ylm2,'--r');
plt.addABCs([-0.05 0.03],'A  BC  ED  F');
plt.update;
plt.save('all');
% %%
% file = fullfile(hbidir, 'HBI_model_simple_between_all_stat.mat');
% st1 = importdata(file);
% file = fullfile(hbidir, 'HBI_model_simple_human_stat.mat');
% st2 = importdata(file);
%% effect guide vs free
plt.figure(2,3,'matrix_hole', [1 1 0;1 1 1],'gap',[0.15 0.08]);
plt.setfig_new;
col = {'AZred','AZred50','AZblue','AZblue50'};
plt.setfig([1 2],'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 1:6, ...
    'ylim', {[0.4 0.8],[0 0.8]}, 'ytick', {0:0.1:1, 0:0.2:1},'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', col, 'legloc', {'SouthEast','NorthEast'}, ...
    'xlabel', 'trial number', ...
    'ylabel', {'p(high reward)', 'p(switch)'}, 'legend', {'H = 6, guided', 'H = 6, free', 'H = 1, guided', 'H = 1, free'});
tid = gp.av_cond_guided <= 1;
plt.ax(1,1);
tp = gp.av_av_cc_best;
tp_se = gp.ste_av_cc_best;
plt.lineplot(tp(tid,:), tp_se(tid,:));
plt.ax(1,2);
tp = gp.av_av_cc_switch;
tp_se = gp.ste_av_cc_switch;
plt.lineplot(tp(tid,:), tp_se(tid,:));


tav = gp.av_av_cc_explore([5 4 2 1],1);
tse = gp.ste_av_cc_explore([5 4 2 1],1);
plt.ax(2,3);
plt.setfig_ax('xlabel','horizon','ylabel','p(explore)',...
    'color',{'AZblue50','AZblue','AZred50','AZred'}, ...
    'xtick',[1.5 4.5],'xticklabel', [1 6],'ylim', [0 0.7]);
plt.barplot(tav', tse', [1 2 4 5]);


% plt.update;
% guided vs free - rcurve
hzs = [1 6];
tlt = W.arrayfun(@(x)sprintf('H = %d', x), hzs);
nfig = length(hzs);
% plt.figure(1,nfig, 'istitle', 'margin', [0.2 0.07 0.1 0.01],'gap',[0.05 0.07]);
% plt.setfig_new;
col = {{'AZblue', 'AZblue50'},{'AZred', 'AZred50'}};
plt.setfig([3 4],'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', col, ...
    'xlabel', 'guided reward', ...
    'ylabel', 'p(explore)', 'legend', {{'guided', 'free'},{'guided', 'free'}}, ...
    'title', tlt);
tp = gp.av_bin_all_c1_cc_explore;
tp_se = gp.ste_bin_all_c1_cc_explore;
for i = 1:length(hzs)
    plt.ax(2,i);
    tid = gp.av_cond_horizon == hzs(i) & gp.av_cond_guided <= 1;
    plt.lineplot(tp(tid,:), tp_se(tid,:));
end
plt.update;
plt.addABCs([-0.05 0.05], 'ABC D');
plt.save('guidefree');
%%
plt.figure(2,2);
% 'istitle','rect', [0 0 0.2 0.6], 'gap', [0.2 0.15], ...
%     'margin', [0.15 0.25 0.05 0.05]);
% str1 = sprintf('%.2f samples < 0', mean(sp.dthres <= 0, 'all')*100);
% str2 = sprintf('%.2f samples < 0', mean(sp.dnoise <= 0, 'all')*100);
% plt.setfig_new;
plt.setfig([1 3],'color', {'AZblue50', 'AZblue', 'AZred50', 'AZred'}, ...
    'xlim', {[0 5], [0 12]}, ...
    'ylabel', 'density', 'xlabel', {'threshold','noise'},...
    'ylim', {[0 1.4], [0 0.3]}, ...
    'legend', {'H = 1, free','H = 1, guided', 'H = 6, free', 'H = 6, guided'});
plt.setfig([2 4],'color', {{'AZblue','AZred'}}, ...
    'xlim', {[-5 5], [-12 12]}, ...
    'ylabel', 'density', 'xlabel', {'\Delta threshold_{free - guided}','\Delta noise_{free - guided}'},...
    'ylim', {[0 0.8], [0 0.2]}, ...
    'legend', {{'H = 1, difference', 'H = 6, difference'}});
plt.new;
spt = sp.thres(:,:,1:2,:);
spt = cat(3,squeeze(spt(:,:,:,1)), squeeze(spt(:,:,:,2)));
% spt(:,:,3) = squeeze(spt(:,:,1)) + sp.dthres_mu;
% spt(:,:,4) = squeeze(spt(:,:,2)) + sp.dthres_mu;
[ty, tm] = W_plt_JAGS.density(spt, -21:.01:21);
% [ty1] = W_plt_JAGS.density(repmat(sp.dthres_mu, 1,1,2), rgr2)
% ty = ty + ty1;
plt.lineplot(ty ,[],tm);

plt.new;
spt = sp.thres(:,:,1:2,:);
spt = squeeze(spt(:,:,1,:) - spt(:,:,2,:));
[ty, tm] = W_plt_JAGS.density(spt, -21:.01:21);
plt.lineplot(ty ,[],tm);
ylm1 = get(plt.fig.axes(2),'YLim');
hold on;
plot([0 0], ylm1,'--r');

plt.new;
spt = sp.noise(:,:,1:2,:);
spt = cat(3,squeeze(spt(:,:,:,1)), squeeze(spt(:,:,:,2)));
% spt(:,:,3) = squeeze(spt(:,:,1)) + sp.dthres_mu;
% spt(:,:,4) = squeeze(spt(:,:,2)) + sp.dthres_mu;
[ty, tm] = W_plt_JAGS.density(spt, -21:.04:21);
% [ty, tm] = W_plt_JAGS.density(sp.noise(:,:,[1:2]), rgr2)
% [ty1] = W_plt_JAGS.density(sp.dnoise_mu, rgr2)
% ty = ty + ty1;
plt.lineplot(ty,[],tm);

plt.new;
spt = sp.noise(:,:,1:2,:);
spt = squeeze(spt(:,:,1,:) - spt(:,:,2,:));
[ty, tm] = W_plt_JAGS.density(spt, -21:.04:21);
plt.lineplot(ty ,[],tm);
ylm1 = get(plt.fig.axes(4),'YLim');
hold on;
plot([0 0], ylm1,'--r');
plt.addABCs([- 0.06 0.04]);
plt.update;
plt.save('bayes_guidefree');
