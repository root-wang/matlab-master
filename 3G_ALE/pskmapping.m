function [ Isym , Qsym ] = pskmapping( data , signal_type )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
a = 0.05;%非均衡因子
N_data = length(data);

switch signal_type
    case 0
        dataIQ = reshape(data*2-1,2,N_data/2);
        Isym = sqrt(2)/2*dataIQ(1,:);
        Qsym = sqrt(2)/2*dataIQ(2,:);
    case 1
        dataIQ = reshape(data*2-1,2,N_data/2);
        Isym = sqrt(2)/2*dataIQ(1,:);
        Qsym = sqrt(2)/2*dataIQ(2,:);
    case 2
        dataIQ = reshape(data*2-1,2,N_data/2);
        Isym = sqrt(a)*sqrt(2)/2*dataIQ(1,:);
        Qsym = sqrt(1-a)*sqrt(2)/2*dataIQ(2,:);
    case 3
        theta = zeros(1,N_data/3);
        theta_n = data(1:3:end)*4+data(2:3:end)*2+data(3:3:end);
        for i = 1:length(theta_n)
          if theta_n(i) == 0
              theta(i) = 0;
          elseif theta_n(i) == 1
              theta(i) = pi/4;
          elseif theta_n(i) == 2
              theta(i) = -pi/4;
          elseif theta_n(i) == 3
              theta(i) = pi/2;
          elseif theta_n(i) == 4
              theta(i) = -3*pi/4;
          elseif theta_n(i) == 5
              theta(i) = pi;
          elseif theta_n(i) == 6
              theta(i) = -pi/2;
          else
              theta(i) = 3*pi/4;
          end
        end
        Isym = cos(theta);
        Qsym = sin(theta);
end
end

