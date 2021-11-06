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
% tid = find(acs < 0.4);
tid1 = find(tac.datetime < datetime(2020, 10, 30) & ismember(tac.rat,{'Gerald','Twenty'}) & tac.av_n_free >= 15);
tid2 = find(acs < 0.4 & ismember(tac.rat,{'Ratzo','Rizzo'}) & tac.av_n_free == 6);
tid = [tid1; tid2];
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
%% save
save('../../data_processed/output/gp_between', 'gp', 'sub');
%% get bayes
bayesname = replace(fn, 'final', 'bayes');
bayesname = replace(bayesname, '.csv', '');
bayesname = replace(bayesname, 'versions_cleaned', 'bayesdata');
get_bayesdata(data, bayesname);


