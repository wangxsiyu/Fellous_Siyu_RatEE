%%
hbidir = '/Users/wang/WANG/Fellous_Siyu_RatEE/result_bayes';
file = fullfile(hbidir, 'HBI_model_rat_within_all_samples.mat');
sp = importdata(file);
%%
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'Within');
%%
plt.figure(3,3,'rect', [0 0 0.6 0.7], 'gap', [0.2 0.1], 'margin', [0.15 0.1 0.05 0.05]);
rgr = {[0 5], [0 5],[0 5], [0 20],[0 20],[0 20],[-5 5],[-5 5],[-5 5]};
plt.setfig('color', {'AZblue','AZred'}, ...
    'legend',{'H = 1','H = 2','H = 3', 'H = 4'}, 'xlim', rgr, ...
    'xlabel', {'threshold', 'threshold', 'threshold', 'noise', 'noise', 'noise'}, ...
    'ylabel', {'density', '','','density', '',''});
plt.setup_pltparams('linewidth',1)
[ty, tm] = W_plt_JAGS.density(sp.thres, -1:.01:21)
for i =  [3 2 1]
plt.new;
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i} ,[],tm);
end
[ty, tm] = W_plt_JAGS.density(sp.noise, -1:.04:21)
for i = [3 2 1]
plt.new;
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i},[],tm);
end
[ty, tm] = W_plt_JAGS.density(sp.bias_mu, -21:.04:21)
for i = [3 2 1]
plt.new;
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i},[],tm);
end
plt.update;
plt.save('within_simple');
%%
% file = fullfile(hbidir, 'HBI_model_within_diff_within_all_samples.mat');
% sp = importdata(file);
%%
plt.figure(2,1, 'istitle','rect', [0 0 0.2 0.6], 'gap', [0.2 0.15], ...
    'margin', [0.15 0.25 0.05 0.05]);
rgr = {[-5 5], [-5 5]};
rgr2 = -21:.01:21;
str1 = sprintf('%.2f samples < 0', mean(sp.dthres(:,:,1) <= 0, 'all')*100)
str2 = sprintf('%.2f samples < 0', mean(sp.dnoise <= 0, 'all')*100)
plt.setfig_new;
plt.setfig('color', 'black', ...
    'xlim', rgr, ...
    'ylabel', 'density', 'xlabel', {'\Delta threshold','\Delta noise'},...
    'ylim', [0 1]);
plt.new;
[ty, tm] = W_plt_JAGS.density(sp.dthres, rgr2);
plt.lineplot(ty ,[],tm);
hold on;
plot([0 0], [-100 100],'--r');
plt.new;
[ty, tm] = W_plt_JAGS.density(sp.dnoise, rgr2);
plt.lineplot(ty,[],tm);
hold on;
plot([0 0], [-100 100],'--r');
plt.update;
plt.save('diff');
% %%
% file = fullfile(hbidir, 'HBI_model_simple_between_all_stat.mat');
% st1 = importdata(file);
% file = fullfile(hbidir, 'HBI_model_simple_human_stat.mat');
% st2 = importdata(file);