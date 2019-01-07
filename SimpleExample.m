function [rmse, RE, tE, scaleE] = SimpleExample( benchmark, mocapRaw )
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

[ rmse, RE, tE, scaleE ] = AlignSimEfficient( gtPos(:,2:4), lsdOpt(:,2:4) );


if(isnan(rmse) || isnan(scaleE))
    return 
end

% get sequence aligned by EVAL.
lsdPos_aligned = scaleE * lsdOpt(:,2:4) * RE' + repmat(tE', size(lsdOpt,1), 1);

close all;
% you can plot the lsdPos_aligned and gtPos to check.
figure (1);
hold on;
plot3(lsdPos_aligned(:,1),lsdPos_aligned(:,2),lsdPos_aligned(:,3),'r','LineWidth',1);
plot3(gtPos(:,2),gtPos(:,3),gtPos(:,4),'k','LineWidth',1);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');

hold on;

figure(2)
hold on;
plot3(lsdOpt(:,2),lsdOpt(:,3),lsdOpt(:,4),'r','LineWidth',1);
plot3(mocapRaw(:,2),mocapRaw(:,3),mocapRaw(:,4),'k','LineWidth',1);

