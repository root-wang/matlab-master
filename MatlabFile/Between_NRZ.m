function [data_d ] = Between_NRZ( data,Tbnumber )
% ���������н���˫����NRZ����
data_d=[];
for n=1:length(data)
    if data(n)==1
        data_d=[data_d ,ones(1,floor(Tbnumber))];
    else
        data_d=[data_d ,-ones(1,floor(Tbnumber))];
    end
end