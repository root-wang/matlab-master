function [outputData] = pseudoRandomScrambling(inputData)
%% Î±Ëæ»ú¼ÓÈÅ

len = length(inputData);
repeatTimes = floor(len/256);
lastNum = mod(len,256);

randomCode = [0 2 4 3 3 6 4 5 7 6 7 0 5 5 4 3 5 4 3 7 0 7 6 2 6 2 4 6 7 2 4 7 5 5 7 0 7 3 3 3 7 3 3 1 4 2 3 7 0 2 7 7 3 5 1 0 1 4 0 5 0 0 0 0 6 5 0 1 2 7 6 5 5 2 7 3 3 3 2 1 2 5 6 1 3 4 2 1 0 1 2 3 6 4 7 5 2 2 6 2 7 6 5 2 4 6 5 4 7 2 5 1 0 0 7 7 3 5 4 2 1 4 2 7 0 3 4 5 0 0 7 7 3 5 4 2 1 4 2 7 0 3 4 0 1 0 5 2 6 0 3 5 1 0 5 1 5 2 5 6 3 2 3 7 1 2 2 0 7 1 3 6 4 2 6 2 7 4 3 7 6 7 2 3 1 7 4 1 5 1 5 4 7 1 1 2 3 6 7 7 6 6 1 2 2 4 1 7 7 5 5 4 7 7 5 0 7 3 7 5 7 7 5 0 6 6 6 1 3 4 4 4 0 3 3 2 1 4 5 4 5 3 1 1 1 2 5 1 7 1 5 7 2 0 0 6];
allRandomCode = [];

for i = 1:repeatTimes
    allRandomCode = [allRandomCode,randomCode];
end
allRandomCode = [allRandomCode,randomCode(1:lastNum)];

outputData = mod(inputData+allRandomCode,8);

end

