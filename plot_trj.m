clc;clf;clear;
filename = './groundtruth.txt';
trj = importdata(filename);

figure (1);
plot(trj(:,2),trj(:,3),'k','LineWidth',2);

xlabel('x [m]');
ylabel('y [m]');

hold on;

n = size(trj,1);
sum_t = 0;
time = 0;
sum_deg = 0;
for i = 1:n-1
    sum_t = sum_t + norm(trj(i,2:4)-trj(i+1,2:4));
    time = time + trj(i+1,1)- trj(i,1);
    
    R_i = quat2dcm((trj(i,5:8)));
    R_ii = quat2dcm((trj(i+1,5:8)));
    
    R_it = R_ii'*R_i;
    rod = dcm2rod(R_it);
    theta = norm(rod)/pi*180;
    sum_deg = sum_deg+theta;
end
vel_t = sum_t/time;
vel_deg = sum_deg/time;
