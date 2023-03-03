clc;
close all;
clear all;
frameCode = [];

for i = 1:100
    %% 前导训练序列
    preambleCode = preamble();

    %% 头字段
    headerData = header();

    %% CDS数据字段
    CDSData = CDS_DATA();

    % EOM
    EOMData = EOM();
    frameCode = [frameCode, preambleCode, headerData, CDSData, EOMData];
end

Link11_SLEW = [];

for i = 1:length(frameCode)
    tmpData = oct2bin(frameCode(i));
    Link11_SLEW = [Link11_SLEW, tmpData];
end


save('Link11_SLEW.mat', 'Link11_SLEW');
