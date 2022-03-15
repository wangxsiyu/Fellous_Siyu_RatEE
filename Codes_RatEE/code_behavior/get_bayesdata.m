function get_bayesdata(data, savename)
    bayesdata = [];
    bayesdata.nG = size(data,1);
    rats = unique(data.rat);
    bayesdata.nR = length(rats);
    bayesdata.h = data.bayes_horizon;
    bayesdata.h = W.getrank(bayesdata.h);
    bayesdata.gd = data.cond_guided;
    bayesdata.gd = W.getrank(bayesdata.gd);
    bayesdata.nH = max(bayesdata.h);
    bayesdata.ngd = max(bayesdata.gd);
    bayesdata.r = data.r_guided;
    bayesdata.c = data.c1_cc_explore;
    bayesdata.sideguided = sign(data.side_guided- 1.5);
    bayesdata.rats = cellfun(@(x)find(strcmp(x, rats)), data.rat);
    save(savename, 'bayesdata','rats');
end