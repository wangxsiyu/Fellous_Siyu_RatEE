fn = '../../data_processed/versions_cleaned/final_between_all.csv';
data = W.readtable(fn);
%% preprocess
sessions = W_sub.selectsubject(data, {'rat', 'n_free', 'n_guided'});
data = W_sub.preprocess_subxgame(data, sessions, 'preprocess_RatEE');
%% ac
sessions = W_sub.selectsubject(data, {'rat', 'n_guided','cond_horizon'});
data = W_sub.preprocess_subxgame(data, sessions, 'performance_RatEE');
%% get func_cond_drop
sessions = W_sub.selectsubject(data, {'foldername', 'filename'});
tdata = W_sub.preprocess_subxgame(data, sessions, {'func_cond_drop'});
tid = tdata.cond_drop ~= '17';
data = data(tid,:);
%% exclude sessions based accuracy
tac = W_sub.analysis_group(data, {'rat', 'foldername','cond_horizon'});
%%
cols = {'AZblue', 'AZred', 'AZcactus', 'AZsand','AZbrick','AZsky'};
syms = strcat('-', {'o','o','+','^','^','x','d'});
ww = W_colors;
rats = unique(tac.rat);
nrat = length(rats);
conds = unique(tac.str_guidefree);
ncond = length(conds);
for i = 1:nrat
    for j = 1:ncond
        tid = strcmp(tac.rat, rats(i)) & strcmp(tac.str_guidefree, conds(j));
        if any(tid)
            td = tac(tid,:);
            plot(td.datetime, nanmean(td.av_cc_best,2), syms{j}, 'color', ww.(cols{i}));
            hold on;
        end
    end
end
%%
acs = nanmean(tac.av_cc_best,2);
tid = find(acs < 0.4);
ses_exclude = tac(tid,:).foldername;
mean(~contains(data.foldername, ses_exclude))
data = data(~contains(data.foldername, ses_exclude),:);
% %% session plot
% tses = W_sub.selectsubject(tac, {'rat', 'foldername'});
% tac_ses =  W_sub.tab_trial2game(tac, tses);
% %%
% tac = tac(tac.av_n_free > 1,:);
% data = data(contains(data.foldername, tac.foldername(tac.av_cc_best_smoothed > 0.5)),:);
%% include only horizon 3
data = data(ismember(data.cond_guided, [3]), :);
%% basic analysis
sessions = W_sub.selectsubject(data, {'rat', 'n_guided','cond_horizon'});
tsub = W_sub.analysis_sub(data, sessions, 'behavior_RatEE');
sub = W.tab_squeeze(tsub);
%% group
gp = W_sub.analysis_group(sub, {'cond_horizon','n_guided'});
% sort
[~, od] = sort(gp.av_cond_horizon, 'descend');
gp = gp(od,:);
%% get bayes
bayesname = replace(fn, 'final', 'bayes');
bayesname = replace(bayesname, '.csv', '');
bayesname = replace(bayesname, 'versions_cleaned', 'bayesdata');
get_bayesdata(data, bayesname);
%% figure
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'RatEE','fig_suffix','between');
plt.setuserparam('param_setting', 'isshow', 1);
%% color/legend
col = {'AZcactus', 'AZred', 'AZblue'};
leg = strcat("H = ",gp.group_analysis.cond_horizon);
%% by trial number
plt.setfig_new;
plt.setfig_loc(2,'xlim', [0.5 15.5], 'ylim', {[0.5 1], [0 1]} , ...
    'ytick', {0.5:0.1:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', {'SouthEast', 'NorthEast'});
plt = fig_behavior_gp(plt, gp, 'av', 'trial number', col, ...
    leg, ['gp_av']);
%% split by good/bad
% plt.setfig_loc(2,'xlim', xlm, 'ylim', {[0.4 1], [0 1]},'legloc', {'NorthWest', 'NorthEast'});
% plt = fig_behavior_gp(plt, gp, 'gp_av', 'trial number', col2, ...
%     leg2, ['gp_acG']);
plt.figure(2,3,'rect',[0 0 0.7 0.8], 'gap',[0.1 0.05], 'margin', [0.15 0.1 0.1 0.05]);
plt.setfig('ylabel', {'p(high reward)','','',...
    'p(switch)','',''}, ...
    'legend', leg, 'ylim', {[0.4 1],[0.4 1],[0.4 1],[0 1],[0 1],[0 1]}, ...
    'xlabel', {'','','','','trial number',''}, ...
    'xlim', [0.5 15.5], ...
    'color', {{'AZblue50','AZblue'},{'AZred50','AZred'},{'AZcactus50','AZcactus'},...
    {'AZblue50','AZblue'},{'AZred50','AZred'},{'AZcactus50','AZcactus'}},...
    'legloc', {'SouthEast','SouthEast','SouthEast','NorthEast','NorthEast','NorthEast'}, ...
    'legend', {'guided = good', 'guided = bad'}, ...
    'title', {'H = 1', 'H = 6', 'H = 15','','',''});
tav = assist_ff(gp.av_gp_av_cc_best);
tse = assist_ff(gp.ste_gp_av_cc_best);
for i = 1:3
    rid = [((4-i) * 2 -1),(4-i) * 2];
    plt.new;
    plt.lineplot(tav(rid,:), tse(rid,:));
end
tav = assist_ff(gp.av_gp_av_cc_switch);
tse = assist_ff(gp.ste_gp_av_cc_switch);
for i = 1:3
    rid = [((4-i) * 2 -1),(4-i) * 2];
    plt.new;
    plt.lineplot(tav(rid,:), tse(rid,:));
end
plt.update;
plt.save('split_gb');
%% R curve
plt.setfig_new;
plt.setfig_loc(2,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', {[0 1],[0 1]}, 'ytick', {0:0.2:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', 'SouthWest');
plt = fig_behavior_gp(plt, gp, 'bin_all', 'R guided', col , ...
    leg, ['gp_rG']);

