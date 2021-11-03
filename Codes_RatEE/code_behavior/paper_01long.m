fn = '../../data_processed/versions_cleaned/final_between_all.csv';
data = W.readtable(fn);
%% within/guide 0-1-3
data = data(data.n_guided <= 1, :);
data = data(data.n_free >= 15,:);
% data = data(~ismember(data.n_free, [3 8]),:);
% data = filter_longRT(data, 0.9);
%% preprocess
sessions = W_sub.selectsubject(data, {'rat', 'n_free', 'n_guided'});
data = W_sub.preprocess_subxgame(data, sessions, 'preprocess_RatEE');
%% ac
sessions = W_sub.selectsubject(data, {'rat', 'n_guided','cond_horizon'});
data = W_sub.preprocess_subxgame(data, sessions, 'performance_RatEE');
% %% exclude sessions based accuracy
% tac = W_sub.analysis_group(data, {'rat', 'foldername','cond_horizon'});
% tac = tac(tac.av_cond_horizon > 1,:);
%% basic analysis
sessions = W_sub.selectsubject(data, {'rat', 'n_guided','cond_horizon'});
tsub = W_sub.analysis_sub(data, sessions, 'behavior_RatEE');
sub = W.tab_squeeze(tsub);
%% group
gp = W_sub.analysis_group(sub, {'cond_horizon','n_guided'});
% sort
[~, od] = sort(gp.av_cond_horizon, 'descend');
gp = gp(od,:);
%%
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'guidefree');
plt.setuserparam('param_setting', 'isshow', 1);
%%
plt.figure(1,1, 'istitle', 'margin', [0.15 0.15 0.1 0.01],'gap',[0.05 0.07]);
plt.setfig_new;
plt.setfig(1,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', {'AZcactus', 'AZcactus50'}, ...
    'xlabel', 'R guided', ...
    'ylabel', 'p(explore)', 'legend', {{'guided', 'free'}});
tp = gp.av_bin_all_cc_switch;
tp_se = gp.ste_bin_all_cc_switch;
for i = 1:1
    plt.ax(1,i);
%     tid = gp.av_cond_horizon == hzs(i) & gp.av_cond_guided <= 1;
    plt.lineplot(tp,tp_se);
end
plt.update;
plt.save('rcurve_long');
%%

plt.figure(1,1, 'istitle', 'margin', [0.15 0.15 0.1 0.01],'gap',[0.05 0.07]);
plt.setfig_new;
plt.setfig(1,'xlim', [0.5 15.5], 'xtick', 1:15, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', {'AZcactus', 'AZcactus50'}, ...
    'xlabel', 'R guided', ...
    'ylabel', 'p(explore)', 'legend', {{'guided', 'free'}});
tp = assist_ff(gp.av_av_cc_switch);
tp_se = assist_ff(gp.ste_av_cc_switch);
for i = 1:1
    plt.ax(1,i);
%     tid = gp.av_cond_horizon == hzs(i) & gp.av_cond_guided <= 1;
    plt.lineplot(tp,tp_se);
end
plt.update;
plt.save('basic_long');