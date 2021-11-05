%% load datadir
datadir = '../../data_processed/bayesdata';
[~,datalists] = W.dir(fullfile(datadir, '*.mat'));
%%
% tid = contains(datalists.folder_name, {'within'});
% datalists = datalists(tid,:);
%% setup full path
fullpt = '/Users/wang/WANG/Fellous_Siyu_RatEE/Codes_RatEE/code_bayesian/models';
outputdir = '/Users/wang/WANG/Fellous_Siyu_RatEE/result_bayes';
%%
mi = 0;
% mi = mi + 1;
% modelname{mi} = 'model_simple.txt';
% params{mi} = {'noise_k','noise_lambda', 'noise', ...
%     'thres_mu', 'thres_sigma', ...
%     'tnoise','tthres'};
% init0{mi} = struct;

mi = mi + 1;
modelname{mi} = 'model_rat.txt';
params{mi} = {'noise_k','noise_lambda', 'noise', ...
    'thres_a', 'thres_b', 'thres', ...
    'dQ', 'P','tnoise','tthres','dthres', 'dnoise'};
init0{mi} = struct;

mi = mi + 1;
modelname{mi} = 'model_rat.txt';
params{mi} = {'noise_k','noise_lambda', 'noise', ...
    'thres_a', 'thres_b', 'thres', ...
    'dQ', 'P','tnoise','tthres','dthres', 'dnoise'};
%     'thres_mu', 'thres_sigma', ...
init0{mi} = struct;
% mi = mi + 1;
% modelname{mi} = 'model_within_diff.txt';
% params{mi} = {'noise_k','noise_lambda', 'noise', ...
%     'thres_mu', 'thres_sigma', ...
%     'dQ', 'P','tnoise','tthres','dthres_mu', 'dnoise_mu','dthres_sigma','dnoise_sigma',...
%     'tdthres','tdnoise'};
% init0{mi} = struct;
% 
% mi = mi + 1;
% modelname{mi} = 'model_lapse_2x2.txt';
% params{mi} = {'noise_k','noise_lambda', 'noise', ...
%     'thres_mu', 'thres_sigma', ...
%     'dQ', 'P','tnoise','tthres','dthres', 'dnoise', ...
%     'u','v','a','b','tlapse','dlapse'};
% init0{mi} = struct;
% 
% mi = mi + 1;
% modelname{mi} = 'model_within_H.txt';
% params{mi} = {'noise_k','noise_lambda', 'noise', ...
%     'thres_mu', 'thres_sigma', 'prior_a', 'prior_b', 'prior', 'a0', 'b0','alpha', ...
%     'tnoise','tthres', 'tprior', 'talpha' ...
%     'dnoise','dthres','dalpha'};
% init0{mi} = struct;
%%
datalists.modeli(:,1) = 1;
datalists(datalists.folder_name == "bayes_human_full.mat",:).modeli = 2;
%% setup JAGS/params
wj = W_JAGS();
wj.isoverwrite = true;
% wj.setup_params;
wj.setup_params(4, 3000, 5000);
%% run select
wselect = 2; %mi;%1:mi;
%% run models
for di = 1:size(datalists,1)
    %% load data
    bayesdata = importdata(fullfile(datalists.folder_path(di), datalists.folder_name(di)));
    wj.setup_data_dir(bayesdata.bayesdata, outputdir);
    %% run
    mmi = datalists.modeli(di);
%     for mmi = wselect
        try
            disp(sprintf('running dataset %d, model %d: %s', di, mmi,modelname{mmi}));
            outfile = W.file_deext(datalists.folder_name(di));
            outfile = replace(outfile, 'bayes_', replace(modelname{mmi},'.txt','_'));
            wj.setup(fullfile(fullpt, modelname{mmi}), params{mmi}, init0{mmi}, outfile);
            wj.run;
        catch
            warning('!!!!!!!!!!!!!!!!!!failed');
        end
%     end
end