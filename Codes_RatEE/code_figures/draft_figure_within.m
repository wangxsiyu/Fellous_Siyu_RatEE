%% figure
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'within');
plt.setuserparam('param_setting', 'isshow', 1);
%% color/legend
% %% by trial number
% plt.setfig_new;
% plt.setfig_loc(2,'xlim', [0.5 6.5], 'ylim', {[0.5 0.8], [0 1]} , ...
%     'ytick', {0.5:0.1:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', {'SouthEast', 'NorthEast'});
% plt = fig_behavior_gp(plt, gp, 'av', 'trial number', col, ...
%     leg, ['gp_av']);
% %% split by good/bad
% % plt.setfig_loc(2,'xlim', xlm, 'ylim', {[0.4 1], [0 1]},'legloc', {'NorthWest', 'NorthEast'});
% % plt = fig_behavior_gp(plt, gp, 'gp_av', 'trial number', col2, ...
% %     leg2, ['gp_acG']);
% %% R curve
% plt.setfig_new;
% plt.setfig_loc(2,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
%     'ylim', {[0 1],[0 1]}, 'ytick', {0:0.2:1, 0:0.2:1}, 'legord', 'reverse', 'legloc', 'SouthWest');
% plt = fig_behavior_gp(plt, gp, 'bin_all', 'R guided', col , ...
%     leg, ['gp_rG']);
%% average curve
% gds = [0 1 3];
% tlt = W.arrayfun(@(x)sprintf('nGuided = %d', x), gds);
% nfig = length(gds);
% plt.figure(1,nfig, 'istitle', 'margin', [0.2 0.07 0.1 0.01],'gap',[0.05 0.07]);
% plt.setfig_new;
% col = {'AZred', 'AZblue'};
% plt.setfig(nfig,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
%     'ylim', [0.5 .8], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
%     'color', col, ...
%     'xlabel', 'R guided', ...
%     'ylabel', 'p(explore)', 'legend', {'H = 6', 'H = 1'}, ...
%     'title', tlt);
% tp = gp.av_av_cc_best;
% tp_se = gp.ste_av_cc_best;
% for i = 1:length(gds)
%     plt.ax(1,i);
%     tid = gp.av_cond_guided == gds(i);
%     plt.lineplot(tp(tid,:), tp_se(tid,:));
% end
% plt.update;
% plt.save('av_best_horizon');
%% r curve
gds = [0 1 3];
tlt = W.arrayfun(@(x)sprintf('nGuided = %d', x), gds);
nfig = length(gds);
plt.figure(1,nfig, 'istitle', 'margin', [0.2 0.07 0.1 0.01],'gap',[0.05 0.07]);
plt.setfig_new;
col = {'AZred', 'AZblue'};
plt.setfig(nfig,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', col, ...
    'xlabel', 'R guided', ...
    'ylabel', 'p(explore)', 'legend', {'H = 6', 'H = 1'}, ...
    'title', tlt);
tp = gp.av_bin_all_cc_switch;
tp_se = gp.ste_bin_all_cc_switch;
for i = 1:length(gds)
    plt.ax(1,i);
    tid = gp.av_cond_guided == gds(i);
    plt.lineplot(tp(tid,:), tp_se(tid,:));
end
plt.update;
plt.save('rcurve_explore_horizon');
%% guided vs free
plt = W_plt('fig_dir', '../../figures','fig_projectname', 'guidefree');
%% guided vs free
plt.figure(1,2);
plt.setfig_new;
col = {'AZred','AZred50','AZblue','AZblue50'};
plt.setfig(2,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 1:6, ...
    'ylim', {[0.4 0.8],[0 0.8]}, 'ytick', {0:0.1:1, 0:0.2:1},'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', col, ...
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
plt.update;
plt.save('basic');
%% guided vs free - rcurve
hzs = [1 6];
tlt = W.arrayfun(@(x)sprintf('H = %d', x), hzs);
nfig = length(hzs);
plt.figure(1,nfig, 'istitle', 'margin', [0.2 0.07 0.1 0.01],'gap',[0.05 0.07]);
plt.setfig_new;
col = {{'AZblue', 'AZblue50'},{'AZred', 'AZred50'}};
plt.setfig(nfig,'xlim', [0.5 6.5], 'xtick', 1:6, 'xticklabel', 0:5, ...
    'ylim', [0 1], 'ytick', 0:0.2:1, 'legord', 'reverse', 'legloc', 'SouthWest',...
    'color', col, ...
    'xlabel', 'R guided', ...
    'ylabel', 'p(explore)', 'legend', {{'guided', 'free'},{'guided', 'free'}}, ...
    'title', tlt);
tp = gp.av_bin_all_cc_switch;
tp_se = gp.ste_bin_all_cc_switch;
for i = 1:length(hzs)
    plt.ax(1,i);
    tid = gp.av_cond_horizon == hzs(i) & gp.av_cond_guided <= 1;
    plt.lineplot(tp(tid,:), tp_se(tid,:));
end
plt.update;
plt.save('rcurve_explore');
