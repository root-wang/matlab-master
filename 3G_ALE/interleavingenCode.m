function [outputData] = interleavingenCode(inputData)
%INTER 此处显示有关此函数的摘要
L = length(inputData);

frameNums = L / 52;
outputData = [];
for i = 1:frameNums
   frameData = inputData((i-1)*52+1:i*52);
   tempData(1,:) = frameData(1:13);
   tempData(2,:) = frameData(14:26);
   tempData(3,:) = frameData(27:39);
   tempData(4,:) = frameData(40:52);

   for k = 1:13
       outputData = [outputData,transpose(tempData(:,k))];
   end
end
end

