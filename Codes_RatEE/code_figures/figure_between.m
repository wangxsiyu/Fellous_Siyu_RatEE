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