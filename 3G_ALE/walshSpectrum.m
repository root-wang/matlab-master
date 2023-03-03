function [specData] = walshSpectrum(inputData)
%WALSHSPECTRUM 此处显示有关此函数的摘要
L = length(inputData);
spectrumFrameNums = L/4;

specData = [];

for i  =1:spectrumFrameNums
    frameData = inputData((i-1)*4+1:i*4);
    frameDataStr = mat2str(frameData);
    switch frameDataStr
          case '[0 0 0 0]'   
              for repeatTimes = 1:4
                specData = [specData,0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]; 
              end
         case '[0 0 0 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 0 4 0 4 0 4 0 4 0 4 0 4 0 4]; 
             end
         case '[0 0 1 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 4 4 0 0 4 4 0 0 4 4 0 0 4 4]; 
             end
         case '[0 0 1 1]' 
             for repeatTimes = 1:4
                specData = [specData,0 4 4 0 0 4 4 0 0 4 4 0 0 4 4 0]; 
             end
         case '[0 1 0 0]'  
             for repeatTimes = 1:4
                specData = [specData,0 0 0 0 4 4 4 4 0 0 0 0 4 4 4 4]; 
            end
         case '[0 1 0 1]'  
             for repeatTimes = 1:4
                specData = [specData,0 4 0 4 4 0 4 0 0 4 0 4 4 0 4 0];
             end
         case '[0 1 1 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 4 4 4 4 0 0 0 0 4 4 4 4 0 0]; 
             end
         case '[0 1 1 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 4 0 4 0 0 4 0 4 4 0 4 0 0 4]; 
             end
         case '[1 0 0 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 0 0 0 0 0 0 4 4 4 4 4 4 4 4]; 
             end
         case '[1 0 0 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 0 4 0 4 0 4 4 0 4 0 4 0 4 0];
             end 
         case '[1 0 1 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 4 4 0 0 4 4 4 4 0 0 4 4 0 0];
             end
         case '[1 0 1 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 4 0 0 4 4 0 4 0 0 4 4 0 0 4]; 
             end
         case '[1 1 0 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 0 0 4 4 4 4 4 4 4 4 0 0 0 0]; 
             end
         case '[1 1 0 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 0 4 4 0 4 0 4 0 4 0 0 4 0 4];
             end
         case '[1 1 1 0]'   
             for repeatTimes = 1:4
                specData = [specData,0 0 4 4 4 4 0 0 4 4 0 0 0 0 4 4]; 
             end
         case '[1 1 1 1]'   
             for repeatTimes = 1:4
                specData = [specData,0 4 4 0 4 0 0 4 4 0 0 4 0 4 4 0]; 
             end
    end
end
end

