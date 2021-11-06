
%%
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'control');
plt.setuserparam('param_setting', 'isshow', 1);
%%
col = {'AZred', 'AZsand'};
leg = {'contant reward', 'random reward'};
plt.setfig_new;
plt.setfig_loc(2,'xlim', [0.5 6.5], 'ylim', {[0.4 1], [0 1]} , ...
    'ytick', {0.5:0.1:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', {'SouthEast', 'NorthEast'});
plt = fig_behavior_gp(plt, gp, 'av', 'trial number', col, ...
    leg, ['gp_av']);
plt.setfig_new;
plt.setfig_loc(2,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', {[0 1],[0 1]}, 'ytick', {0:0.2:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', 'SouthWest');
plt = fig_behavior_gp(plt, gp, 'bin_all', 'R guided', col , ...
    leg, ['gp_rG']);


%% long 01

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