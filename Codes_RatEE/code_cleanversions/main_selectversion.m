%% load datadir
datadir = '../../data_processed/versions';
outputdir = '../../data_processed/versions_cleaned';
[~,versions] = W.dir(fullfile(datadir, '*version*'))
%% between
% data = W.readtable(fullfile(datadir, 'gameversion_G3_between'));
% data2 = W.readtable(fullfile(datadir, 'gameversion_mixed_long_between'));
% data2 = data2(data2.n_guided == 3, :);
% data = W.tab_vertcat(data, data2);
% sessions = W_sub.selectsubject(data, {'foldername', 'filename'});
% addpath('../code_behavior/');
% tdata = W_sub.preprocess_subxgame(data, sessions, {'func_cond_drop', 'preprocess_RatEE'});
% % exclude 17
% tid = tdata.cond_drop ~= '17';
% disp(sprintf('%.5f %% of the trials kept', 100 * mean(tid)));
% data = data(tid, :);
% % use only 012345 and 0135
% % tid = contains(tdata.cond_drop, ["012345", "0135"]);
% % disp(sprintf('%.5f %% of the trials kept', 100 * mean(tid)));
% % data = data(tid,:);
% W.writetable(data, fullfile(outputdir, 'final_between.csv'));
%% between all
data = W.readtable(fullfile(datadir, 'gameversion_G3_between'));
data2 = W.readtable(fullfile(datadir, 'gameversion_long_between'));
data = W.tab_vertcat(data, data2);
W.writetable(data, fullfile(outputdir, 'final_between_all.csv'));
%% within
% data = W.readtable(fullfile(datadir, 'gameversion_G34_within'));
% data = data(data.rat ~= "Bobo",:);
% data = data(data.n_guided == 3,:);
% data = data(~(data.str_date == 20200809 & data.rat == "Gerald"),:);% exclude one session for Gerald
% W.writetable(data, fullfile(outputdir, 'final_within.csv'));
%% sound
% data = W.readtable(fullfile(datadir, 'gameversion_RandH_control_G3F16'));
% W.writetable(data, fullfile(outputdir, 'final_sound.csv'));
%% within-all
data = W.readtable(fullfile(datadir, 'gameversion_within'));
data2 = W.readtable(fullfile(datadir, 'gameversion_RandH_G3F16'));
data = W.tab_vertcat(data, data2);
data3 = W.readtable(fullfile(datadir, 'gameversion_RandH_G0123F16_within'));
data = W.tab_vertcat(data, data3);
data4 = W.readtable(fullfile(datadir, 'gameversion_G0F38_within'));
data = W.tab_vertcat(data, data4);
data = data(data.rat ~= "Bobo",:);
W.writetable(data, fullfile(outputdir, 'final_within_all.csv'));
% %% control - random
% data = W.readtable(fullfile(datadir, 'gameversion_control_G3F6_random'));
% % d2 = W.readtable(fullfile(datadir, 'gameversion_G3_between'));
% % d2 = d2(d2.n_free == 6 & d2.n_guided == 3,:);
% % data = W.tab_vertcat(data,d2);
% W.writetable(data, fullfile(outputdir, 'final_random.csv'));
% %% guide vs free
% data = W.readtable(fullfile(datadir, 'gameversion_G01_within'));
% W.writetable(data, fullfile(outputdir, 'final_guidefree.csv'));
%% human - reformat
data = W.readtable(fullfile(datadir, 'gameversion_human')');
sub = W_sub.tab_unique(data, W_sub.selectsubject(data, 'filename'));
idxage = (sub.demo_age >= 18);
disp(sprintf('%d excluded for age, gender count %d Male, %d female', ...
    sum(~idxage), sum(strcmp(sub(idxage,:).demo_gender, 'male')), sum(strcmp(sub(idxage,:).demo_gender, 'female'))));
data = data(data.demo_age >= 18,:);
data = W.tab_fill(data, 'foldername', 'human');
data.rat = data.filename;
data.n_guided(:,1) = 1;
data.n_free = sum(~isnan(data.choice),2)-1;
data.is_guided = [ones(size(data,1),1), zeros(size(data,1), size(data.choice,2)-1).*data.choice(:,2:end)];
data.r = data.reward;
data.c = data.choice;
data.feeders = repmat([1 2], size(data,1),1);
data.drop = data.trueMean;
W.writetable(data, fullfile(outputdir, 'final_human.csv'));
%% human full - reformat
data = W.readtable(fullfile(datadir, 'gameversion_human_full')');
sub = W_sub.tab_unique(data, W_sub.selectsubject(data, 'filename'));
idxage = (sub.demo_age >= 18);
disp(sprintf('%d excluded for age, gender count %d Male, %d female', ...
    sum(~idxage), sum(strcmp(sub(idxage,:).demo_gender, 'male')), sum(strcmp(sub(idxage,:).demo_gender, 'female'))));
data = data(data.demo_age >= 18,:);
data = W.tab_fill(data, 'foldername', 'human');
data.rat = data.filename;
data.n_guided(:,1) = 1;
data.n_free = sum(~isnan(data.choice),2)-1;
data.is_guided = [ones(size(data,1),1), zeros(size(data,1), size(data.choice,2)-1).*data.choice(:,2:end)];
data.r = data.reward;
data.c = data.choice;
data.feeders = repmat([1 2], size(data,1),1);
data.drop = data.trueMean;
W.writetable(data, fullfile(outputdir, 'final_human_full.csv'));

