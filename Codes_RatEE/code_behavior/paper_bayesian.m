hbidir = '/Users/wang/WANG/Fellous_Siyu_RatEE/result_bayes';
file = fullfile(hbidir, 'HBI_model_simple_between_all_samples.mat');
sp1 = importdata(file);
file = fullfile(hbidir, 'HBI_model_simple_human_samples.mat');
sp2 = importdata(file);
%%
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'RatBayes');
%%
plt.figure(2,2, 'istitle', 'gap', [0.1 0.05]);
rgr = {[0 6], [0 10], [0 6], [0 10]};
rgr2 = -1:.01:21;
plt.setfig_new;
plt.setfig('color', {{'AZblue','AZsky', 'AZred','AZcactus'},{'AZblue','AZsky', 'AZred','AZcactus'},...
    {'AZblue', 'AZred','AZcactus'},{'AZblue', 'AZred','AZcactus'}}, ...
    'legend',{{'H = 1','H = 2','H = 5','H = 10'},{'H = 1','H = 2','H = 5','H = 10'},...
    {'H = 1','H = 6','H = 15'},{'H = 1','H = 6','H = 15'}}, 'xlim', rgr, ...
    'legloc', {'NorthWest','NorthEast','NorthWest','NorthEast'}, ...
    'xlabel', {'threshold - human','noise - human','threshold - rat','noise - rat'}, 'ylabel',{'density','','density',''});
plt.new;
[ty, tm] = W_plt_JAGS.density(sp2.thres_mu, rgr2)
plt.lineplot(ty ,[],tm);
plt.new;
[ty, tm] = W_plt_JAGS.density(sp2.noise, rgr2)
plt.lineplot(ty,[],tm);

plt.new;
[ty, tm] = W_plt_JAGS.density(sp1.thres_mu, rgr2)
plt.lineplot(ty ,[],tm);
plt.new;
[ty, tm] = W_plt_JAGS.density(sp1.noise, rgr2)
plt.lineplot(ty,[],tm);
plt.update;
plt.save('between_simple');
%%
file = fullfile(hbidir, 'HBI_model_within_2x2_within_all_samples.mat');
sp = importdata(file);
%%
plt.figure(2,3,'rect', [0 0 0.6 0.7], 'gap', [0.2 0.1], 'margin', [0.15 0.1 0.05 0.05]);
rgr = {[0 6], [0 6],[0 6], [0 20],[0 20],[0 20]};
rgr2 = -1:.01:21;
plt.setfig('color', {'AZblue','AZred'}, ...
    'legend',{'H = 1','H = 2','H = 3', 'H = 4'}, 'xlim', rgr, ...
    'xlabel', {'threshold', 'threshold', 'threshold', 'noise', 'noise', 'noise'}, ...
    'ylabel', {'density', '','','density', '',''});
plt.setup_pltparams('linewidth',1)
[ty, tm] = W_plt_JAGS.density(sp.thres_mu, rgr2)
for i =  [4 2 1]
plt.new;
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i} ,[],tm);
end
[ty, tm] = W_plt_JAGS.density(sp.noise, rgr2)
for i = [4 2 1]
plt.new;
% plt.setfig_ax('xlabel','');
plt.lineplot(ty{i},[],tm);
end
plt.update;
plt.save('within_simple');
%%
file = fullfile(hbidir, 'HBI_model_within_diff_within_all_samples.mat');
sp = importdata(file);
%%
plt.figure(2,1, 'istitle','rect', [0 0 0.2 0.6], 'gap', [0.2 0.15], ...
    'margin', [0.15 0.25 0.05 0.05]);
rgr = {[-5 5], [-5 5]};
rgr2 = -21:.01:21;
str1 = sprintf('%.2f samples < 0', mean(sp.dthres_mu <= 0, 'all')*100);
str2 = sprintf('%.2f samples < 0', mean(sp.dnoise_mu <= 0, 'all')*100);
plt.setfig_new;
plt.setfig('color', 'black', ...
    'xlim', rgr, ...
    'ylabel', 'density', 'xlabel', {'\Delta threshold','\Delta noise'},...
    'ylim', [0 1]);
