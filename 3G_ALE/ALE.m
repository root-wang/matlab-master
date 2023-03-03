clc;
close all;
clear all;
ALE_CODE = [];
for repeatFrame = 1:5
%%
source_number = 26;
source = randi([0 1],1,source_number);
%% Convolutional Encoding
enCodeData = convenCode(7,source);

%% Interleaving Encoding
interleavingenCodeData = interleavingenCode(enCodeData);

%% Walsh Orthogonal Spreading Spectrum 
spectrumData = walshSpectrum(interleavingenCodeData);

%% Pseudo Random Scrambling
scrambledCode = pseudoRandomScrambling(spectrumData);


%% 组帧

%% 保护序列
protectCode = [2 6 1 6 1 6 3 0 6 0 1 1 5 0 0 6 2 6 2 1 6 2 3 2 7 6 4 3 0 2 3 5 2 7 5 1 5 1 7 6 1 7 1 5 4 4 0 7 2 2 6 2 2 2 6 3 3 3 7 7 3 2 4 5 0 7 4 7 7 7 2 3 1 6 7 6 5 7 0 5 1 0 7 6 2 4 0 2 7 5 5 4 1 5 1 5 6 7 3 0 2 7 6 6 4 0 7 4 3 2 2 6 6 7 4 7 2 0 2 7 2 1 5 4 6 2 3 2 1 6 0 7 1 1 2 6 2 2 0 2 2 3 6 7 1 7 1 7 1 5 7 7 2 2 2 0 4 3 4 2 0 6 7 6 0 5 0 7 1 7 4 1 2 3 4 6 7 2 2 0 6 4 4 6 6 4 2 2 6 5 3 4 2 3 5 7 7 1 0 0 0 3 1 2 0 1 6 2 7 4 4 3 2 5 4 5 6 4 2 5 6 2 2 4 7 0 6 2 3 7 2 5 4 2 4 1 5 5 3 6 1 1 3 2 7 5 7 0 7 3 5 0 0 1 2 0]; 

%% 探测报头序列
detectionCode = [7 7 7 7 5 4 3 1 1 2 0 2 7 2 2 0 1 3 4 7 5 3 7 7 4 3 1 0 1 1 5 2 1 6 0 0 4 7 6 2 2 3 6 0 5 1 7 6 1 6 1 7 6 6 6 1 7 3 0 4 7 1 2 2 3 3 6 7 7 1 7 3 1 5 0 3 3 4 5 2 5 2 5 3 1 7 2 1 5 7 6 1 2 5 3 5 3 6 2 0 7 5 6 6 0 1 4 2 5 4 1 1 7 0 0 6 6 7 5 6 3 7 4 0 2 6 3 6 4 5 1 0 0 4 5 5 4 7 1 5 1 5 6 7 3 3 5 2 2 2 7 2 3 3 0 4 1 4 1 3 6 0 7 2 6 1 5 0 1 4 1 1 7 0 7 4 0 2 4 5 3 0 0 3 1 2 6 4 6 5 2 6 0 0 7 3 5 3 4 0 6 2 7 4 3 3 7 6 7 1 0 0 6 7 3 1 5 5 0 2 3 4 2 7 7 4 5 2 1 6 1 0 4 7 1 6 1 2 4 0 3 6 5 4 5 4 4 6 1 2 5 1 3 6 2 7 2 6 7 4 7 3 0 1 5 0 5 3 4 5 0 7 3 2 7 0 3 2 7 0 6 1 6 7 7 1 4 2 6 7 7 4 2 7 2 7 3 7 6 3 2 6 5 6 6 3 6 6 4 1 0 6 2 6 4 1 5 5 4 3 3 4 6 3 5 2 4 1 1 7 5 3 7 1 6 5 4 6 6 2 3 4 2 3 3 7 4 1 4 4 5 4 6 1 3 4 6 1 7 4 1 3 5 2 6 5 5 4 2 1 5 1 6 1 2 7 1 4 4 2 3 4 7 3]; 

combinedCode = [protectCode,detectionCode,scrambledCode];
enCodeData =[];
for i = 1:length(combinedCode)
    tmpData = oct2bin(combinedCode(i));
    enCodeData = [enCodeData,tmpData];
end
ALE_CODE = [ALE_CODE,enCodeData];
end
save('ALE_CODE.mat','ALE_CODE');

