function [rmse, RE, tE, scaleE] = simpleexample( benchmark, mocapRaw )
% benchmark: path to the file waiting for evaluating, mocapRaw: groundtruth

lsdOpt = importdata([benchmark]);

[ gtPos,lsdOpt ] = associate( mocapRaw(:,1), mocapRaw, lsdOpt );

if(size(lsdOpt,1)==0)
    ['NO DATAA ' sequencename]
    return
end

if(abs(mocapRaw(1,1) - lsdOpt(1,1)) > 1000)
    lsdOpt(:,1) = 2e9-lsdOpt(:,1);
end


[A B] = sort(lsdOpt(:,1));
lsdOpt = lsdOpt(B,:);

if sum(sum(isnan(lsdOpt))) > 0
    ['IS NAN' sequencename]
    return
end

[ rmse, RE, tE, scaleE ] = AlignSimEfficient( gtPos, lsdOpt );


if(isnan(rmse) || isnan(scaleE))
    return
end

% get sequence aligned by EVAL.
lsdPos_aligned = scaleE * lsdOpt * RE' + repmat(tE', size(lsdOpt,1), 1);

% you can plot the lsdPos_aligned and gtPos to check.


