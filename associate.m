 function [lsdPos,gtwithTime ] = associate( lsdTme,lsdPos,mocapRaw )
% the timestamp of mocapRaw should be more dense than lsdPos 

    gtPos = zeros(size(lsdTme,1),3);
    gtID = 1;
    for i=1:size(lsdTme,1)
        while(lsdTme(i) - mocapRaw(gtID,1) > 0.01)
            gtID = gtID+1;
            if(gtID > size(mocapRaw,1))
                'ERROR, cannot associate frame well' 
                break;
            end
        end
        if(gtID > size(mocapRaw,1))
           break; 
        end
        if(abs(lsdTme(i) - mocapRaw(gtID,1)) > 0.05)
            'ERROR, cannot associate frame well'
        end
        gtPos(i,1:3) = mocapRaw(gtID,2:4);
    end

    goodIDX = ~isnan(gtPos(:,1)) & ~isnan(lsdPos(:,1));
    gtposfilter = gtPos(goodIDX,:);
    
    lsdPos = lsdPos(goodIDX,:);
    lsdTme = lsdTme(goodIDX,:);
    gtwithTime = zeros(size(gtposfilter,1),4);
    gtwithTime(:,2:4) = gtposfilter;
    gtwithTime(:,1) = lsdTme;
    
 end