plt.new;
[ty, tm] = W_plt_JAGS.density(sp.dthres_mu, rgr2)
plt.lineplot(ty ,[],tm);
hold on;
plot([0 0], [-100 100],'--r');
plt.new;
[ty, tm] = W_plt_JAGS.density(sp.dnoise_mu, rgr2)
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
%%
plt.figure(1,2);
% 'istitle','rect', [0 0 0.2 0.6], 'gap', [0.2 0.15], ...
%     'margin', [0.15 0.25 0.05 0.05]);
rgr = {[-1 6], [0 10]};
rgr2 = -21:.01:21;
str1 = sprintf('%.2f samples < 0', mean(sp.dthres_mu <= 0, 'all')*100);
str2 = sprintf('%.2f samples < 0', mean(sp.dnoise_mu <= 0, 'all')*100);
plt.setfig_new;
plt.setfig('color', {'AZblue50', 'AZblue', 'AZred50', 'AZred'}, ...
    'xlim', rgr, ...
    'ylabel', 'density', 'xlabel', {'threshold','noise'},...
    'ylim', {[0 0.7], [0 0.3]}, ...
    'legend', {'H = 1, free','H = 1, guided', 'H = 6, free', 'H = 6, guided'});
plt.new;
spt = sp.thres_mu;
spt(:,:,3) = squeeze(spt(:,:,1)) + sp.dthres_mu;
spt(:,:,4) = squeeze(spt(:,:,2)) + sp.dthres_mu;
[ty, tm] = W_plt_JAGS.density(spt, rgr2)
% [ty1] = W_plt_JAGS.density(repmat(sp.dthres_mu, 1,1,2), rgr2)
% ty = ty + ty1;
plt.lineplot(ty ,[],tm);
plt.new;
spt = sp.noise;
spt(:,:,3) = squeeze(spt(:,:,1)) + sp.dthres_mu;
spt(:,:,4) = squeeze(spt(:,:,2)) + sp.dthres_mu;
[ty, tm] = W_plt_JAGS.density(spt, rgr2)
% [ty, tm] = W_plt_JAGS.density(sp.noise(:,:,[1:2]), rgr2)
% [ty1] = W_plt_JAGS.density(sp.dnoise_mu, rgr2)
% ty = ty + ty1;
plt.lineplot(ty,[],tm);
plt.update;
plt.save('guidefree');
%%
% subplot(2,2,1);
% violin(reshape(sp2.thres_mu, [],4))
% ylim([0 5]);
% subplot(2,2,2);
% violin(reshape(sp1.thres_mu, [],3))
% ylim([0 5]);
% 
% subplot(2,2,3);
% violin(reshape(sp2.noise, [],4))
% ylim([0 10]);
% subplot(2,2,4);
% violin(reshape(sp1.noise, [],3))
% ylim([0 10]);
% 
% subplot(2,2,1);
% boxplot(reshape(sp2.thres_mu, [],4),'symbol', '')
% ylim([0 5]);
% subplot(2,2,2);
% boxplot(reshape(sp1.thres_mu, [],3),'symbol', '')
% ylim([0 5]);
% 
% subplot(2,2,3);
% boxplot(reshape(sp2.noise, [],4),'symbol', '')
% ylim([0 10]);
% subplot(2,2,4);
% boxplot(reshape(sp1.noise, [],3),'symbol', '')
% ylim([0 10]);
% 

% [tav, tse] = W.avse(st1.stats.mean.tthres');
% [tav2, tse2] = W.avse(st2.stats.mean.tthres');
% plt.new;
% plt.lineplot(tav, tse, [1 6 15]);
% plt.lineplot(tav2, tse2, [1 2 5 10]);
% [tav, tse] = W.avse(st1.stats.mean.tnoise');
% [tav2, tse2] = W.avse(st2.stats.mean.tnoise');
% plt.new;
% plt.lineplot(tav, tse, [1 6 15]);
% plt.lineplot(tav2, tse2, [1 2 5 10]);