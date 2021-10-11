%% load datadir
datadir = '../../data_processed';
[~,versions] = W.dir(fullfile(datadir, '*version*'))
%% select data
data = W.readtable(fullfile(datadir, 'gameversion_G3_between'));
data2 = W.readtable(fullfile(datadir, 'gameversion_mixed_long_between'));
data2 = data2(data2.n_guided == 3, :);
data = W.tab_vertcat(data, data2);
%% add ID
data = W_sub.add_gameID(data, {'foldername', 'filename'});
%% get reward setting
sessions = W_sub.selectsubject(data, {'date', 'rat'});
data = W_sub.preprocess_subxgame(data, sessions, 'func_cond_drop');
data = W_sub.preprocess_subxgame(data, sessions, 'preprocess_RatEE');
%% exclude 17
disp(sprintf('%.5f % of the trials kept', mean(data.cond_drop ~= '17')))
data = data(data.cond_drop ~= '17', :);
%% 
W_sub.display_conditions(data, 'cond_drop')
%% only include 012345/0135
data = data(contains(data.cond_drop, ["012345", "0135"]),:);
%% basic analysis
sessions = W_sub.selectsubject(data, {'rat', 'cond_horizon'});
sub = W_sub.analysis_sub(data, sessions, 'behavior_RatEE');
